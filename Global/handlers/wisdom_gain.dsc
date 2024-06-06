passive_knowledge_gain:
  type: world
  debug: false
  events:
    on system time minutely:
      - foreach <server.online_players.filter[gamemode.equals[adventure]].filter[has_flag[character.god].not]>:
        - flag <[value]> character.knowledge.timer:+:1
        - if <[value].flag[character.knowledge.timer]> >= 20:
          - run knowledge_point_give def:1 player:<[value]>
          - flag <[value]> character.knowledge.timer:0

knowledge_point_give:
  type: task
  debug: false
  definitions: amount|target
  script:
    - define target <player> if:<[target].exists.not>
    - flag <[target]> character.knowledge.current:+:<[amount]>
    - flag <[target]> character.knowledge.total:+:<[amount]>
    - narrate "<&e>You have gained <[amount]> Knowledge Point<&nl><&6>You now have <[target].flag[character.knowledge.current]> Knowledge Point(s) to spend." targets:<[target]>

use_knowledge_points:
  type: command
  debug: false
  name: learn
  usage: /learn (amount) (skill) from (target)
  description: spend knowledge points to learn a capability
  tab completions:
    1: (amount)|5|10|25|50|100
    2: <player.flag[character.capabilities].keys>
    3: from
    4: <player.target.flag[data.name]||target>
  script:
    - if <context.args.get[5]||null> != null:
      - define user <server.match_player[<context.args.get[5]>]||null>
      - if <[user]> == null:
        - stop
      - adjust <queue> linked_player:<[user]>
    - inventory close
    - if <context.args.size> < 4:
      - narrate "<&c>Not enough arguments"
      - stop
    - define amount <context.args.get[1]>
    - define capability <context.args.get[2].to_titlecase>
    - define target <context.args.get[4]>
    - if !<[amount].is_integer>:
      - narrate "<&c>Invalid Amount<&co> <&e><[amount]>"
      - stop
    - if <player.flag[character.capabilities.<[capability]>].add[<[amount]>]> > 500:
      - narrate "<&c>You too proficient to learn that much knowledge in <[capability]>."
      - stop
    - if <[target]> == target:
      - define target <player.target||null>
    - else:
      - define target <server.flag[name_map.<[target]>]||null>
    - if <[target]> == null:
      - narrate "<&c>Unknown Target<&co> <&e><[target]>"
      - stop
    - if <[target].entity_type> != PLAYER:
      - if !<[target].has_flag[tutor]> || !<[target].flag[tutor].contains[<[capability]>]>:
        - narrate "<&c>They cannot teach you<&co> <&e><[capability]>"
      - else if <script[capabilities_data].parsed_key[capability.<[capability]>.entrance_fee].exists> && !<player.has_flag[character.capabilities_enabled.<[capability]>]>:
        - narrate "<&c>You lack the capability to learn this."
      - else:
        - run spend_knowledge_point def:<[capability]>|<[amount]>
    - else:
      - if !<[target].has_flag[character.god]>:
        - if <[target].location.distance[<player.location>]> > 5:
          - narrate "<&c>They are too far away to teach you this."
          - stop
        - if <[target].flag[character.capabilities.<[capability]>]> > <player.flag[character.capabilities.<[capability]>].add[<[amount].mul[2]>]>:
          - narrate "<&c>They are not skilled enough to teach you more <&co> <&e><[capability]>"
          - stop
      - flag <player> temp.teaching_request:<[amount]>$<[capability]>
      - narrate "<&e>You request <[target].flag[character.name.full_display]> to teach you <[amount]> knowledge of <[capability]>"
      - narrate "<&e><player.flag[character.name.full_display]> has requested you to teach them <[amount]> knowledge of <[capability]><&nl><&a><element[Accept].on_click[/confirm_teaching <player.name>]>" targets:<[target]>

confirm_learning:
  type: command
  debug: false
  name: confirm_teaching
  usage: /confirm_teaching (player)
  description: Allow a player to learn from you.
  script:
    - define target <server.match_player[<context.args.get[1]>]||null>
    - if <[target]> == null:
      - narrate "<&c>They have not asked you for training."
      - stop
    - if !<[target].has_flag[temp.teaching_request]>:
      - narrate "<&c>They have not asked you for training."
      - stop
    - if !<player.has_flag[character.god]> && <[target].location.distance[<player.location>]> > 5:
      - narrate "<&c>They are too far away for you to teach them."
      - stop
    - define amount <[target].flag[temp.teaching_request].before[$]>
    - define skill <[target].flag[temp.teaching_request].after[$]>
    - narrate "<&e>You begin the lesson of <[skill]>" targets:<[target]>|<player>
    - run start_timed_action "def:<&e>Teaching <[skill].replace[_].with[<&sp>].to_titlecase>|<[amount].mul[3]>s|knowledge_point_spent_teacher|<[skill]>$<[amount]>" def.distance_from_origin:2 def.cancel_script:teaching_cancel_other
    - run start_timed_action "def:<&e>Learning <[skill].replace[_].with[<&sp>].to_titlecase>|<[amount].mul[3]>s|knowledge_point_spent_doubled|<[skill]>$<[amount]>" def.distance_from_origin:2 def.cancel_script:teaching_cancel_other player:<[target]>
    - flag <[target]> temp.timed_action.teaching:<player>
    - flag <player> temp.timed_action.teaching:<[target]>

teaching_cancel_other:
  type: task
  debug: false
  script:
    - define target <player.flag[temp.timed_action.teaching]>
    - flag <player> temp.timed_action:!
    - flag <player> timed_action:!
    - flag <[target]> temp.timed_action:!
    - flag <[target]> timed_action:!

check_knowledge_points:
  type: command
  debug: false
  name: knowledge
  usage: /knowledge
  description: see how many knowledge points you have
  script:
    - narrate "<&6>Knowledge Points<&co> <&e><player.flag[character.knowledge.current]>"
    - narrate "<&6>Knowledge Points Lifetime Total<&co> <&e><player.flag[character.knowledge.total]>"

spend_knowledge_point:
  type: task
  debug: false
  definitions: skill|amount
  script:
    - if <player.flag[character.knowledge.current]> < <[amount]>:
      - narrate "<&c>You only have <player.flag[character.knowledge.current]> knowledge to spend."
      - stop
    - run start_timed_action "def:<&e>Learning <[skill].replace[_].with[<&sp>].to_titlecase>|<[amount].mul[3]>s|knowledge_point_spent|<[skill]>$<[amount]>" def.distance_from_origin:1

knowledge_point_spent:
  type: task
  debug: false
  definitions: skill_amount
  script:
    - define skill <[skill_amount].before[$]>
    - define amount <[skill_amount].after[$]>
    - if <player.flag[character.knowledge.current]> < <[amount]>:
      - stop
    - flag <player> character.capabilities.<[skill]>:+:<[amount]>
    - flag <player> character.knowledge.current:-:<[amount]>
    - narrate "<&e>---------------------<&nl>You have spent <[amount]> Knowledge Point(s)<&nl><&6>You now have <player.flag[character.knowledge.current]> Knowledge Point(s) left to spend.<&nl><&e>You now have <player.flag[character.capabilities.<[skill]>]> points in <[skill].to_titlecase>.<&nl><&e>---------------------"
    - run knowledge_point_check def:<[skill]>|<[amount]> if:<script[capabilities_data].data_key[capability.<[skill]>.check_on_knowledge_gain].exists>

knowledge_point_spent_doubled:
  type: task
  debug: false
  definitions: skill_amount
  script:
    - if <player.has_flag[temp.timed_action.teaching]>:
      - narrate "<&c>The teaching session was interrupted"
      - stop
    - define skill <[skill_amount].before[$]>
    - define amount <[skill_amount].after[$]>
    - if <player.flag[character.knowledge.current]> < <[amount]>:
      - stop
    - flag <player> character.capabilities.<[skill]>:+:<[amount].mul[2]>
    - flag <player> character.knowledge.current:-:<[amount]>
    - narrate "<&e>---------------------<&nl>You have spent <[amount]> Knowledge Point(s)<&nl><&6>You now have <player.flag[character.knowledge.current]> Knowledge Point(s) left to spend.<&nl><&e>You now have <player.flag[character.capabilities.<[skill]>]> points in <[skill].to_titlecase>.<&nl><&e>---------------------"
    - run knowledge_point_check def:<[skill]>|<[amount]> if:<script[capabilities_data].data_key[capability.<[skill]>.check_on_knowledge_gain].exists>

knowledge_point_spent_teacher:
  type: task
  debug: false
  definitions: skill_amount
  script:
    - if <player.has_flag[temp.timed_action.teaching]>:
      - narrate "<&c>The teaching session was interrupted"
      - stop
    - define skill <[skill_amount].before[$]>
    - define amount <[skill_amount].after[$]>
    - if <player.flag[character.knowledge.current]> < <[amount]>:
      - stop
    - if <player.flag[character.capabilities.<[skill]>].add[<[amount]>]> > 500:
      - if <player.flag[character.capabilities.<[skill]>]> == 500:
        - narrate "<&e>You gain no benefit, as you are already at the highest tier of capability in <[skill]>."
        - stop
      - else:
        - define amount <element[500].sub[<player.flag[character.capabilities.<[skill]>]>]>
    - flag <player> character.capabilities.<[skill]>:+:<[amount]>
    - narrate "<&e>---------------------<&nl><&e>You now have <player.flag[character.capabilities.<[skill]>]> points in <[skill].to_titlecase>, as a result of teaching experience<&nl><&e>---------------------"
    - run knowledge_point_check def:<[skill]>|<[amount]> if:<script[capabilities_data].data_key[capability.<[skill]>.check_on_knowledge_gain].exists>

knowledge_point_check:
  type: task
  debug: false
  definitions: capability|amount
  script:
    - define oldCap <player.flag[character.capabilities.<[capability]>].sub[<[amount]>]>
    - define newCap <player.flag[character.capabilities.<[capability]>]>
    - if <[newCap]> == 500:
      - narrate "<&a>You have maximized your capability in <[capability]>, Congratulations!!!"
    - define listToRun <list>
    - foreach <script[capabilities_data].data_key[capability.<[capability]>.checks].keys> as:benefit:
      - if <script[capabilities_data].data_key[capability.<[capability]>.checks.<[benefit]>]> > <[oldCap]> && <[newCap]> <= <script[capabilities_data].data_key[capability.<[capability]>.checks.<[benefit]>]>:
        - define listToRun <[listToRun].include[<[benefit]>]>
    - if !<[listToRun].is_empty>:
      - wait 1t
      - foreach <[listToRun]>:
        - run <[value]>