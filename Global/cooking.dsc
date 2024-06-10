cooking_get_bowl:
  type: task
  debug: false
  script:
    - determine passively cancelled if:<player.item_in_hand.material.name.ends_with[spell_book].not||true>
    - ratelimit <player> 2s
    - if <player.item_in_hand.material.name> == air:
      - inventory set slot:<player.held_item_slot> o:bowl
      - playsound sound:ENTITY_ITEM_PICKUP volume:4 <player>

cooking_get_bottle:
  type: task
  debug: false
  script:
    - determine passively cancelled if:<player.item_in_hand.material.name.ends_with[spell_book].not||true>
    - ratelimit <player> 2s
    - if <player.item_in_hand.material.name> == air:
      - inventory set slot:<player.held_item_slot> o:glass_bottle
      - playsound sound:ENTITY_ITEM_PICKUP volume:4 <player>

cooking_refill_furnace:
  type: task
  debug: false
  script:
    - adjust <context.location.inventory> fuel:<item[coal].with[quantity=64].with_flag[run_script:cancel]>

cooking_cancel:
  type: task
  debug: false
  script:
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
      FARMERSDELIGHT_sweet_berry_cheesecake: true
      cake: true
      chicken: true
      beef: true
      porkchop: true
      air: true
  script:
    - if !<script.data_key[data.whitelist.<player.item_in_hand.material.name>].exists>:
      - determine passively cancelled if:<player.item_in_hand.material.name.ends_with[spell_book].not||true>
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
    - determine passively cancelled if:<player.item_in_hand.material.name.ends_with[spell_book].not||true>
    - ratelimit <player> 5t
    - if <player.item_in_hand.material.name> == bucket || <player.item_in_hand.material.name> == glass_bottle || <player.item_in_hand.material.name> == toughasnails_empty_canteen:
      - wait 1t
      - run start_timed_action "def:<&6>Retrieving Water|5s|cooking_get_water_callback|<player.item_in_hand>" def.can_swap_items:false def.can_move:false

cooking_get_water_callback:
  type: task
  debug: false
  definitions: item_in_hand
  script:
    - if <player.item_in_hand.material.name> == bucket:
      - inventory set slot:<player.held_item_slot> o:water_bucket
    - else if <player.item_in_hand.material.name> == glass_bottle:
      - inventory set slot:<player.held_item_slot> o:potion[potion_effects=li@map@[type=WATER;upgraded=false;extended=false]|]
    - else if <player.item_in_hand.material.name> == toughasnails_empty_canteen:
      - inventory set slot:<player.held_item_slot> o:toughasnails_water_canteen

cooking_free_slop:
  type: task
  debug: false
  script:
    - determine passively cancelled if:<player.item_in_hand.material.name.ends_with[spell_book].not||true>
    - ratelimit <player> 2s
    - if <player.item_in_hand.material.name> != air:
      - narrate "<&c>You need an empty hand for this."
      - stop
    - if !<player.inventory.contains_item[COIN_COPPER].quantity[6]>:
      - narrate "<&e>You don't seem to have enough cash."
      - stop
    - run start_timed_action "def:<&6>Taking Sewer Slop|10s|cooking_free_slop_callback" def.distance_from_origin:2 def.can_swap_items:false

cooking_free_slop_callback:
  type: task
  debug: false
  script:
    - if <player.item_in_hand.material.name> != air:
      - narrate "<&c>You need an empty hand for this."
      - stop
    - if !<player.inventory.contains_item[COIN_COPPER].quantity[6]>:
      - narrate "<&e>You don't seem to have enough cash."
      - stop
    - take item:COIN_COPPER quantity:6
    - inventory set slot:<player.held_item_slot> o:cooking_free_slop_item
    - narrate "<&e>You grab a bowl of the slop..."

cooking_free_slop_item:
  type: item
  debug: false
  material: suspicious_stew
  display name: <&6>Sewer Slop
  lore:
    - <&e>You're really gunna eat this?
  flags:
    on_consume: cooking_free_slop_eaten

cooking_free_slop_eaten:
  type: task
  debug: false
  script:
    - cast confusion hide_particles
    - adjust <player> thirst:20
    - adjust <player> food_level:20

cooking_free_slop_toggle:
  type: task
  debug: false
  script:
    - determine passively cancelled if:<player.item_in_hand.material.name.ends_with[spell_book].not||true>
    - ratelimit <player> 2s
    - if <player.location.x> > <context.location.x>:
      - narrate "<&c>Wrong side of the counter, Bucko."
      - stop
    - if <context.location.add[1,1,0].material.name> == fantasyfurniture_decorationsbowl_beetroot_soup:
      - modifyblock <context.location.add[1,1,0]> air
      - modifyblock <context.location.add[1,1,1]> air
      - narrate "<&e>Put the sewer slop away."
    - else:
      - modifyblock <context.location.add[1,1,0]> fantasyfurniture_decorationsbowl_beetroot_soup
      - modifyblock <context.location.add[1,1,1]> OAK_WALL_HANGING_SIGN[direction=east]
      - adjust <context.location.add[1,1,1]> "sign_contents:<&e>Good Slop|Cooks|are away|<&6>6 Copper"
      - adjust <context.location.add[1,1,1]> sign_glow_color:gray
      - adjust <context.location.add[1,1,1]> sign_glowing:true
      - narrate "<&e>Put the sewer slop out for the masses."