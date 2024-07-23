make_my_base:
  type: task
  debug: false
  definitions: loc|facing
  data:
    chunks_east_west: 3
    chunks_north_south: 3
    height_per_floor: 8
    surface_chunk_configs:
      - farm
      - animal_pen
      - path
  script:
    - if <player.uuid> != 8d2e96af-70f7-43b7-b066-11b1f4fce6a5:
      - narrate <&c>Nope.
      - stop
    # Initialize Data
    - flag server randomTickSpeed <player.location.world.gamerule_map.get[randomTickSpeed]>
    - gamerule <[loc].world> randomTickSpeed <server.flag[randomtickspeed]>
    - define loc <player.location> if:<[loc].exists.not>
    - define facing south if:<[facing].exists.not>
    - chunkload <[loc].chunk>
    - define start <[loc].chunk.cuboid.center.highest.center>
    - define start_y <[start].y>
    - define cew <script.data_key[data.chunks_east_west].mul[16]>
    - define cns <script.data_key[data.chunks_north_south].mul[16]>
    - define startcorner1 <[loc].chunk.cuboid.min.sub[<[cew]>,0,<[cns]>]>
    - define startcorner2 <[loc].chunk.cuboid.max.add[<[cew]>,0,<[cns]>]>
    - define outline <[startcorner1].to_cuboid[<[startcorner2]>].shell>
    - wait 1t
    # Clear Entire Build Area
    - narrate "<&e>Clearing Chunks"
    - define clearew <script.data_key[data.chunks_east_west].add[1].mul[16]>
    - define clearns <script.data_key[data.chunks_north_south].add[1].mul[16]>
    - define clearcorner1 <[loc].chunk.cuboid.min.sub[<[clearew]>,0,<[clearns]>]>
    - define clearcorner2 <[loc].chunk.cuboid.max.add[<[clearew]>,0,<[clearns]>]>
    - define clear_cuboid <[clearcorner1].to_cuboid[<[clearcorner2]>]>
    - foreach <[clear_cuboid].chunks> as:chunk:
      - if <[chunk].is_loaded.not>:
        - chunkload <[chunk]>
        - wait 1s
      - modifyblock <[chunk].cuboid.blocks[!air]> air no_physics
      - wait 10t
      #- foreach <[chunk].cuboid.blocks[!air]> as:block:
        #- wait 1t if:<[loop_index].mod[50].equals[0]>
        #- modifyblock <[block]> air no_physics
    # Fix Biome To Plains
    - narrate "<&e>Applying Plains Biome"
    - foreach <[clear_cuboid].chunks> as:chunk:
      - adjust <[chunk].cuboid.blocks> biome:plains
      - wait 1s
    # Build First Layer for Schematic - Bedrock
    - narrate "<&e>Building Layer 1 - Inner Bedrock"
    - define layer1_1 <[startcorner1].with_y[<[start_y]>].above>
    - define layer1_2 <[startcorner2].with_y[<[start_y]>].above>
    - define layer1_cuboid <[layer1_1].to_cuboid[<[layer1_2]>]>
    - define layer1_outline <[layer1_cuboid].outline>
    - modifyblock <[layer1_cuboid].blocks> air no_physics
    - wait 1t
    - modifyblock <[layer1_outline]> bedrock
    # Layer 2 - Lava
    - narrate "<&e>Building Layer 2 - Lava"
    - define layer2_1 <[startcorner1].sub[16,0,16].with_y[<[start_y]>].above>
    - define layer2_2 <[startcorner2].add[16,0,16].with_y[<[start_y]>].above>
    - define layer2_cuboid <[layer2_1].to_cuboid[<[layer2_2]>]>
    - narrate "<&e>Layer 2 Chunkloading"
    - foreach <[layer2_cuboid].chunks>:
      - chunkload <[value]>
      - wait 1t
    - narrate "<&e>Lava Loop"
    - foreach <[layer2_cuboid].blocks.exclude[<[layer1_cuboid].blocks>]>:
      - wait 1t if:<[loop_index].mod[30].equals[0]>
      - modifyblock <[value]> lava no_physics
    - wait 1t
    # Build Layer 3 - Outer Bedrock
    - narrate "<&e>Building Layer 3 - Outer Bedrock"
    - define layer2_outline <[layer2_cuboid].outline>
    - modifyblock <[layer2_outline]> bedrock
    # Layer 4 - Stone Bricks 1 & 2
    - narrate "<&e>Building Stone Bricks 1"
    - define stonebricks1_1 <[startcorner1].sub[1,0,1].with_y[<[start_y]>].above>
    - define stonebricks1_2 <[startcorner2].add[1,0,1].with_y[<[start_y]>].above>
    - define stonebricks1_cuboid <[stonebricks1_1].to_cuboid[<[stonebricks1_2]>]>
    - define stonebricks1_outline <[stonebricks1_cuboid].outline>
    - modifyblock <[stonebricks1_outline]> stone_bricks no_physics
    - wait 1t
    - narrate "<&e>Building Stone Bricks 2"
    - define stonebricks2_1 <[startcorner1].sub[-1,0,-1].with_y[<[start_y]>].above>
    - define stonebricks2_2 <[startcorner2].add[-1,0,-1].with_y[<[start_y]>].above>
    - define stonebricks2_outline <[stonebricks2_1].to_cuboid[<[stonebricks2_2]>].outline>
    - modifyblock <[stonebricks2_outline]> stone_bricks no_physics
    - wait 1t
    # Create Schematic
    - narrate "<&e>Creating Schematic"
    - schematic create area:<[layer2_cuboid]> name:temp <[start].above>
    - wait 1t
    # Pasting Schematic to Bedrock
    - repeat <[start_y].add[64]>:
      - narrate "<&e>Pasting Schematic - loop <[value]> - Y layer <[start].below[<[value].sub[1]>].y>"
      - schematic paste name:temp <[start].below[<[value].sub[1]>]>
      - wait 1s if:<[value].mod[5].equals[0]>
    # Create Floor
    - narrate "<&e>Building Bedrock Floor"
    - modifyblock <[layer1_1].with_y[-64].to_cuboid[<[layer1_2].with_y[-64]>].blocks> bedrock
    - wait 1s
    # Create Roof
    - narrate "<&e>Building Bedrock Roof"
    - define roofcorner1 <[loc].chunk.cuboid.min.sub[<[cew].sub[1]>,0,<[cns].sub[1]>].with_y[<[start_y].sub[3]>]>
    - define roofcorner2 <[loc].chunk.cuboid.max.add[<[cew].sub[1]>,0,<[cns].sub[1]>].with_y[<[start_y].sub[3]>]>
    - modifyblock <[roofcorner1].to_cuboid[<[roofcorner2]>].blocks> bedrock
    - wait 1s
    # Create Grass Block Cover
    - narrate "<&e>Building Grass Block Cover"
    - define roofcorner1 <[loc].chunk.cuboid.min.sub[<[cew]>,0,<[cns]>].with_y[<[start_y].add[1]>]>
    - define roofcorner2 <[loc].chunk.cuboid.max.add[<[cew]>,0,<[cns]>].with_y[<[start_y].add[1]>]>
    - modifyblock <[roofcorner1].to_cuboid[<[roofcorner2]>].blocks> grass_block
    - wait 1s
    # Create Dirt Layers
    - narrate "<&e>Building Dirt Layers"
    - repeat 3:
      - define roofcorner1 <[loc].chunk.cuboid.min.sub[<[cew].sub[1]>,0,<[cns].sub[1]>].with_y[<[start_y].sub[<[value].sub[1]>]>]>
      - define roofcorner2 <[loc].chunk.cuboid.max.add[<[cew].sub[1]>,0,<[cns].sub[1]>].with_y[<[start_y].sub[<[value].sub[1]>]>]>
      - modifyblock <[roofcorner1].to_cuboid[<[roofcorner2]>].blocks> dirt
      - wait 1s
    # Build Iron Bar Perimeter
    - narrate "<&e>Building Iron Bar Perimeter"
    - repeat 8:
      - modifyblock <[stonebricks1_outline].parse[above[<[value]>]]> iron_bars[faces=<list>] no_physics
      - wait 5t
    - narrate "<&e>Fixing FACES for Iron Bars"
    - foreach <[stonebricks1_outline].parse[above]> as:loc:
      - define faces <list>
      - if <[loc].add[1,0,0].material.name> == iron_bars:
        - define faces <[faces].include[EAST]>
      - if <[loc].add[-1,0,0].material.name> == iron_bars:
        - define faces <[faces].include[WEST]>
      - if <[loc].add[0,0,1].material.name> == iron_bars:
        - define faces <[faces].include[SOUTH]>
      - if <[loc].add[0,0,-1].material.name> == iron_bars:
        - define faces <[faces].include[NORTH]>
      - adjustblock <[loc].to_cuboid[<[loc].above[7]>].blocks> FACES:<[faces].deduplicate>
      - wait 1t
    # Build Corner Towers
    - narrate "<&e>Building Corner Towers"
    - define tower_centers_1 <[startcorner1].add[1,0,1].with_y[<[start_y]>].above>
    - define tower_centers_2 <[startcorner2].sub[1,0,1].with_y[<[start_y]>].above>
    - define tower_corners <[tower_centers_1].to_cuboid[<[tower_centers_2]>].corners>
    - foreach <[tower_corners]>:
      - run make_corner_tower def:<[value].above>|<[start]>
    ## Start Building Data Structures
    # Assign Surface Chunks
    - narrate "<&e>Generating Chunks Assignments"
    - define housing_chunks_1 <[start].add[24,0,24]>
    - define housing_chunks_2 <[start].add[-24,0,-24]>
    - foreach <[housing_chunks_1].to_cuboid[<[housing_chunks_2]>].chunks> as:chunk:
      - flag server xeane.chunk_map.<[chunk].x>_<[chunk].z>:house
      - modifyblock <[chunk].surface_blocks> stone_bricks
    - define housing_chunks_1 <[start].add[40,0,40]>
    - define housing_chunks_2 <[start].add[-40,0,-40]>
    - foreach <[housing_chunks_1].to_cuboid[<[housing_chunks_2]>].chunks> as:chunk:
      - if !<server.has_flag[xeane.chunk_map.<[chunk].x>_<[chunk].z>]>:
        - flag server xeane.chunk_map.<[chunk].x>_<[chunk].z>:path
        - modifyblock <[chunk].surface_blocks> dirt_path
    - define surface_chunks <[roofcorner1].to_cuboid[<[roofcorner2]>].chunks>
    - foreach <[surface_chunks]> as:chunk:
      - define center <[chunk].cuboid.center.highest>
    # Build Lower Levels
    - narrate "<&e>Building Lower Levels"
    - define levels <[start_y].add[60].div[<script.data_key[data.height_per_floor]>].round_down>
    - narrate "<&e><[levels]> floors will be built and connected."
    - define top_y <[start_y].sub[4]>
    - repeat <[levels]>:
      - narrate "<&e>Building Floor <[value]>"
      - define roofcorner1 <[loc].chunk.cuboid.min.sub[<[cew].sub[1]>,0,<[cns].sub[1]>].with_y[<[top_y].sub[<[value].sub[1].mul[8]>]>]>
      - define roofcorner2 <[loc].chunk.cuboid.max.add[<[cew].sub[1]>,0,<[cns].sub[1]>].with_y[<[top_y].sub[<[value].mul[8]>]>]>
      - modifyblock <[roofcorner1].to_cuboid[<[roofcorner2]>].shell> bedrock
      - wait 1s
      - define roofcorner1 <[loc].chunk.cuboid.min.sub[<[cew].sub[1]>,0,<[cns].sub[1]>].with_y[<[top_y].sub[<[value].sub[1].mul[8].add[1]>]>]>
      - define roofcorner2 <[loc].chunk.cuboid.max.add[<[cew].sub[1]>,0,<[cns].sub[1]>].with_y[<[top_y].sub[<[value].mul[8].sub[1]>]>]>
      - flag server xeane.floor_cuboids.<[value]>:<[roofcorner1].to_cuboid[<[roofcorner2]>]>
      - modifyblock <[roofcorner1].to_cuboid[<[roofcorner2]>].shell> stone_bricks
      - wait 1s
      - define roofcorner1 <[loc].chunk.cuboid.min.sub[<[cew].sub[1]>,0,<[cns].sub[1]>].with_y[<[top_y].sub[<[value].sub[1].mul[8].add[1]>]>]>
      - define roofcorner2 <[loc].chunk.cuboid.max.add[<[cew].sub[1]>,0,<[cns].sub[1]>].with_y[<[top_y].sub[<[value].sub[1].mul[8].add[1]>]>]>
      - modifyblock <[roofcorner1].to_cuboid[<[roofcorner2]>].blocks> glowstone
      - wait 1s
      - define roofcorner1 <[loc].chunk.cuboid.min.sub[1,1,1].with_y[<[top_y].sub[<[value].sub[1].mul[8]>]>]>
      - define roofcorner2 <[loc].chunk.cuboid.max.add[1,1,1].with_y[<[top_y].sub[<[value].mul[8]>]>]>
      - modifyblock <[roofcorner1].to_cuboid[<[roofcorner2]>].shell> bedrock
      - wait 1s
      - define roofcorner1 <[loc].chunk.cuboid.min.with_y[<[top_y].sub[<[value].sub[1].mul[8]>].add[1]>]>
      - define roofcorner2 <[loc].chunk.cuboid.max.with_y[<[top_y].sub[<[value].mul[8]>].sub[1]>]>
      - modifyblock <[roofcorner1].to_cuboid[<[roofcorner2]>].shell> stone_bricks
      - wait 1t
      - define roofcorner1 <[loc].chunk.cuboid.min.with_y[<[top_y].sub[<[value].sub[1].mul[8].add[1]>]>]>
      - define roofcorner2 <[loc].chunk.cuboid.max.with_y[<[top_y].sub[<[value].sub[1].mul[8].add[1]>]>]>
      - modifyblock <[roofcorner1].to_cuboid[<[roofcorner2]>].blocks> glowstone
      - wait 1t
      - define pos1 <[start].add[1,0,1].with_y[<[top_y].sub[<[value].mul[8]>]>].add[0,1,0]>
      - define pos2 <[start].sub[1,0,1].with_y[<[top_y].sub[<[value].mul[8]>]>].add[0,4,0]>
      - modifyblock <[pos1].to_cuboid[<[pos2]>].outline> obsidian
      # To the Top Gateways
      - modifyblock <[start].with_y[<[top_y].sub[<[value].mul[8]>]>].add[0,2,0]> end_gateway
      - modifyblock <[start].with_y[<[top_y].sub[<[value].mul[8]>]>].add[0,3,0]> end_gateway
      # To the Floor Gateways
      - modifyblock <[start].with_y[<[top_y].sub[<[value].mul[8]>]>].add[7,2,0]> end_gateway
      - modifyblock <[start].with_y[<[top_y].sub[<[value].mul[8]>]>].add[7,3,0]> end_gateway
      # Floor Landing
      - define pos1 <[start].add[9,0,1].with_y[<[top_y].sub[<[value].mul[8]>]>].add[0,1,0]>
      - define pos2 <[start].add[11,0,-1].with_y[<[top_y].sub[<[value].mul[8]>]>].add[0,4,0]>
      - modifyblock <[pos1].to_cuboid[<[pos2]>].outline> obsidian
      # Back to Elevator
      - modifyblock <[start].with_y[<[top_y].sub[<[value].mul[8]>]>].add[10,2,0]> end_gateway
      - modifyblock <[start].with_y[<[top_y].sub[<[value].mul[8]>]>].add[10,3,0]> end_gateway
    # FINAL
    - schematic unload name:temp
    - gamerule <[loc].world> randomTickSpeed <server.flag[randomtickspeed]>

make_corner_tower:
  type: task
  debug: false
  definitions: corner|center
  data:
    height: 8
    size: 4
    directional:
      southwest:
        hinge: left
        facing: north
      southeast:
        hinge: right
        facing: north
      northeast:
        hinge: left
        facing: south
      northwest:
        hinge: right
        facing: south
  script:
    # Define and Build the Shell
    - define height <script.data_key[data.height]>
    - define size <script.data_key[data.size]>
    - define floor <[corner].add[<[size]>,-1,<[size]>].to_cuboid[<[corner].sub[<[size]>,0,<[size]>]>].shell>
    - define outer_stone_wall <[corner].add[<[size]>,<[height]>,<[size]>].to_cuboid[<[corner].sub[<[size]>,0,<[size]>]>].shell>
    - define becrock_wall <[corner].add[<[size].sub[1]>,<[height]>,<[size].sub[1]>].to_cuboid[<[corner].sub[<[size].sub[1]>,0,<[size].sub[1]>]>].shell>
    - define inner_stone_wall <[corner].add[<[size].sub[2]>,<[height]>,<[size].sub[2]>].to_cuboid[<[corner].sub[<[size].sub[2]>,0,<[size].sub[2]>]>].blocks>
    - modifyblock <[floor]> stone_bricks
    - modifyblock <[outer_stone_wall].filter[material.name.equals[air]]> stone_bricks
    - modifyblock <[becrock_wall]> bedrock
    - modifyblock <[inner_stone_wall]> stone
    - wait 1t
    # Build the Top
    - define top_layer <[corner].add[<[size].add[1]>,<[height].add[1]>,<[size].add[1]>].to_cuboid[<[corner].sub[<[size].add[1]>,-<[height].add[1]>,<[size].add[1]>]>].shell>
    - modifyblock <[top_layer]> stone_bricks
    - define roof <[corner].add[<[size].sub[1]>,<[height].add[1]>,<[size].sub[1]>].to_cuboid[<[corner].sub[<[size].sub[1]>,-<[height].add[1]>,<[size].sub[1]>]>].corners>
    - repeat 5:
      - modifyblock <[roof].parse[above[<[value]>]]> stone_bricks
    - define roof <[corner].add[<[size].add[1]>,<[height].add[6]>,<[size].add[1]>].to_cuboid[<[corner].sub[<[size].add[1]>,-<[height].add[6]>,<[size].add[1]>]>].blocks>
    - modifyblock <[roof]> stone_bricks
    - wait 1t
    # Determine Entrance/Exit Data
    - define start <[corner]>
    - define clear <[corner]>
    - define water_up <[corner]>
    - define water_down <[corner]>
    - define middle <[corner]>
    - define door_location <[corner]>
    - define direction <[corner].direction[<[center]>]>
    - if <[direction].contains_text[south]>:
      - define clear <[clear].add[0,0,<[size]>]>
      - define start <[start].add[0,0,-1]>
      - define water_up <[water_up].add[0,0,-1]>
      - define water_down <[water_down].add[0,0,-1]>
      - define middle <[middle].add[0,0,-1]>
      - define door south
    - if <[direction].contains_text[north]>:
      - define clear <[clear].add[0,0,-<[size]>]>
      - define start <[start].add[0,0,1]>
      - define water_up <[water_up].add[0,0,1]>
      - define water_down <[water_down].add[0,0,1]>
      - define middle <[middle].add[0,0,1]>
      - define door north
    - if <[direction].contains_text[east]>:
      - define clear <[clear].add[<[size]>,0,0]>
      - define start <[start].add[-1,0,0]>
      - define water_up <[water_up].add[-1,0,0]>
      - define water_down <[water_down].add[1,0,0]>
      - define door_location <[door_location].add[-1,0,0]>
    - if <[direction].contains_text[west]>:
      - define clear <[clear].add[-<[size]>,0,0]>
      - define start <[start].add[1,0,0]>
      - define water_up <[water_up].add[1,0,0]>
      - define water_down <[water_down].add[-1,0,0]>
      - define door_location <[door_location].add[1,0,0]>
    # Build Entrance, and waterways
    - modifyblock <[start].above[2].to_cuboid[<[clear]>].blocks> air
    - modifyblock <[water_up].to_cuboid[<[water_up].above[<[height].add[1]>]>].blocks> water
    - modifyblock <[water_up].below> soul_sand
    - modifyblock <[water_down].to_cuboid[<[water_down].above[<[height].add[1]>]>].blocks> air
    - modifyblock <[water_down].below> chest[waterlogged=true]
    - give item:arrow quantity:1728 to:<[water_down].below.inventory>
    - modifyblock <[corner].to_cuboid[<[middle].above[<[height]>]>].blocks> glass
    - define hinge <script.data_key[data.directional.<[direction]>.hinge]>
    - define facing <script.data_key[data.directional.<[direction]>.facing]>
    - modifyblock <[door_location]> iron_door[half=bottom;hinge=<[hinge]>;direction=<[facing]>;switched=true]
    - modifyblock <[door_location].above> iron_door[half=top;hinge=<[hinge]>;direction=<[facing]>;switched=true]
    - modifyblock <[door_location].above[2]> glass

build_entrance:
  type: task
  debug: false
  definitions: loc|main_room
  script:
    - 