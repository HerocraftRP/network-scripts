grabbing_arrow:
  type: task
  debug: false
  script:
    - flag <context.projectile> on_projectile_hits:arrow_grabbing_pull

arrow_grabbing_pull:
  type: task
  debug: false
  script:
    - if <context.hit_entity||null> != null && <context.shooter.is_online>:
      - repeat 9999:
        - if !<context.shooter.is_online>:
          - stop
        - if !<context.hit_entity.is_spawned>:
          - stop
        - if <context.shooter.location.distance[<context.hit_entity.location>]> < 1.25:
          - stop
        - teleport <context.hit_entity> <context.hit_entity.location.points_between[<context.shooter.location>].distance[1].get[2]>
        - wait 1t