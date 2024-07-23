guard_sentence_player:
  type: command
  debug: false
  name: sentence
  description: Sentence townsmen to jail
  usage: /sentence (cell#) (months) (fine)
  permissions: herocraft.guard
  tab completions:
    1: cell#
    2: months
    3: fine
  script:
    - if !<player.has_flag[temp.active_duty_guard]>:
      - narrate "<&c>You are not a guard."
      - stop
    - if <context.args.size> != 3:
      - narrate "<&c>Incorrect amount of arguments!"
      - narrate "/sentence (cell#) (months) (fine)"
      - stop
    - foreach <context.args>:
      - if !<[value].is_integer>:
        - narrate "<&c>Invalid input for argument <[loop_index]>: <&e><[value]>"
        - stop
    - if <context.args.get[1]> > 3 || <context.args.get[1]> < 1:
      - narrate "<&c>Invalid Cell Number: <context.args.get[1]>"
      - stop
    - define criminals <cuboid[cell_<context.args.get[1]>].players>
    - foreach <[criminals]> as:criminal:
      - run guard_take_money def:<context.args.get[3]> player:<[criminal]>
      - flag <[criminal]> jail.time.start:<util.time_now>
      - flag <[criminal]> jail.time.end:<util.time_now.add[<context.args.get[2]>m]>
      - teleport <[criminal]> prison

guard_take_money:
  type: task
  debug: false
  definitions: takeAmount
  script:
    - define amount <player.flag[character.bank.value]||0>
    - define newAmount <[amount].sub[<[takeAmount]>]>
    - flag <player> character.bank.value:<[newAmount]>

guards_report_crime:
  type: task
  debug: false
  definitions: location|crime_type|criminal
  script:
    - define response_uuid:<util.random_uuid>
    - flag server temp.guard_reports.<[response_uuid]>.time:<util.time_now>
    - flag server temp.guard_reports.<[response_uuid]>.criminal:<[criminal]>
    - flag server temp.guard_reports.<[response_uuid]>.location:<[location]>
    - stop if:<server.has_flag[temp.active_duty_guards.list].not>
    - narrate "<&4>------------------CRIME REPORTED------------------<&nl>" targets:<server.flag[temp.active_duty_guards.list]>
    - narrate "<&e>Crime<&co> <&b><[crime_type]>" targets:<server.flag[temp.active_duty_guards.list]>
    - narrate "<&e>Suspect Description<&co>" targets:<server.flag[temp.active_duty_guards.list]>
    - repeat 4:
      - define slot <element[4].sub[<[value]>]>
      - define player_clothes <player.flag[character.cosmetic_armor.<[slot]>]||0>
      - narrate "<&e>-- <script[clothing_system_narrate].data_key[data.keymap.<[slot]>]><&co> <script[clothing_data].parsed_key[clothes.<[slot]>.<[player_clothes]>.display]||<&e>None>" targets:<server.flag[temp.active_duty_guards.list]>
    - narrate "<element[<&b>Click Action<&co> <&a><&n>Respond to this Crime.].on_click[/guard_respond <[response_uuid]>].on_hover[<&b>This will teleport you to the crime location]>" targets:<server.flag[temp.active_duty_guards.list]>

guard_respond_command:
  type: command
  name: guard_respond
  debug: false
  usage: /guard_respond
  description: used for guard to respond to crimes
  tab completions:
    1: no
    2: bad
    4: *spray bottle*
  script:
    - if !<server.has_flag[temp.guard_reports.<context.args.get[1]>]>:
      - stop
    - if <server.has_flag[temp.active_duty_guards.map.<player.uuid>]>
    - narrate "<&e>Teleporting to reported crime location, do not move."
    - run start_timed_action "def:<&e>Responding to Crime|9s|guard_respond_callback|<server.flag[temp.guard_reports.<context.args.get[1]>.location]>" def.distance_from_origin:1
    - run guard_respond_animation def:<server.flag[temp.guard_reports.<context.args.get[1]>.location]>|<player>

guard_respond_animation:
  type: task
  debug: false
  definitions: location|user
  script:
    - define user <player> if:<[user].exists.not>
    - define targets1 <[location].find_players_within[100]>
    - define targets2 <[user].location.find_players_within[100]>
    - repeat 90:
      - playeffect at:<player.location.above[2]> offset:0,0,0 effect:ENCHANTMENT_TABLE data:2 quantity:30
      - playeffect at:<[location].above[2]> offset:0,0,0 effect:ENCHANTMENT_TABLE data:2 quantity:30
      - wait 2t

guard_respond_callback:
  type: task
  debug: false
  definitions: location
  script:
    - define origin <player.location.above[2]>
    - playeffect effect:EXPLOSION_LARGE at:<[origin]> quantity:3
    - playeffect effect:EXPLOSION_LARGE at:<[location].above[2]> quantity:3
    - wait 1t
    - teleport <player> <[location]>
    - playeffect effect:EXPLOSION_LARGE at:<[origin]> quantity:3
    - playeffect effect:EXPLOSION_LARGE at:<[location].above[2]> quantity:3

guard_sign_in:
  type: command
  name: guard_sign_in
  debug: false
  permission: not.a.perm
  usage: NO
  description: internal command
  script:
    - adjust <queue> linked_player:<server.match_player[<context.args.get[1]>]>
    - if <player.has_flag[character.guard_data]> && !<player.has_flag[temp.active_duty_guard]>:
      - flag server temp.active_duty_guards.list:->:<player>
      - flag player temp.active_duty_guard
      - run add_framework_flag def:on_quit|guard_sign_out|<player>
      - narrate "<&e>You are now on Active Duty, keep the streets safe!"
      - inventory close
    - else:
      - narrate "<&c>You are not able to work as a guard."
      - inventory close

guard_sign_out:
  type: task
  debug: false
  script:
    - flag server temp.active_duty_guard.list:<-:<player>