hunger_rate:
  type: world
  debug: false
  events:
    on system time secondly every:90:
      - foreach <server.online_players.filter[has_flag[character.god].not]>:
        - adjust <[value]> food_level:<[value].food_level.sub[1].max[0]>
    on item merges:
      - determine cancelled