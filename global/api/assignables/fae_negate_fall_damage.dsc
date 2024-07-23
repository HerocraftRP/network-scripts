racial_negate_fall_damage:
  type: task
  debug: false
  script:
    - if <context.cause> == FALL || <context.cause> == FLY_INTO_WALL:
      - determine cancelled