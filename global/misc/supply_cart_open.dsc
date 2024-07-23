supply_cart_open:
  type: task
  debug: false
  script:
    - if <player.is_sneaking>:
      - determine passively cancelled
      - run start_timed_action "def:<&e>Checking Cart Inventory|4s|supply_cart_open_callback|<context.entity>" def.can_move:false


supply_cart_open_callback:
  type: task
  debug: false
  definitions: cart
  script:
    - inventory open d:<[cart].supply_cart_inventory>