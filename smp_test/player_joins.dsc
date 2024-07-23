player_joins:
  type: world
  debug: false
  events:
    after player joins:
      - tablist update uuid:<player.uuid> listed:false