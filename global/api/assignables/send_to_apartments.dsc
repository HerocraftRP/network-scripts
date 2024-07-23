send_to_apartment:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - ~run sql_set_inventory
    - ~run sql_set_character_data
    - ~run sql_set_player_data
    - adjust <player> send_to:apartments