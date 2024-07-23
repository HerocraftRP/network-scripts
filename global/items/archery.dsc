archery_basic_bow:
  type: item
  debug: false
  material: bow
  flags:
    on_item_shot: archery_process_shot
    damage: 1
    capability_needed: 1

archery_damage:
  type: task
  debug: false
  script:
    - determine <context.projectile.flag[damage]>

archery_process_shot:
  type: task
  debug: false
  script:
    - if <player.flag[character.capabilities.archery]||0> < <context.bow.flag[capability_needed]>:
      - adjust <context.projectile> velocity:<context.projectile.velocity.div[20]>
      - narrate "<&c>Your lack of archery skill impacts your ability to fire this weapon."
      - run add_framework_flag def:on_damaging|archery_damage|<context.projectile>
      - flag <context.projectile> damage:0.2
    - else:
      - run add_framework_flag def:on_damaging|archery_damage|<context.projectile>
      - flag <context.projectile> damage:<context.bow.flag[damage]>