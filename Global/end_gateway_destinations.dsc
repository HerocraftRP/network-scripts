gateway_teleport:
  type: world
  debug: false
  events:
    on player teleports cause:END_GATEWAY bukkit_priority:LOWEST priority:-99999 ignorecancelled:true:
      #- flag <player> last_location:<player.location>
      - playsound sound:ENTITY_ENDERMAN_TELEPORT <player.location> pitch:0.1
      - title title:<&color[#000000]><&font[herocraft:overlay]><&chr[1004]><&chr[F802]><&chr[1004]> fade_in:1t fade_out:10t stay:1s
      - define gateway <player.location.find_blocks[end_gateway].within[2].get[1]>
      - flag <player> force_tp duration:2s
      - if <[gateway].has_flag[destination.location]> || <[gateway].has_flag[destination.server]>:
        - determine passively <player.location.forward[0.1]>
        - ratelimit <player> 5t
        - if <bungee.connected> && <[gateway].has_flag[destination.server]> && <[gateway].flag[destination.server]> != <bungee.server>:
          - if <[gateway].has_flag[destination.location]>:
            - bungeerun <[gateway].flag[destination.server]> gateway_teleport_bungee def:<player.uuid>|<[gateway].flag[destination.location]>
          - wait 1t
          - run tab_list_remove_single def:<[target]>
          - ~run sql_set_inventory def:<[target]>
          - ~run sql_set_character_data def:<[target]>
          - ~run sql_set_player_data def:<[target]>
          - wait 1s
          - adjust <player> send_to:<[gateway].flag[destination.server]>
          - wait 1t
          - stop
        - wait 1t
        - adjust <player> fall_distance:0
        - teleport <[gateway].flag[destination.location].parsed>

gateway_teleport_bungee:
  type: task
  debug: false
  definitions: uuid|location
  script:
    - flag server join_location.<[uuid]>.temp:<[location]>

gateway_teleport_force:
  type: world
  debug: false
  events:
    on player teleports flagged:force_tp bukkit_priority:HIGHEST ignorecancelled:true:
      - determine cancelled:false