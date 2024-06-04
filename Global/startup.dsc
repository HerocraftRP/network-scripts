startup:
  type: world
  debug: false
  events:
    on server start:
      # Clear Server Temp Flags
      - flag server temp:!
      # Establish SQL Connection
      - ~sql id:players connect:localhost:3306/players?autoReconnect=true username:denizen password:denizen
      # Prevent Players from joining
      - flag server startup
      # Forceload All Chunks
      ## Needs re-write for overworld biomes
      - define chunks <server.flag[chunk_loading.corner1].to_cuboid[<server.flag[chunk_loading.corner2]>].chunks>
      - foreach <[chunks]>:
        - chunkload <[value]>
        - if <[loop_index].mod[1000]> == 0:
          - announce to_console "Forceloaded <[loop_index]> out of <[chunks].size> chunks"
          - wait 1t
      # Probably fucking useless, tbh
      - foreach <server.worlds.first.entities>:
        - if <[value].has_flag[on_startup]>:
          - run <[value].flag[on_startup]> def:<[value]>
      # Nerf Stack Sizes
      - foreach <server.material_types>:
        - if <script[stack_limited_materials].data_key[data.<[value].name>].exists>:
          - adjust <material[<[value]>]> max_stack_size:<script[stack_limited_materials].data_key[data.<[value].name>]>
        - else:
          - adjust <material[<[value]>]> max_stack_size:1
      # Retrieve Shop data from google docs and build it
      - run shop_data_retrieve
      # Nuke all crafting recipes
      - run nuke_crafting_recipes
      # Reset this storm's name mapping
      - flag server name_map:!
      # Clear Custom Placeables that do not persist between storms
      ## This won't apply to crashes, or any shutdown that is not triggered by the twice daily storm!!!
      - foreach <server.flag[custom_placeables.location]> as:simple_location:
        - if !<server.flag[custom_placeables.location.<[simple_location]>.script].data_key[data.persist_between_storms]>:
          - if <server.flag[custom_placeables.location.<[simple_location]>.storm]> < <server.flag[shutdown_counter]>:
            - run clear_custom_placeable def:<location[<[simple_location]>]>
      # Force weather back to sunny (from thunder during storm)
      - weather <server.worlds.first> sunny
      # Give other shit 5 seconds to do things
      - wait 5s
      # Allow players to join
      - flag server startup:!

    on player logs in server_flagged:startup:
      - determine "KICKED:Server is still starting up!"

stack_limited_materials:
  type: data
  data:
    arrow: 8
    paper: 64
    firstaid_plaster: 16
    herocraft_empty_bundle: 16
    herocraft_copper_coin: 64
    herocraft_silver_coin: 64
    herocraft_gold_coin: 64
    herocraft_diamond_coin: 64
    herocraft_netherite_coin: 64
    herocraft_platinum_coin: 64