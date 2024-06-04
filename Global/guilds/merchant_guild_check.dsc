merchant_guild_check:
  type: task
  debug: false
  script:
    - if <player.flag[character.capabilities.mercantile]||0> == 0:
      - determine passively cancelled
      - ratelimit <player> 1t
      - narrate "<&c>You have no business here."

merchant_guild_buy_supply_cart:
  type: command
  name: merchant_buy_supply_cart
  debug: false
  description: not.4.u
  usage: Nope
  permission: not.a.perm
  script:
    - define target <server.match_player[<context.args.get[1]>]>
    - adjust <queue> linked_player:<[target]>
    - inventory close
    - if !<[target].flag[character.capabilities.meracntile]||0> = 0:
      - narrate "<&c>I only sell to merchants."
      - stop
    - if !<[target].inventory.contains_item[coin_silver].quantity[5]>:
      - narrate "<&c>You need 5 Silver to rent a cart."
      - stop
    - take item:coin_silver quantity:5
    - modspawn entity:ASTIKORCARTS_SUPPLY_CART location:<server.flag[merchant_cart_spawn]> save:cart
    - adjust <entry[cart].entity> "custom_name:<[target].flag[data.name]>'s Supply Cart"
    - flag <entry[cart].entity> on_damaged:cancel
    - flag <entry[cart].entity> on_entity_added:remove_after_storm
    - flag <entry[cart].entity> owner:<player>
    - flag <entry[cart].entity> storm:<server.flag[shutdown_counter]>
    - flag <entry[cart].entity> right_click_script:supply_cart_open
    - look <player> <entry[cart].entity.location.above>