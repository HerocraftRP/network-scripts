timed_events:
  type: world
  debug: false
  events:
    on tick every:3 server_flagged:switches.time:
      - adjust <server.worlds.first> time:<server.worlds.first.time.add[1]>