timed_events:
  type: world
  debug: false
  events:
    on tick every:3 server_flagged:switches.time:
      - adjust <server.worlds.first> time:<server.worlds.first.time.add[1]>
    on delta time minutely every:15:
      - foreach <server.online_players>:
        - ~run sql_set_inventory def:<[value]>
        - ~run sql_set_character_data def:<[value]>
        - ~run sql_set_player_data def:<[value]>
        - wait 1t