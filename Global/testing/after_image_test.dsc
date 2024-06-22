after_image_test:
  type: task
  debug: false
  data:
    locations:
      - <player.location.backward_flat[3].left[2]>
      - <player.location.backward_flat[3].right[2]>
  script:
    - define locations <player.location.find_spawnable_blocks_within[6].random[20]>
    - foreach <[locations]>:
      - afterimage entity:<player> for:<server.online_players>
      - teleport <[value].with_yaw[]>
      - wait 3t