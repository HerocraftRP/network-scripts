murder_swim:
  type: world
  debug: false
  enabled: true
  events:
    on tick every:20:
      - foreach <server.online_players.filter[location.material.name.equals[water]]>:
        - adjust <[value]> velocity:0,-1,0 if:<[value].swimming.not>