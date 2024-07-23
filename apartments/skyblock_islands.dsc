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
        - teleport <[center_location].with_yaw[0]>
      - else:
        - ~run initiate_player_skyblock
        - define id <player.flag[skyblock.id]>
        - define xOffset <element[100000].mul[<[id].mod[200]>]>
        - define zOffset <element[100000].mul[<[id].div[200].round_down>]>
        - define center_location <location[100000,102,100000,<server.worlds.first.name>].add[<[xOffset]>,0,<[zOffset]>]>
        - wait 1s
      - wait 1s
      - flag player temp:!
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
    # NPC LOCATION
    - worldedit paste file:apartment position:<[center_location]>
    - wait 1s
    - flag <[center_location].add[0,0,1]>|<[center_location].add[0,1,1]> on_right_click:lobby_send_to_server
    - modifyblock <[center_location].add[0,0,2]>|<[center_location].add[0,1,2]> black_wool
    - teleport <[center_location].with_yaw[0]>

lobby_send_to_server:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - ~run sql_set_inventory
    - ~run sql_set_character_data
    - ~run sql_set_player_data
    - adjust <player> send_to:herocraft

apartments_join:
  type: world
  debug: false
  events:
    on player joins bukkit_priority:highest:
      - wait 1s
      - adjust <player> gamemode:survival