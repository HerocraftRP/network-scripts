camera_test:
  type: task
  debug: false
  script:
    - define init_loc <player.eye_location.backward_flat.with_yaw[<player.location.yaw.round_to_precision[45]>]>
    - define locations <list[<[init_loc]>]>
    - define locations <[locations].include[<[init_loc].backward_flat[10].above[5]>]>
    - define locations <[locations].include[<[init_loc].backward_flat[5].right[5].above[5].with_yaw[<[init_loc].yaw.add[-45]>]>]>
    - define locations <[locations].include[<[init_loc].right[10].above[5].with_yaw[<[init_loc].yaw.add[-90]>]>]>
    - define locations <[locations].include[<[init_loc].forward_flat[10].right[7].above[5].with_yaw[<[init_loc].yaw.add[-135]>]>]>
    - define locations <[locations].include[<[init_loc].forward_flat[20].above[5].with_yaw[<[init_loc].yaw.add[-180]>]>]>
    - define locations <[locations].include[<[init_loc].forward_flat[10].left[7].above[5].with_yaw[<[init_loc].yaw.add[-225]>]>]>
    - define locations <[locations].include[<[init_loc].left[10].above[5].with_yaw[<[init_loc].yaw.add[90]>]>]>
    - execute as_server "cam-server create test_<player.uuid>"
    - execute as_server "cam-server get test_<player.uuid> mode outside"
    - execute as_server "cam-server get test_<player.uuid> interpolation hermite"
    - foreach <[locations]> as:loc:
      - execute as_server "cam-server get test_<player.uuid> add <[loc].x> <[loc].y> <[loc].z> <[loc].yaw> 20 0 90"
    - execute as_server "cam-server get test_<player.uuid> add <[locations].first.x> <[locations].first.y> <[locations].first.z> <[locations].first.yaw> 20 0 90"
    - execute as_server "cam-server start test_<player.uuid> <player.name> 1m -1"
    - wait 5s
    - execute as_server "cam-server remove test_<player.uuid>"

camera_intro_start_test:
  type: task
  debug: false
  script:
    - define start <player.location>
    - adjust <player> gravity:false
    - execute as_server "cam-server start intro_test <player.name>"
    - repeat 4:
      - teleport <server.flag[introtest.<[value]>].with_y[100]>
      - wait 13s
    - teleport <[start]>
    - adjust <player> gravity:true