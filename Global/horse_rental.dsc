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
    - execute as_server "summon astikorcarts:animal_cart 178 57 425"
    - wait 5t
    - foreach <location[178,57,425,world].find_entities[astikorcarts_animal_cart].within[3]>:
      - flag <[value]> on_startup:remove_horse_on_startup
  work_cart_rental:
    - execute as_server "summon astikorcarts:supply_cart 178 57 425"
    - wait 5t
    - foreach <location[178,57,425,world].find_entities[astikorcarts_supply_cart].within[3]>:
      - flag <[value]> on_startup:remove_horse_on_startup
  script:
    - adjust <queue> linked_player:<server.match_player[<context.args.get[2]>]>
    - inventory close
    - if <script.data_key[<context.args.get[1]>].exists>:
      - if !<player.inventory.contains_item[CALEMIECONOMY_COIN_SILVER].quantity[2]>:
        - narrate "<&e>You don't seem to have enough cash."
        - stop
      - take item:CALEMIECONOMY_COIN_SILVER quantity:2
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