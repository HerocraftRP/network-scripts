add_framework_flag:
  type: task
  debug: false
  definitions: flag|value|target
  script:
    - define target <player> if:<[target].exists.not>
    - flag <[target]> <[flag]>:->:<[value]>

remove_framework_flag:
  type: task
  debug: false
  definitions: flag|value|target
  script:
    - define target <player> if:<[target].exists.not>
    - flag <[target]> <[flag]>:<-:<[value]>
    - if <[target].flag[<[flag]>].is_empty:
      - flag <[target]> <[flag]>:!