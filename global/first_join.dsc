first_join:
  type: world
  debug: false
  events:
    on player joins bukkit_priority:LOWEST priority:-9999:
      - flag <player> data:!
      - flag <player> character:!
      - ~run sql_get_player_data
      - if !<player.has_flag[data.characters.<player.uuid>_<player.flag[data.name]>.game_initialized]>:
        - flag <player> data.characters.<player.uuid>_<player.flag[data.name]>.game_initialized:0
        - flag <player> initialized_now
      - repeat 100:
        - define phase <player.flag[data.characters.<player.uuid>_<player.flag[data.name]>.game_initialized].add[1]>
        - if <script[init_<[phase]>].exists>:
          - inject init_<[phase]>
        - else:
          - repeat stop
      - wait 5s
      - flag <player> initialized_now:!
      #- if !<player.has_flag[sql_init.inventory]>:
        #- run sql_init_inventory

init_1:
  type: task
  debug: false
  script:
    - wait 1s
    - inventory clear
    - inventory set slot:8 "o:<item[wallet].with[lore=<&6>Owner<&co> <&e><player.name>].with_flag[owner:<player.uuid>].with_flag[value:50]>"
    - give item:TOUGHASNAILS_WATER_CANTEEN
    - inventory set slot:9 o:communication_crystal d:<player.inventory>
    - flag <player> comm_crystal_icon:stone
    - flag <player> character.knowledge.total:25
    - flag <player> character.knowledge.current:25
    - run parcool_limitation_defaults
    - run sql_init_inventory
    - flag player data.characters.<player.uuid>_<player.flag[data.name]>.game_initialized:1

init_2:
  type: task
  debug: false
  script:
    - if !<player.has_flag[character.name.color]>:
      - flag <player> character.name.color:<&r>
    - if !<player.has_flag[character.name.full_display]>:
      - flag <player> character.name.full_display:<player.flag[character.name.color]><player.flag[data.name]>
    - if !<player.has_flag[character.vision_level]>:
      - flag <player> character.vision_level:1
    - flag player data.characters.<player.uuid>_<player.flag[data.name]>.game_initialized:2