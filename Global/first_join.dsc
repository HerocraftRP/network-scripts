first_join:
  type: world
  debug: false
  events:
    on player joins:
      - flag player temp:!
      - stop if:<player.flag[initialized].equals[1]||false>
      - wait 1s
      #- if !<player.has_flag[sql_init.inventory]>:
        #- run sql_init_inventory
      - inventory set slot:1 o:<item[CALEMIECONOMY_WALLET]> d:<player.inventory>
      - wait 1t
      - inventory adjust slot:1 "lore:<&6>Owner<&co> <&e><player.name>"
      - inventory flag slot:1 owner:<player.uuid>
      - give item:CALEMIECONOMY_COIN_GOLD[quantity=2]
      - inventory set slot:9 o:communication_crystal d:<player.inventory>
      - flag player initialized:1
      - flag player comm_crystal_icon:stone
      - flag player name:<player.name>
      - flag player comm_crystal_color:<&7>