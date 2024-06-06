player_join:
  type: world
  debug: false
  events:
    on player join:
      - determine passively NONE
      - wait 1s
      # Plasmo Voice likes to suck
      - execute as_player vrc silent
      # Standard whosa whatsits
      - adjust <player> gamemode:adventure
      - execute as_server "hiddenNames nameplateVisible <player.name> false"
      - wait 10t
      # Remove temp data, shit is useless
      - flag <player> temp:!
      # Feed and Water my little pretties
      - heal <player> 100
      - if <player.has_flag[character.thirst]>:
        - adjust <player> thirst:<player.flag[character.thirst]>
      - if <player.has_flag[character.hunger]>:
        - adjust <player> food_level:<player.flag[character.hunger]>
      - heal <player> 100
      - wait 1s
      # Name Map for the reasons
      - flag server name_map.<player.flag[data.name]>:<player>
      # Load the SQL shit
      - ~run sql_get_character_data
      - ~run sql_restore_inventory if:<player.has_flag[initialized_now].not>
      - execute as_server "setskin <player.flag[character.skin]> <player.name>"
      # Character Display Name catch
      - if !<player.flag[character.name.display].exists>:
        - flag player character.name.display:<player.flag[data.name].replace[_].with[<&sp>].to_titlecase>
      # Handle Tab List (Fuck Dat Hoe)
      - run tab_list_update_single def:<player>
      - define uuid <player.uuid>
      - foreach <server.online_players>:
        - tablist update display:<empty> uuid:<[uuid]> listed:false player:<[value]>
        - tablist update display:<empty> listed:false uuid:<[value].uuid>
      # Endurance
      - adjust <player> health_vessels:<player.flag[character.endurance_level]||0>
      - adjust <player> stamina_vessels:<player.flag[character.endurance_level]||0>
      - flag <player> character.walk_speed:0.2
      - adjust <player> walk_speed:<player.flag[character.walk_speed]>
      # Set their Clothes
      - repeat 4:
        - define slot <[value].sub[1]>
        - define player_clothes <player.flag[character.cosmetic_armor.<[slot]>]||0>
        - adjust player cosmetic_armor:<list[<[slot]>|<script[clothing_data].data_key[clothes.<[slot]>.<[player_clothes]>.material]>]>
    on player quits:
      - define target <player||null>
      - if <[target]> == null:
        - stop
      - run tab_list_remove_single def:<[target]>
      - ~run sql_set_inventory def:<[target]>
      - ~run sql_set_character_data def:<[target]>
      - ~run sql_set_player_data def:<[target]>
      - flag server name_map.<player.flag[data.name]>:!
      - determine NONE

set_player_name:
  type: task
  debug: false
  definitions: uuid|name
  script:
    - flag server temp.awaiting.<[uuid]>:<[name]<>