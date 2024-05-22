player_join:
  type: world
  debug: false
  events:
    on player join:
      - determine passively NONE
      - execute as_player vrc silent
      - wait 1t
      - adjust <player> gamemode:adventure
      - execute as_server "hiddenNames nameplateVisible <player.name> false"
      - wait 10t
      - run sql_restore_inventory if:<player.has_flag[initialized_now].not>
      - flag <player> temp:!
      - heal <player> 100
      - adjust <player> food_level:5 if:<player.food_level.is_less_than[5]>
      - adjust <player> thirst:5 if:<player.thirst.is_less_than[5]>
      - wait 1s
      - flag server name_map.<player.flag[data.name]>:<player>
      - run sql_get_player_data
      - adjust <player> name:<player.flag[data.name]>
      - define guild <player.flag[character.guild.name]||no_guild>
      - foreach <script[guild_data].data_key[data.<[guild]>.modifiers_by_rep.1]>:
        - wait 1t
        - if <[key]> == stamina_vessels:
          - adjust <player> stamina_vessels:<[value]>
        - if <[key]> == health:
          - foreach <[value]> key:part as:health:
            - part MAX part:<[part]> amount:<[health]>
    on player quits:
      - run sql_set_inventory
      - run sql_set_player_data
      - determine NONE