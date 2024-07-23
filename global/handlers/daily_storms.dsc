twice_daily_storms:
  type: world
  debug: false
  restart:
    - weather thunder <server.worlds.first>
    - wait 5m
    - title title:<&color[#000000]><&font[herocraft:overlay]><&chr[1004]><&chr[F802]><&chr[1004]> fade_in:5s fade_out:10t stay:1m targets:<server.online_players>
    - wait 6s
    - foreach <server.online_players>:
      - cast blindness duration:15s hide_particles <[value]>
    - wait 10s
    - foreach <server.online_players>:
      - run sql_set_inventory def:<[value]>
      - run sql_set_character_data def:<[value]>
      - run sql_set_player_data def:<[value]>
      - kick <[value]> "reason:<&e>The world is covered in a heavy storm"
      - wait 10t
    - flag server shutdown_counter:+:1
    - wait 5s
    - adjust server shutdown
  events:
    on system time 00:00:
      - run <script> path:restart
    on system time 12:00:
      - run <script> path:restart
    on lightning strikes:
      #- determine passively cancelled
      - teleport <context.lightning> <context.location.above[10]>
      - playsound sound:ENTITY_LIGHTNING_BOLT_THUNDER volume:3000 <context.location.above[300]>