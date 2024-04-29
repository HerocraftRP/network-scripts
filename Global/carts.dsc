cart_access:
  type: task
  debug: false
  script:
    - if <player.is_sneaking>:
      - flag <player> on_damaged:close_inventory
      - wait 5t
      - define location <player.location>
      - while <player.location> == <[location]>:
        - animate <player> animation:arm_swing
        - wait 10t
      - flag <player> on_damaged:!

close_inventory:
  type: task
  debug: false
  script:
    - wait 5t
    - inventory close player:<context.entity>