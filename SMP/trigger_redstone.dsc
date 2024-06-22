trigger_redstone:
  type: task
  debug: false
  script:
    - wait 1t
    - if <context.location.switched>:
      - define state on
    - else:
      - define state off
    - switch <context.location.flag[linked_locations].exclude[<context.location>]> <[state]>