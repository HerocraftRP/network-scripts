initiate_anti_magic_ward:
  type: task
  debug: false
  definitions: location|range|duration
  script:
    - flag server anti_teleport_ward_counter:+:1
    - define point1 <[location].with_yaw[0].forward_flat[<[range]>].right[<[range]>].below[<[range]>]>
    - define point2 <[location].with_yaw[0].backward_flat[<[range]>].left[<[range]>].above[<[range]>]>
    - note <[point1].to_cuboid[<[point2]>]> as:anti_teleport_ward_<server.flag[anti_teleport_ward_counter]>
    - flag <cuboid[anti_teleport_ward_<server.flag[anti_teleport_ward_counter]>]> on_teleport:anti_magic_stop
    - flag <cuboid[anti_teleport_ward_<server.flag[anti_teleport_ward_counter]>]> on_spell_cast:anti_magic_stop
    - determine passively <server.flag[anti_teleport_ward_counter]>
    - if <[duration].exists>:
      - runlater initiate_anti_magic_ward_clear def:<server.flag[anti_teleport_ward_counter]> delay:<[duration]>

initiate_anti_magic_ward_clear:
  type: task
  debug: false
  definitions: number
  script:
    - note remove as:anti_teleport_ward_<[number]>

anti_magic_stop:
  type: task
  debug: false
  script:
    - narrate "<&c>Your magic is blocked by an anti-magic area spell."
    - determine passively cancelled
    - stop