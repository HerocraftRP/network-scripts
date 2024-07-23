death_test:
  type: task
  debug: false
  script:
    - if !<player.has_flag[temp.carrying_body]>:
      - define target <player.target>
      - teleport <[target]> <[target].location.with_yaw[90]>
      - carry entity:<[target]>
      - remove <[target]>
      - flag player temp.carrying_body
    - else:
      - carry drop location:<player.location.forward_flat[1.8].above[0.8].with_yaw[<player.location.yaw.sub[90]>]>
      - flag player temp.carrying_body:!