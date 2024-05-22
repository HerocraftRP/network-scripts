lay_in_hammock:
  type: task
  debug: true
  script:
    - determine passively cancelled
    - teleport <player> <context.location.flag[lay_position]>
    - execute as_server "emotes play 'Lay on back' <player.name>"