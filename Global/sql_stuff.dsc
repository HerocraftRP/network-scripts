

sql_init_player_inventory_table:
  type: task
  debug: false
  definitions: target
  script:
    - define target <player> if:<[target].exists.not>
    - ~sql id:players "update:CREATE TABLE IF NOT EXISTS player_inventory ( uuid VARCHAR(255), inventory MEDIUMTEXT, curios MEDIUMTEXT, PRIMARY KEY (uuid) );"

sql_init_inventory:
  type: task
  debug: false
  definitions: target
  script:
    - define target <player> if:<[target].exists.not>
    - ~sql id:players "update:INSERT INTO player_inventory (uuid, inventory, curios) VALUES ('<player.uuid>_<player.flag[data.name].escaped>', '<player.inventory.map_slots.escaped>', '{}') ON DUPLICATE KEY UPDATE uuid = values(uuid);"

sql_set_inventory:
  type: task
  debug: false
  definitions: target
  script:
    - define target <player> if:<[target].exists.not>
    - if <[target].object_type> != PLAYER:
      - stop
    - ~sql id:players "update:UPDATE player_inventory SET inventory = '<[target].inventory.map_slots.escaped>' WHERE uuid = '<[target].uuid>_<[target].flag[data.name].escaped>';"

sql_set_inventory2:
  type: task
  debug: false
  definitions: target
  script:
    - define target <player> if:<[target].exists.not>
    - ~sql id:players "update:UPDATE player_inventory SET uuid = '<[target].uuid>', inventory = '<[target].inventory.map_slots.escaped>', curios = '<[target].items.to_json>' WHERE uuid = '<player.uuid>';"

sql_get_inventory:
  type: task
  debug: false
  definitions: target
  script:
    - define target <player> if:<[target].exists.not>
    - if <[target].object_type> != PLAYER:
      - stop
    - ~sql id:players "query:SELECT inventory FROM player_inventory WHERE uuid = '<[target].uuid>_<[target].flag[data.name].escaped>';" save:inv
    - narrate <entry[inv].result_list.first.first>
      #- narrate <[key]>-<[value]>

sql_restore_inventory:
  type: task
  debug: false
  definitions: target
  script:
    - define target <player> if:<[target].exists.not>
    - if <[target].object_type> != PLAYER:
      - stop
    - ~sql id:players "query:SELECT inventory FROM player_inventory WHERE uuid = '<[target].uuid>_<[target].flag[data.name].escaped>';" save:inv
    - inventory clear
    - foreach <entry[inv].result_list.first.first.unescaped||<list[]>>:
      - if <[key]||null> == null:
        - stop
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
  definitions: target
  script:
    - define target <player> if:<[target].exists.not>
    - if <[target].object_type> != PLAYER:
      - stop
    - ~sql id:players "update:INSERT INTO player_data (uuid, data) VALUES ('<[target].uuid>', '<[target].flag[data].to_json.escaped>') ON DUPLICATE KEY UPDATE uuid = values(uuid);"

sql_set_player_data:
  type: task
  debug: false
  definitions: target
  script:
    - define target <player> if:<[target].exists.not>
    - if <[target].object_type> != PLAYER:
      - stop
    - ~sql id:players "update:UPDATE player_data SET data = '<[target].flag[data].to_json.escaped>' WHERE uuid = '<[target].uuid>';"

sql_get_player_data:
  type: task
  debug: false
  definitions: target
  script:
    - define target <player> if:<[target].exists.not>
    - if <[target].object_type> != PLAYER:
      - stop
    - ~sql id:players "query:SELECT data FROM player_data WHERE uuid = '<[target].uuid>';" save:inv
    - if <entry[inv].result_list.first.first.unescaped||null> == null:
      - stop
    - flag player data:<entry[inv].result_list.first.first.unescaped.parse_yaml>

sql_read_player_data:
  type: task
  debug: false
  definitions: target
  script:
    - define target <player> if:<[target].exists.not>
    - if <[target].object_type> != PLAYER:
      - stop
    - ~sql id:players "query:SELECT data FROM player_data WHERE uuid = '<[target].uuid>';" save:inv
    - narrate <entry[inv].result_list.first.first.unescaped.parse_yaml>

sql_init_character_data_table:
  type: task
  debug: false
  script:
    - ~sql id:players "update:CREATE TABLE IF NOT EXISTS character_data ( uuid VARCHAR(255), data MEDIUMTEXT, PRIMARY KEY (uuid) );"

sql_init_character_data:
  type: task
  debug: false
  definitions: target
  script:
    - define target <player> if:<[target].exists.not>
    - if <[target].object_type> != PLAYER:
      - stop
    - flag <player> sql_init.inventory
    - ~sql id:players "update:INSERT INTO character_data (uuid, data) VALUES ('<[target].uuid>_<[target].flag[data.name].escaped>', '<[target].flag[character].to_json.escaped>') ON DUPLICATE KEY UPDATE uuid = values(uuid);"

sql_set_character_data:
  type: task
  debug: false
  definitions: target
  script:
    - define target <player> if:<[target].exists.not>
    - if <[target].object_type> != PLAYER:
      - stop
    - ~sql id:players "update:UPDATE character_data SET data = '<[target].flag[character].to_json.escaped>' WHERE uuid = '<[target].uuid>_<[target].flag[data.name].escaped>';"

sql_get_character_data:
  type: task
  debug: false
  definitions: target
  script:
    - define target <player> if:<[target].exists.not>
    - if <[target].object_type> != PLAYER:
      - stop
    - ~sql id:players "query:SELECT data FROM character_data WHERE uuid = '<[target].uuid>_<[target].flag[data.name].escaped>';" save:inv
    - if <entry[inv].result_list.first.first.unescaped||null> == null:
      - stop
    - flag player character:<entry[inv].result_list.first.first.unescaped.parse_yaml>