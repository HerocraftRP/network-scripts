overworld_biome_prevention:
  type: world
  debug: false
  events:
    after player exits biome biome:plains server_flagged:switches.biome_lock:
      - narrate "<&d>A magical force repels you..."
      - while <player.location.biome.name> != plains:
        - adjust <player> velocity:<server.flag[plains_center].sub[<player.location>].normalize.mul[2].with_y[0.5]>
        - wait 1s