gateway_event_handler:
  type: world
  debug: false
  enabled: false
  events:
    on delta time minutely every:30:
      - run open_gateway

open_gateway:
  type: task
  debug: false
  data:
    gateways:
      - crimson_wave
  script:
    - if <server.online_players.size> <= 0:
      - stop
    - define location <server.flag[gateway_locations].random>
    - announce "<&e>Rumors are spreading of a gateway opening in <&b><[location].biome.name.after[:].replace[_].with[<&sp>].to_titlecase>"
    - execute as_player "open_gateway <[location].x> <[location].y> <[location].z> herocraft<&co><script.data_key[data.gateways].random>" player:<server.online_players.random>

gateway_mob_event:
  type: world
  debug: false
  events:
    on gateway spawns entity:
      - announce <context.entity>
      - flag <context.entity> on_death:NO_DROPS
      - adjust <context.entity> health_data:20/20