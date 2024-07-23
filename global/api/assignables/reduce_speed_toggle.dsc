reduce_speed_toggle:
  type: task
  debug: false
  script:
    - ratelimit <player> 1t
    - stop if:<player.flag[character.capbilities.endurance].is_more_than[99]||false>
    - wait 1t
    - if <player.is_sprinting>:
      - run reduce_speed_loop def:<player.location.simple>
      - stop
    - define simple <player.location.simple>
    - if !<player.location.above[0.05].with_pitch[0].ray_trace[range=2.5;return=block;default=air].has_flag[on_step]>:
      - adjust <player> walk_speed:<player.flag[character.walk_speed]>
      - stop
    - adjust <player> walk_speed:0.11 if:<player.is_sprinting.not>
    - run reduce_speed_loop def:<[simple]>

reduce_speed_loop:
  type: task
  debug: false
  definitions: simple
  script:
    - while <player.location.simple> == <[simple]>:
      - wait 5t
    - if !<player.location.below[0.49].has_flag[on_step]> || <player.location.below[0.49].flag[on_step]> != reduce_speed_toggle || <player.is_sprinting>:
      - adjust <player> walk_speed:<player.flag[character.walk_speed]>