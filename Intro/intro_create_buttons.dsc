toggle_bridge:
  type: task
  debug: false
  script:
     - switch <server.flag[data.bridge_button]> on
     - wait 5t
     - switch <server.flag[data.bridge_button]> off

chime_bells:
  type: task
  debug: false
  script:
    - switch <server.flag[data.bell_button]> on
    - wait 1s
    - repeat 3:
      - playsound sound:BLOCK_BELL_USE volume:99999 <server.flag[bell_locations]> pitch:0.25
      - wait 2s
      - switch <server.flag[data.bell_button]> off