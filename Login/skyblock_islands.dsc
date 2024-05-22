skyblock_login:
  type: world
  debug: false
  events:
    on server start:
      - schematic load name:skyblock filename:skyblock_template
    on player joins:
      - if <player.has_flag[skyblock.id]>:
        - define id <player.flag[skyblock.id]>
        - define xOffset <element[100000].mul[<[id].mod[200]>]>
        - define zOffset <element[100000].mul[<[id].div[200].round_down>]>
        - define center_location <location[100000,102,100000].add[<[xOffset]>,0,<[zOffset]>]>
      - else:
        - run initiate_player_skyblock
        - define id <player.flag[skyblock.id]>
        - define xOffset <element[100000].mul[<[id].mod[200]>]>
        - define zOffset <element[100000].mul[<[id].div[200].round_down>]>
        - define center_location <location[100000,102,100000].add[<[xOffset]>,0,<[zOffset]>]>
        - wait 1s
        - inventory clear

initiate_player_skyblock:
  type: task
  debug: false
  script:
    - define id <server.flag[skyblock_count]||1>
    - flag player skyblock.id:<[id]>
    - flag server skyblock_count:+:1
    - define xOffset <element[100000].mul[<[id].mod[200]>]>
    - define zOffset <element[100000].mul[<[id].div[200].round_down>]>
    - define center_location <location[100000,100,100000].add[<[xOffset]>,0,<[zOffset]>]>
    # NPC LOCATION
    - define n <[center_location].add[0,1,0]>
    - schematic paste name:skyblock origin:<[center_location]>
    - execute as_server "easy_npc preset import easy_npc:preset/villager/temporary.npc.nbt <[n].x> <[n].y> <[n].z>"