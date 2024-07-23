create_button:
  type: task
  debug: false
  script:
    - define toggle <server.flag[create.<context.location.flag[create_button]>]>
    - if <[toggle].switched>:
      - switch <[toggle]> off
      - wait 2t
    - switch <[toggle]> on
    - wait 1s
    - switch <[toggle]> off