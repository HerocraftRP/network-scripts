cooking_get_bowl:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - ratelimit <player> 2s
    - if <player.item_in_hand.material.name> == air && <player.flag[temp.job.name]> == cooking:
      - inventory set slot:<player.held_item_slot> o:bowl
      - playsound sound:ENTITY_ITEM_PICKUP volume:4 <player>

cooking_get_bottle:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - ratelimit <player> 2s
    - if <player.item_in_hand.material.name> == air && <player.flag[temp.job.name]> == cooking:
      - inventory set slot:<player.held_item_slot> o:glass_bottle
      - playsound sound:ENTITY_ITEM_PICKUP volume:4 <player>

cooking_refill_furnace:
  type: task
  debug: false
  script:
    - if <player.flag[temp.job.name]||null> != cooking:
      - determine cancelled
    - adjust <context.location.inventory> fuel:<item[coal].with[quantity=64].with_flag[run_script:cancel]>

cooking_cancel:
  type: task
  debug: false
  script:
    - if <player.flag[temp.job.name]||null> != cooking:
      - determine cancelled

cooking_cancel2:
  type: task
  debug: false
  data:
    whitelist:
      farmersdelight_flint_knife: true
      farmersdelight_iron_knife: true
      farmersdelight_gold_knife: true
      farmersdelight_diamond_knife: true
      farmersdelight_netherite_knife: true
      farmersdelight_apple_pie: true
      FARMERSDELIGHT_CABBAGE: true
      FARMERSDELIGHT_wheat_dough: true
      chicken: true
      beef: true
      porkchop: true
      air: true
  script:
    - if !<script.data_key[data.whitelist.<player.item_in_hand.material.name>].exists> || <player.flag[temp.job.name]||null> != cooking:
      - determine passively cancelled
      - wait 1t
      - modifyblock <context.location> air naturally:air
      - modifyblock <context.location> farmersdelight_cutting_board
      - foreach <context.location.find_entities[dropped_item].within[2].filter[item.material.name.equals[farmersdelight_cutting_board]]>:
        - remove <[value]>
    - wait 5t
    - inventory update

cooking_cancel_drop_self:
  type: task
  debug: false
  script:
    - foreach <context.drop_entities> as:entity:
      - announce "<[entity].item.material.name> -- <context.material.name>"
      - if <[entity].item.material.name> == <context.material.name>:
        - remove <[entity]>

cooking_get_water:
  type: task
  debug: false
  script:
    - ratelimit <player> 5t
    - if <player.item_in_hand.material.name> == bucket:
      - wait 1t
      - inventory set slot:<player.held_item_slot> o:water_bucket
      - narrate "<&e>You retrieve water from the well"