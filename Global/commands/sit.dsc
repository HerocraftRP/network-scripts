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
    - if <player.location.below[0.25].material.name> == air || <player.location.below[0.25].material.name> == water:
      - narrate "<&c>You must sit on solid ground"
      - stop
    - inventory close
    - spawn sitting_armor_stand <player.location.center.below[1.75].with_pose[<player>]> save:as
    - mount <player>|<entry[as].spawned_entity> <player.location.below[1.75].with_pose[<player>]>
    - flag <player> temp.sit_entity:<entry[as].spawned_entity>
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
    - wait 2t
    - stop if:<list[adventure|creative|survival].contains[<player.gamemode>].not>
    - teleport <player> <player.location.above[1.25]>