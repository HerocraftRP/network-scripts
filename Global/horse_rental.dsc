horse_rental:
  type: item
  material: paper
  display name: <&6>Rental Horse

horse_sales:
  type: command
  name: rental_purchase
  debug: false
  description: Not for manual usage
  permission: not.a.perm
  usage: NO
  horse_rental:
    - if !<player.inventory.contains_item[COIN_SILVER].quantity[2]>:
      - narrate "<&e>You don't seem to have enough cash."
      - stop
    - take item:COIN_COPPER quantity:2
    - spawn horse[speed=0.18;jump_strength=0.5;max_health=20;health=20;owner=<player>;persistent=false] <server.flag[horse_rental_location]> save:horse
    - equip <entry[horse].spawned_entity> saddle:saddle
    - flag <entry[horse].spawned_entity> owner:<player>
  animal_cart:
    - if !<player.inventory.contains_item[COIN_SILVER].quantity[2]>:
      - narrate "<&e>You don't seem to have enough cash."
      - stop
    - take item:COIN_SILVER quantity:2
    - modspawn entity:astikorcarts_animal_cart location:<server.flag[horse_rental_location]> save:cart
    - wait 1t
    - flag <entry[cart].entity> owner:<player>
  work_cart:
    - if !<player.inventory.contains_item[COIN_SILVER].quantity[5]>:
      - narrate "<&e>You don't seem to have enough cash."
      - stop
    - take item:COIN_SILVER quantity:5
    - modspawn entity:astikorcarts_supply_cart location:<location[178,57,425,<player.location.world.name>]> save:cart
    - wait 1t
    - flag <entry[cart].entity> owner:<player>
  script:
    - adjust <queue> linked_player:<server.match_player[<context.args.get[2]>]>
    - inventory close
    - if <script.data_key[<context.args.get[1]>].exists>:
      - inject <script> path:<context.args.get[1]>

remove_horse_on_startup:
 type: task
 debug: false
 definitions: horse
 script:
   - remove <[horse]>

work_cart_rental:
  type: item
  material: paper
  display name: <&6>Rental Work Cart

animal_cart_rental:
  type: item
  material: paper
  display name: <&6>Rental Cart

store_cart:
  type: command
  name: store_cart
  permission: not.a.perm
  debug: false
  script:
    - adjust <queue> linked_player:<server.match_player[<context.args.get[1]>]>
    - define cart <player.location.find_entities[astikorcarts*].within[14].filter[flag[owner].uuid.equals[<player.uuid>]].first||null>
    - if <[cart]> == null:
      - narrate "<&c>Cart not close enough"
      - stop
    - if <player.has_flag[character.stored_cart]>:
      - narrate "<&c>You already have a cart stored."
      - stop
    - if <[cart].entity_type> == ASTIKORCARTS_WORK_CART:
      - flag player character.stored_cart.inventory:<[cart].supply_cart_inventory.list_contents>
    - flag <player> character.stored_cart.type:<[cart].entity_type>
    - remove <[cart]>
    - narrate "<&e>Your cart has been safely stored."

withdraw_cart:
  type: command
  name: withdraw_cart
  permission: not.a.perm
  debug: false
  script:
    - adjust <queue> linked_player:<server.match_player[<context.args.get[1]>]>
    - if !<player.has_flag[character.stored_cart]>:
      - narrate "<&c>You have no stored cart"
      - stop
    - modspawn entity:<player.flag[character.stored_cart.type]> location:<server.flag[horse_rental_location]> save:cart
    - if <player.flag[character.stored_cart.type]> == ASTIKORCARTS_WORK_CART:
      - adjust <entry[cart].entity> supply_cart_inventory:<player.flag[character.stored_cart.inventory]>
    - flag player character.stored_cart:!
    - flag <entry[cart].entity> owner:<player>
    - narrate "<&e>Your cart has been withdrawn outside."