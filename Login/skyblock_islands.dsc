skyblock_login:
  type: world
  debug: false
  events:
    on player joins:
      - if <player.has_flag[skyblock.id]>:
        - define id <player.flag[skyblock.id]>
        - define xOffset <element[100000].mul[<[id].mod[200]>]>
        - define zOffset <element[100000].mul[<[id].div[200].round_down>]>
        - define center_location <location[100000,102,100000,<server.worlds.first.name>].add[<[xOffset]>,0,<[zOffset]>]>
        - teleport <[center_location]>
      - else:
        - ~run initiate_player_skyblock
        - ~run sql_init_player_data
        - define id <player.flag[skyblock.id]>
        - define xOffset <element[100000].mul[<[id].mod[200]>]>
        - define zOffset <element[100000].mul[<[id].div[200].round_down>]>
        - define center_location <location[100000,102,100000,<server.worlds.first.name>].add[<[xOffset]>,0,<[zOffset]>]>
        - wait 1s
        - inventory clear
      - wait 1s
      - remove <player.flag[temp.character_creation.entities]>
      - flag player temp:!
      - run create_new_character_start_buttons
    on modded player hurt:
      - determine cancelled

initiate_player_skyblock:
  type: task
  debug: false
  script:
    - wait 1s
    - define id <server.flag[skyblock_count]||1>
    - flag player skyblock.id:<[id]>
    - flag server skyblock_count:+:1
    - define xOffset <element[100000].mul[<[id].mod[200]>]>
    - define zOffset <element[100000].mul[<[id].div[200].round_down>]>
    - define center_location <location[100000,100,100000,<server.worlds.first.name>].add[<[xOffset]>,0,<[zOffset]>]>
    - teleport <[center_location]>
    # NPC LOCATION
    - worldedit paste file:lobby_template position:<[center_location]>
    - wait 1s
    - define n <[center_location].find_blocks[glowstone].within[7].first.center.above[0.51]>
    - flag <player> character_location:<[n].add[0,2,-11].with_yaw[180]>
    - flag <player> info_location:<[n].add[-5,2,0]>
    - run create_new_character_start_buttons
    - run create_server_infogram