manual_item_pickup:
  type: world
  debug: false
  events:
    on player picks up item:
      - determine cancelled
    on player right clicks block ignorecancelled:true:
      - ratelimit <player> 5t
      - stop if:<player.is_sneaking.not>
      - define item <player.eye_location.ray_trace[range=3;return=precise].find_entities[DROPPED_ITEM].within[1].first||null>
      - stop if:<[item].equals[null]>
      - stop if:<[item].has_flag[picked_up]>
      - stop if:<[item].item.exists.not>
      - flag <[item]> picked_up
      - give <[item].item>
      - adjust <player> fake_pickup:<[item]>
      - playsound sound:ENTITY_ITEM_PICKUP volume:4 <player.location>
      - run narrate_empty_inventory_slots
      - wait 5t
      - remove <[item]>