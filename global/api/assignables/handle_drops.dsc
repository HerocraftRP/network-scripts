handle_drops:
  type: task
  debug: false
  script:
    - if <context.entity.has_flag[drops]>:
      - determine <context.entity.flag[drops]>
    - else:
      - determine NO_DROPS