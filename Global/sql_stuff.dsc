sql_init_inventory:
  type: task
  debug: false
  script:
    - flag <player> sql_init.inventory
    - ~sql id:players "update:INSERT INTO player_inventory (uuid, inventory, curios) VALUES ('<player.uuid>', '<player.inventory.map_slots>', '{}') ON DUPLICATE KEY UPDATE uuid = values(uuid);"

sql_set_inventory:
  type: task
  debug: false
  script:
    - ~sql id:players "update:UPDATE player_inventory SET uuid = '<player.uuid>', inventory = '<player.inventory.map_slots.to_json>' WHERE uuid = '<player.uuid>';"


sql_set_inventory2:
  type: task
  debug: false
  script:
    - ~sql id:players "update:UPDATE player_inventory SET uuid = '<player.uuid>', inventory = '<player.inventory.map_slots.to_json>', curios = '<player.items.to_json>' WHERE uuid = '<player.uuid>';"

sql_get_inventory:
  type: task
  debug: false
  script:
    - ~sql id:players "query:SELECT inventory FROM player_inventory WHERE uuid = '<player.uuid>';" save:inv
    - narrate <entry[inv].result_list.first.first>
      #- narrate <[key]>-<[value]>

sql_restore_inventory:
  type: task
  debug: false
  script:
    - ~sql id:players "query:SELECT inventory FROM player_inventory WHERE uuid = '<player.uuid>';" save:inv
    - inventory clear
    - foreach <entry[inv].result_list.first.first.parse_yaml||<list[]>>:
      - inventory set slot:<[key]> o:<[value]> d:<player.inventory>
    #- foreach <map[<entry[inv].result_list.first.get[2]>]>:
      #- if <[value]> == <item[air]>:
        #- foreach next
      #- adjust <player> curios_item:<[key]>|<item[<[value]>]>

player_transfer_server:
  type: task
  debug: false
  definitions: target|server
  script:
    - run sql_set_inventory
    - execute as_server "sync console bungee send <[target].name> <[server]>"

###Player Data

sql_init_player_data_table:
  type: task
  debug: false
  script:
    - ~sql id:players "update:CREATE TABLE IF NOT EXISTS player_data ( uuid VARCHAR(255), data MEDIUMTEXT, PRIMARY KEY (uuid) );"

sql_init_player_data:
  type: task
  debug: false
  script:
    - flag <player> sql_init.inventory
    - ~sql id:players "update:INSERT INTO player_data (uuid, data) VALUES ('<player.uuid>', '<player.flag[data].to_json>') ON DUPLICATE KEY UPDATE uuid = values(uuid);"

sql_set_player_data:
  type: task
  debug: false
  script:
    - ~sql id:players "update:UPDATE player_data SET uuid = '<player.uuid>', data = '<player.flag[data].to_json>' WHERE uuid = '<player.uuid>';"

sql_get_player_data:
  type: task
  debug: false
  script:
    - ~sql id:players "query:SELECT data FROM player_data WHERE uuid = '<player.uuid>';" save:inv
    - if <entry[inv].result_list.first.first.parse_yaml||null> == null:
      - stop
    - flag player data:<entry[inv].result_list.first.first.parse_yaml>

sql_read_player_data:
  type: task
  debug: false
  script:
    - ~sql id:players "query:SELECT data FROM player_data WHERE uuid = '<player.uuid>';" save:inv
    - narrate <entry[inv].result_list.first.first.parse_yaml>
