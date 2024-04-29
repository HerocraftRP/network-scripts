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
      - foreach <script[stack_limited_materials].data_key[data]>:
        - adjust <material[<[key]>]> max_stack_size:<[value]>
      - run shop_data_retrieve
      - flag server startup:!

    on player logs in:
      - if <server.has_flag[startup]>:
        - determine "KICKED:Server is still starting up!"

stack_limited_materials:
  type: data
  data:
    oak_log: 1
    spruce_log: 1
    birch_log: 1
    jungle_log: 1
    acacia_log: 1
    dark_oak_log: 1
    oak_planks: 1
    spruce_planks: 1
    birch_planks: 1
    jungle_planks: 1
    acacia_planks: 1
    dark_oak_planks: 1
    tconstruct_copper_nugget: 1
    iron_nugget: 1
    gold_nugget: 1
    raw_iron: 1
    raw_copper: 1
    raw_gold: 1
    diamond: 1
    emerald: 1
    bowl: 1
    FARMERSDELIGHT_CABBAGE: 1
    CARROT: 1
    FARMERSDELIGHT_ONION: 1
    FARMERSDELIGHT_TOMATO:  1
    FARMERSDELIGHT_MINCED_BEEF: 1
    WHEAT: 1
    porkchop: 1
    beef: 1
    chicken: 1
    paper: 1
    stone: 1
    cod: 1
    salmon: 1
    glass_bottle: 1