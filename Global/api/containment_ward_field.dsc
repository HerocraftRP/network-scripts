initiate_containment_ward:
  type: task
  debug: false
  definitions: location|range|duration
  script:
    - flag server containment_ward_counter:+:1
    - define point1 <[location].with_yaw[0].forward_flat[<[range]>].right[<[range]>].below[100]>
    - define point2 <[location].with_yaw[0].backward_flat[<[range]>].left[<[range]>].above[100]>
    - note <[point1].to_cuboid[<[point2]>]> as:containment_ward_<server.flag[containment_ward_counter]>
    - flag <cuboid[containment_ward_<server.flag[containment_ward_counter]>]> player_leaves:anti_containment_stop
    - flag <cuboid[containment_ward_<server.flag[containment_ward_counter]>]> player_enters:anti_containment_inform
    - flag <cuboid[containment_ward_<server.flag[containment_ward_counter]>]> on_right_click:anti_containment_pearl
    - determine passively <server.flag[containment_ward_counter]>
    - if <[duration].exists>:
      - runlater initiate_containment_clear def:<server.flag[containment_ward_counter]> delay:<[duration]>

initiate_containment_clear:
  type: task
  debug: false
  definitions: number
  script:
    - note remove as:containment_ward_<[number]>

anti_containment_pearl:
  type: task
  debug: false
  script:
    - if <context.item.material.name> == ender_pearl:
      - narrate "<&c>The magic of this item is dampened by a Containment Ward."
      - determine cancelled

anti_containment_inform:
  type: task
  debug: false
  script:
    - ratelimit <player> 10s
    - wait 1s
    - if <player.location.cuboids.contains[<context.area>]>:
      - narrate "<&c>You are inside the Proximity of a Contaiment Ward."

anti_containment_stop:
  type: task
  debug: false
  script:
    - if <context.cause> == TELEPORT && <player.has_flag[force_tp]>:
      - stop
    - wait 1t
    - stop if:<player.is_online.not>
    - if <context.cause> == WALK:
      - teleport <context.from>
    - else:
      - teleport <player> <context.from.backward_flat>
    - ratelimit <player> 1s
    - narrate "<&c>A containment ward prevents you from leaving this area"