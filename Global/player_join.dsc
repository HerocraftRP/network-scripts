player_join:
  type: world
  debug: false
  events:
    on player join:
      - execute as_server "hiddenNames nameplateVisible <player.name> false"
      - cast effect:xaeroworldmap_no_world_map duration:24h no_ambient no_icon no_clear hide_particles
      - cast effect:xaerominimap_no_minimap duration:24h no_ambient no_icon no_clear hide_particles
      - flag <player> temp:!
      - determine passively NONE
      - wait 5s
      - adjust <player> gamemode:adventure
      - execute as_player vrc silent
      - teleport <player> <server.flag[spawn]>
    on player quits:
      - determine NONE