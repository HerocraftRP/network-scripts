daily_restart:
  type: world
  debug: false
  events:
    on system time 09:00:
      - stop
    on system time 21:00:
      - stop