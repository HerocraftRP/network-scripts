pirate_music:
  type: world
  debug: false
  events:
    on player joins:
      - wait 5s
      - adjust <player> stop_sound
      - playsound sound:herocraft:bucaneer_haul volume:0.05 <player> sound_category:ambient custom