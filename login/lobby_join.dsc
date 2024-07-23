lobby_clear_items:
  type: world
  debug: false
  events:
    on player joins:
      - adjust <player> gamemode:adventure
      - wait 1s
      - inventory clear