hunger_rate:
  type: world
  debug: false
  events:
    on delta time secondly every:90:
      - foreach <server.online_players>:
        - adjust <[value]> food_level:<[value].food_level.sub[1].max[0]>