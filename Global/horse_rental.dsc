horse_rental:
  type: item
  material: paper
  display name: <&6>Rental Horse

horse_sales:
  type: command
  name: rental_purchase
  debug: false
  description: Not for manual usage
  usage: NO
  horse_rental:
    - spawn horse[speed=0.12;jump_strength=0.5;max_health=20;health=20;owner=<player>;persistent=false] <location[horse_rental_location]> save:horse
    - equip <entry[horse].spawned_entity> saddle:saddle
    - flag <entry[horse].spawned_entity> on_startup:remove_horse_on_startup
  animal_cart_rental:
    - modspawn entity:astikorcarts_animal_cart location:<location[178,57,425,<player.location.world.name>]> save:cart
    - wait 5t
    - flag <entry[cart]> on_startup:remove_horse_on_startup
  work_cart_rental:
    - modspawn entity:astikorcarts_supply_cart location:<location[178,57,425,<player.location.world.name>]> save:cart
    - wait 5t
    - flag <entry[cart]> on_startup:remove_horse_on_startup
  script:
    - adjust <queue> linked_player:<server.match_player[<context.args.get[2]>]>
    - inventory close
    - if <script.data_key[<context.args.get[1]>].exists>:
      - if !<player.inventory.contains_item[COIN_SILVER].quantity[2]>:
        - narrate "<&e>You don't seem to have enough cash."
        - stop
      - take item:COIN_SILVER quantity:2
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