startup:
  type: world
  debug: false
  events:
    on server start:
      - ~sql id:players connect:localhost:3306/players?autoReconnect=true username:denizen password:denizen
      - if <server.worlds.first.name> != world:
        - stop
      - flag server startup
      - define chunks <server.flag[chunk_loading.corner1].to_cuboid[<server.flag[chunk_loading.corner2]>].chunks>
      - foreach <[chunks]>:
        - chunkload <[value]>
        - if <[loop_index].mod[1000]> == 0:
          - announce to_console "Forceloaded <[loop_index]> out of <[chunks].size> chunks"
          - wait 1t
      - foreach <server.worlds.first.entities>:
        - if <[value].has_flag[on_startup]>:
          - run <[value].flag[on_startup]> def:<[value]>
      - foreach <server.material_types>:
        - if <script[stack_limited_materials].data_key[data.<[value].name>].exists>:
          - adjust <material[<[value]>]> max_stack_size:<script[stack_limited_materials].data_key[data.<[value].name>]>
        - else:
          - adjust <material[<[value]>]> max_stack_size:1
      - run shop_data_retrieve
      - run nuke_crafting_recipes
      - flag server name_map:!
      - weather <server.worlds.first> sunny
      - wait 5s
      - flag server startup:!

    on player logs in server_flagged:startup:
      - determine "KICKED:Server is still starting up!"

stack_limited_materials:
  type: data
  data:
    arrow: 8
    paper: 64
    herocraft_empty_bundle: 16
    herocraft_copper_coin: 64
    herocraft_silver_coin: 64
    herocraft_gold_coin: 64
    herocraft_diamond_coin: 64
    herocraft_netherite_coin: 64
    herocraft_platinum_coin: 64