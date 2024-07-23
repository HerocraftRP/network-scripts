player_copy_create:
  type: task
  debug: false
  script:
    - if <player.flag[character.model]> != default:
      - modspawn entity:EASY_NPC_HUMANOID location:<player.location> save:as
    - else:
      - modspawn entity:EASY_NPC_HUMANOID_SLIM location:<player.location> save:as
    - wait 1t
    - adjust <entry[as].entity> easy_npc_skin:<player.flag[character.skin]>
    - run set_character_traits_on_npc def:<entry[as].entity>
    #- flag <entry[as].entity> on_damaged:player_copy_damaged
    - adjust <entry[as].entity> easy_npc_attribute:IS_ATTACKABLE|true

player_copy_damaged:
  type: task
  debug: false
  script:
    - teleport <context.entity.location>
    - remove <context.entity>
    - hurt <player> <context.damage>

set_character_traits_on_npc:
  type: task
  debug: false
  data:
    clothing_map:
      feet: boots
      bottom: legs
      top: chest
      helmet: helmet
    races:
      Human:
        base_scale: 1
      Orc:
        base_scale: 1.1
      Elytrian:
        base_scale: 0.8
      Fae:
        base_scale: 0.3
  definitions: target
  script:
    # Clothing
    - foreach <player.flag[character.clothing].keys>:
      - define slot <script.data_key[data.clothing_map.<[value]>]>
      - define clothing <script[clothing_data].data_key[clothes.<[slot]>.<player.flag[character.clothing.<[value]>]>.material]||null>
      - if <[clothing]> != null && <[clothing]> != air:
        - equip <[target]> <[slot]>:<[clothing]>
    # Sizing
    - execute as_server "scale set pehkui:base <script.data_key[data.races.<player.flag[character.race]>.base_scale]> <[target].uuid>"
    - execute as_server "scale set pehkui:width <player.flag[character.weight]> <[target].uuid>"
    - execute as_server "scale set pehkui:height <player.flag[character.height]> <[target].uuid>"
    # Health
    - adjust <[target]> max_health:<player.health_max>