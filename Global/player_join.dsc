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
      - flag <player> timed_action:!
      # Feed and Water my little pretties
      - heal <player> 100
      - if <player.has_flag[character.thirst]>:
        - adjust <player> thirst:<player.flag[character.thirst]>
      - if <player.has_flag[character.hunger]>:
        - adjust <player> food_level:<player.flag[character.hunger]>
      - wait 1s
      # Name Map for the reasons
      - flag server name_map.<player.flag[data.name]>:<player>
      # Unlock Player Camera
      - perspective ENUM:0
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
      - run set_character_traits
    on player quits:
      - define target <player||null>
      - if <[target]> == null:
        - stop
      - run tab_list_remove_single def:<[target]>
      - run sql_set_inventory def:<[target]>
      - run sql_set_character_data def:<[target]>
      - run sql_set_player_data def:<[target]>
      - flag server name_map.<player.flag[data.name]>:!
      - determine NONE

set_character_traits:
  type: task
  debug: false
  data:
    clothing_map:
      feet: 0
      bottom: 1
      top: 2
      helmet: 3
    races:
      Human:
        base_scale: 1
      Orc:
        base_scale: 1.1
      Elytrian:
        base_scale: 0.8
      Fae:
        base_scale: 0.3
    height_map:
      Very Short: 0.9
      Short: 0.95
      Average: 1
      Tall: 1.05
      Very Tall: 1.1
    weight_map:
      Very Light: 0.9
      Light: 0.95
      Average: 1
      Heavy: 1.05
      Very Heavy: 1.1
  script:
    # Clothing
    - foreach <player.flag[character.clothing].keys>:
      - define slot <script.data_key[data.clothing_map.<[value]>]>
      - define clothing <script[clothing_data].data_key[clothes.<[slot]>.<player.flag[character.clothing.<[value]>]>.material]>
      - adjust <player> cosmetic_armor:<[slot]>|<[clothing]>
    # Wings/Elytra
    - if <player.has_flag[character.wings]> || <player.has_flag[character.elytra1]>:
      - if <player.has_flag[character.wings]>:
        - adjust <player> curios_item:back|<item[<player.flag[character.wings]>].with_flag[run_script:cancel]>
      - if <player.has_flag[character.elytra1]>:
        - adjust <player> curios_item:back|<proc[get_colored_elytra].context[<player.flag[character.elytra1]>|<player.flag[character.elytra2]>]>
    - else:
      - adjust <player> curios_item:back|air
    # Sizing
    - execute as_server "setskin <player.flag[character.skin]> <player.name>"
    - execute as_server "scale set pehkui:base <script.data_key[data.races.<player.flag[character.race]>.base_scale]> <player.name>"
    - execute as_server "scale set pehkui:width <player.flag[character.weight]> <player.name>"
    - execute as_server "scale set pehkui:height <player.flag[character.height]> <player.name>"
    - execute as_server "setmodel <player.flag[character.model]> <player.name>"
    # Health
    - if <player.has_flag[character.capabilities.endurance]>:
      - run endurance_gain_<player.flag[character.capabilities.endurance].div[25].round>