set_speed_command:
  type: command
  name: set_speed
  debug: false
  usage: /set_speed (normal/slow/very_slow)
  description: for modifying your walk speed
  script:
    - if ( <player.has_flag[temp.walk_speed]> && <player.walk_speed.round_down_to_precision[0.05]> == <player.flag[temp.walk_speed]> ) || <player.walk_speed> == 0.2:
      - if <context.args.get[1]> == normal:
        - adjust <player> walk_speed:0.2
        - flag <player> temp.walk_speed:!
      - else if <context.args.get[1]> == slow:
        - adjust <player> walk_speed:0.15
        - flag <player> temp.walk_speed:0.15
      - else if <context.args.get[1]> == very_slow:
        - adjust <player> walk_speed:0.1
        - flag <player> temp.walk_speed:0.1