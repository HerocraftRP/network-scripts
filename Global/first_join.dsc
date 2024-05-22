first_join:
  type: world
  debug: false
  events:
    on player joins bukkit_priority:LOWEST priority:-9999:
      - wait 1t
      - if !<player.has_flag[initialized]>:
        - flag <player> initialized:0
        - flag <player> initialized_now
      - repeat 100:
        - define phase <player.flag[initialized].add[1]>
        - if <script[init_<[phase]>].exists>:
          - inject init_<[phase]>
        - else:
          - stop
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
    - flag player initialized:1
    - flag <player> comm_crystal_icon:stone
    - flag <player> data.name:<player.name>
    - flag <player> data.color:<&7>
    - run parcool_limitation_defaults
    - run sql_init_inventory
    - run sql_init_player_data