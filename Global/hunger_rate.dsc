hunger_rate:
  type: world
  debug: false
  events:
    on system time secondly every:60:
      - flag server hunger_tick:+:1
      - if <server.flag[hunger_tick]> >= 2:
        - foreach <server.online_players.filter[has_flag[character.god].not]>:
          - adjust <[value]> food_level:<[value].food_level.sub[1].max[0]>
          - adjust <[value]> thirst:<[value].thirst.sub[1].max[0]>
          - flag <[value]> character.hunger:<[value].food_level>
          - flag <[value]> character.thirst:<[value].thirst>
          - flag server hunger_tick:0
      - else:
        - foreach <server.online_players.filter[has_flag[character.god].not]>:
          - adjust <[value]> thirst:<[value].thirst.sub[1].max[0]>
          - flag <[value]> character.hunger:<[value].food_level>
          - flag <[value]> character.thirst:<[value].thirst>
    on item merges:
      - determine cancelled