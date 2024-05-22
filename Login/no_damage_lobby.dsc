no_damage_lobby:
  type: world
  debug: false
  events:
    on delta time secondly:
      - foreach <server.online_players>:
        - heal <[value]>
        - feed <[value]>
        - adjust <[value]> thirst:20