passive_knowledge_gain:
  type: world
  debug: false
  events:
    on system time minutely:
      - foreach <server.online_players>:
        - flag <[value]> character.knowledge.timer:+:1
        - if <[value].flag[character.knowledge.timer]> >= 20:
          - flag <[value]> character.knowledge.current:+:1
          - flag <[value]> character.knowledge.total:+:1
          - flag <[value]> character.knowledge.timer:0
          - narrate "<&e>You have gained 1 Knowledge Point<&nl><&6>You now have <[value].flag[character.knowledge.current]> Knowledge Point(s) to spend." targets:<[value]>

spend_knowledge_point:
  type: task
  debug: false
  definitions: skill|amount
  script:
    - if !<script[capability_data].data_key[capabilities.<[skill]>].exists>:
      - stop
    - run start_timed_action "def:<&e>Learning <[skill].to_titlecase>|<[amount]>s|knowledge_point_spent|<[skill]>_<[amount]>

knowledge_point_spent:
  type: task
  debug: false
  definitions: skill_amount
  script:
    - define skill <[skill_amount].before[_]>
    - define amount <[skill_amount].after[_]>
    - if <player.flag[character.knowledge.current]> < <[amount]>:
      - stop
    - flag <player> character.capabilities.<[skill]>:+:<[amount]>
    - flag <player> character.knowledge.current:-:<[amount]>
    - narrate "<&e>You have spent <[amount]> Knowledge Point(s)<&nl><&6>You now have <player.flag[character.knowledge.current]> Knowledge Point(s) left to spend.<&nl><&e>You now have <player.flag[character.capabilities.<[skill]>]> in <[skill].to_titlecase>."