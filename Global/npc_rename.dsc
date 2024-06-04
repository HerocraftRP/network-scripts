npc_rename_me:
  type: task
  debug: false
  script:
    - ratelimit <player> 1t
    - flag <player> temp.last_npc_interacted:<context.entity>
    - define entity <context.entity>
    - define name <[entity].flag[true_name]>
    - if <[entity].has_flag[rep_display]>:
      - define name "<[name]> <&e>(Your Capability<&co> <player.flag[character.capabilities.<[entity].flag[rep_display]>]||0>)"
    - adjust <[entity]> custom_name:<[name]>
    - wait 1t
    - adjust <context.entity> custom_name

npc_rename_me_command:
  type: command
  name: npc_rename_me
  debug: false
  permission: not.a.perm
  description: no
  usage: /npc_rename_me absolutely not
  script:
    - adjust <queue> linked_player:<server.match_player[<context.args.get[1]>]> if:<player.exists.not>
    - define entity <player.flag[temp.last_npc_interacted]>
    - define name <[entity].flag[true_name]>
    - if <[entity].has_flag[rep_display]>:
      - define name "<[name]> <&e>(Your Capability<&co> <player.flag[character.capabilities.<[entity].flag[rep_display]>]||0>)"
    - adjust <[entity]> custom_name:<[name]>
    - wait 1t
    - adjust <[entity]> custom_name


npc_command_name:
  type: command
  name: npc_name
  debug: false
  description: Set an NPC's Name, optinallly assign as a rep viewer
  usage: /npc_name "John FUCKING Wick" lumberjack
  permission: herocraft.developer.npc_name
  script:
    - define name <context.args.get[1]>
    - flag <player.target> true_name:<[name].parse_color>
    - if <context.args.size> == 2:
      - flag <player.target> rep_display:<context.args.get[2]>
    - flag <player.target> right_click_script:npc_rename_me