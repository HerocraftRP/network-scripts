mirv_arrow:
  type: task
  debug: false
  script:
    - wait 2t
    - define location1 <context.projectile.location>
    - wait 1t
    - define location2 <context.projectile.location>
    - repeat 5:
      - spawn arrow <[location2].random_offset[0.5,0.5,0.5]> save:arrow
      - adjust <entry[arrow].spawned_entity> velocity:<[location2].sub[<[location1]>]>

sign_arrow:
  type: task
  debug: false
  script:
    - flag <context.projectile> on_projectile_hits:sign_arrow_place
    - flag <context.projectile> shooter:<player>

sign_arrow_place:
  type: task
  debug: false
  script:
    - modifyblock <context.hit_block.add[<context.hit_face>]> oak_sign
    - adjust <context.projectile.flag[shooter]> edit_sign:<context.hit_block.add[<context.hit_face>]>