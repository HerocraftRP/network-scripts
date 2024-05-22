nuke_chat:
  type: world
  debug: false
  events:
    on player chats server_flagged:switches.chat:
      - determine cancelled

whisper_visual:
  type: world
  debug: false
  events:
    on w command:
      - determine fulfilled

mind_message:
  type: command
  debug: false
  name: mm
  usage: /mm (player) (message)
  description: send a mind message to another person.
  tab completions:
    1: <server.online_players.parse[flag[data.name]]>
  script:
    - if <player.item_in_hand.script.name||null> != communication_crystal:
      - narrate "<&c>You need to hold a communication crystal."
      - stop
    - if <context.args.size> < 1:
      - narrate "<&c>Who are you trying to message?"
      - stop
    - if <context.args.size> < 2:
      - narrate "<&c>What are you trying to say?"
      - stop
    - define target <server.flag[name_map.<context.args.get[1]>]||null>
    - if <[target]> == null:
      - narrate "<&c>You message fizzles, unable to find <context.args.get[1]>."
      - stop
    - flag player temp.timed_action
    - run start_timed_action "def:<&6>Messaging <[target].flag[data.name]>|3s|mind_message_callback|<context.args.escaped>" def.animation_task:mind_message_animation def.can_move:false def.can_swap_items:false

mind_message_animation:
  type: task
  debug: false
  script:
    - repeat 4:
      - playeffect at:<player.location.with_yaw[<player.body_yaw>].above[0.70].right[0.4].forward_flat[0.1]> effect:redstone special_data:0.65|green quantity:20 offset:0.05,0.05,0.05
      - wait 5t

mind_message_callback:
  type: task
  debug: false
  definitions: args
  script:
    - if <player.item_in_hand.script.name||null> != communication_crystal:
      - narrate "<&c>You let go of your communication crystal."
      - stop
    - playeffect at:<server.flag[name_map.<[args].get[1]>].eye_location.above[0.5]> effect:redstone special_data:0.65|green quantity:20 offset:0.05,0.05,0.05
    - define args <list[<[args].unescaped>]>
    - define target <server.flag[name_map.<[args].get[1]>]>
    - define self_name <player.proc[mind_message_get_self_name]>
    - define name <player.proc[mind_message_get_player_name].context[<[target]>]>
    - narrate "<&7><[self_name]><&8><&gt><&gt><&7> <[args].get[2].to[last].separated_by[<&sp>]>"
    - narrate "<&7><[name]><&8><&gt><&gt><&7> <[args].get[2].to[last].separated_by[<&sp>]>" targets:<server.flag[name_map.<[args].get[1]>]>

mind_message_get_self_name:
  type: procedure
  debug: false
  definitions: player|other_player
  script:
    - if <player.has_flag[temp.invisible]>:
      - determine <&d>~<player.flag[data.color]><player.flag[data.name]><&d>~
    - if <player.has_flag[temp.hidden]>:
      - determine <&8>-<player.flag[data.color]><player.flag[data.name]><&8>-
    - if <player.has_flag[temp.stealth]>:
      - determine <&8>--<player.flag[data.color]><player.flag[data.name]><&8>--
    - determine <player.flag[data.color]><player.flag[data.name]>

mind_message_get_player_name:
  type: procedure
  debug: false
  definitions: player|other_player
  script:
    # Invisibility
    - if <player.has_flag[temp.invisible]>:
      - determine <&d>~<player.flag[data.color]>????<&d>~
    # Hiding
    - if <player.has_flag[temp.hidden]>:
      - determine <&8>-<player.flag[data.color]>????<&8>-
    # Stealth
    - if <player.has_flag[temp.stealth]>:
      - determine <&8>--<player.flag[data.color]>????--
    # Check for introduction
    - if <[other_player].has_flag[data.known_people.<player.flag[data.name]>_<player.uuid>]>:
      - determine <player.flag[data.color]><player.flag[data.name]>
    # Unknown Person
    - determine <player.flag[data.color]>????