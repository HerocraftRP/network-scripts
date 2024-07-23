invulnerable:
  type: task
  debug: false
  script:
    - if <context.entity.health_max> < 1000:
      - adjust <context.entity> max_health:1028
    - heal <context.entity> 2000