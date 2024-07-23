mark_server_area:
  type: task
  debug: false
  definitions: pos_num|area
  script:
    - flag server regions.<[area]>.<[pos_num]>:<player.location>

create_server_area:
  type: task
  debug: false
  definitions: area
  script:
    - if !<server.has_flag[regions.<[area]>.1]>:
      - narrate "<&c>Need pos1"
      - stop
    - if !<server.has_flag[regions.<[area]>.2]>:
      - narrate "<&c>Need pos2"
      - stop
    - define transfer_cuboid <server.flag[regions.<[area]>.1].with_y[-64].to_cuboid[<server.flag[regions.<[area]>.2].with_y[320]>]>
    - define warning_cuboid <[transfer_cuboid].max.add[16,0,16].to_cuboid[<[transfer_cuboid].min.sub[16,0,16]>]>
    - note <[transfer_cuboid]> as:smaller_server_area_<[area]>
    - note <[warning_cuboid]> as:larger_server_area_<[area]>
    - flag <cuboid[smaller_server_area_<[area]>]> player_enters:player_enters_smaller_<[area]>
    - flag <cuboid[larger_server_area_<[area]>]> player_enters:player_enters_larger_<[area]>
    - flag <cuboid[smaller_server_area_<[area]>]> player_leaves:player_leaves_smaller_<[area]>
    - flag <cuboid[larger_server_area_<[area]>]> player_leaves:player_leaves_larger_<[area]>