twice_daily_storms:
  type: world
  debug: false
  restart:
    - foreach <server.online_players>:
      - kick <[value]> "reason:<&e>Login server is restarting"
      - wait 1t
    - wait 5s
    - adjust server shutdown
  events:
    on system time 9:00:
      - run <script> path:restart
    on system time 21:00:
      - run <script> path:restart