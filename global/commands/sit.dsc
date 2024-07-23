sit_command:
  type: command
  name: sit
  debug: false
  description: sit
  usage: /sit
  script:
    - stop if:<list[adventure|creative|survival].contains[<player.gamemode>].not>
    - inject sit_in_place

sitting_armor_stand:
  type: entity
  debug: false
  entity_type: armor_stand
  mechanisms:
    visible: false
    gravity: false

sit_in_place:
  type: task
  debug: false
  script:
    - ratelimit <player> 1t
    - if <player.has_flag[temp.sit_entity]>:
      - inject sit_cancel
      - stop
    - if <player.gamemode.equals[spectator]> || <player.has_flag[temp.emote.name]>:
      - run cancel_emotes
      - stop
    - if <player.location.below[0.25].material.name> == air || <player.location.below[0.25].material.name> == water:
      - narrate "<&c>You must sit on solid ground"
      - stop
    - inventory close
    - if <player.flag[character.race]> == fae:
      - define below 1.9
    - else:
      - define below 1.75
    - spawn sitting_armor_stand <player.location.center.below[<[below]>].with_pose[<player>]> save:as
    - mount <player>|<entry[as].spawned_entity> <player.location.below[<[below]>].with_pose[<player>]>
    - flag <player> temp.sit_entity:<entry[as].spawned_entity>
    - flag player temp.emote.name:sit
    - run add_framework_flag def:on_dismount|sit_cancel

sit_cancel:
  type: task
  debug: false
  script:
    - ratelimit <player> 1t
    - run remove_framework_flag def:on_dismount|sit_cancel
    - if <player.has_flag[temp.sit_entity]>:
      - remove <player.flag[temp.sit_entity]>
      - flag <player> temp.sit_entity:!
    - flag player temp.emote.name:!
    - wait 2t
    - stop if:<list[adventure|creative|survival].contains[<player.gamemode>].not>
    - if <player.flag[character.race]> == fae:
      - teleport <player> <player.location.above[0.4]>
    - else:
      - teleport <player> <player.location.above[1.25]>