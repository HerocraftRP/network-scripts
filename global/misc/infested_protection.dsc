NO_INFESTED_BRICKS:
  type: world
  debug: false
  events:
    on player places infested_*:
      - narrate "<&c>YOU HAVE PLACED AN INFESTED BLOCK!!!!"
      - title "title:<&c>YOU HAVE PLACED AN INFESTED BLOCK!!!!"