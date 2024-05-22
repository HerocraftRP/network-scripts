world_protection:
  type: world
  debug: false
  events:
    on player places block bukkit_priority:LOWEST:
      - determine passively cancelled if:<player.has_flag[admin_mode].not>
      - wait 1t
      - inventory update
    on player breaks block bukkit_priority:LOWEST:
      - determine cancelled if:<player.has_flag[admin_mode].not>
    on block explodes:
      - determine cancelled
    on player stands on material:
      - determine cancelled
    on player right clicks *_trapdoor bukkit_priority:LOWEST server_flagged:protected:
      - determine cancelled

admin_mode:
  type: command
  name: adminmode
  description: stuff
  usage: /adminmode
  permission: not.a.perm
  script:
    - if <player.has_flag[admin_mode]>:
      - flag <player> admin_mode:!
      - narrate "<&e>You are no longer in admin mode"
    - else:
      - flag <player> admin_mode
      - narrate "<&e>You are now in admin mode"

cancel:
  type: task
  debug: false
  script:
    - determine cancelled