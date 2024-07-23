remove_after_storm:
  type: task
  debug: false
  script:
    - wait 1t
    - if <context.entity.flag[storm]||0> < <server.flag[shutdown_counter]>:
      - remove <context.entity>