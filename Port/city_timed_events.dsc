city_timed_events:
  type: world
  debug: false
  events:
    #Bridge
    on time 19:
      - run toggle_bridge
      - run chime_bells
    on time 6:
      - run toggle_bridge
      - run chime_bells
      - foreach <server.online_players.filter[has_flag[temp.job.name]]>:
        - if <script[job_data].data_key[data.jobs.<[value].flag[temp.job.name]>.job_shift]> == day:
          - run job_sign_out player:<[value]>

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