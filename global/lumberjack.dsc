lumberjack_data:
  type: data
  debug: false
  data:
    choppables:
      oak_log:
        material_given: oak_planks
        quantity_given: 1
        seconds_needed: 5
        plank_cut_time: 8
        capability_needed: 0
      birch_log:
        material_given: birch_planks
        quantity_given: 1
        seconds_needed: 5
        plank_cut_time: 8
        capability_needed: 100
      spruce_log:
        material_given: spruce_planks
        quantity_given: 1
        seconds_needed: 5
        plank_cut_time: 8
        capability_needed: 200
      jungle_log:
        material_given: jungle_planks
        quantity_given: 1
        seconds_needed: 5
        plank_cut_time: 8
        capability_needed: 300
      acacia_log:
        material_given: acacia_planks
        quantity_given: 1
        seconds_needed: 5
        plank_cut_time: 8
        capability_needed: 400
      dark_oak_log:
        material_given: dark_oak_planks
        quantity_given: 1
        seconds_needed: 5
        plank_cut_time: 8
        capability_needed: 500

lumberjack_tree_cut:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - wait 1t
    - if <player.has_flag[timed_action]>:
      - stop
    - if <player.flag[temp.job.name]||null> != lumberjack:
      - narrate "<&c>You are not signed in for this job."
      - stop
    - if !<player.item_in_hand.material.name.advanced_matches[*_axe]>:
      - narrate "<&c>You need the right tool for this..."
      - stop
    - if <player.flag[character.capabilities.lumberjack]||0> < <script[lumberjack_data].data_key[data.choppables.<context.location.material.name.replace[wood].with[log]>.capability_needed]>:
      - narrate "<&c>You lack the capability to harvest this."
      - stop
    - if <player.item_in_hand.material.name.advanced_matches[*_axe]>:
      - run start_timed_action "def:<&6>Chopping <context.location.material.name.after[_].to_titlecase>|5s|lumberjack_chopping_tree_callback|<context.location>" def.distance_from_origin:2 def.can_swap_items:false def.must_stare_at_block:true def.target:<context.location> def.animation_task:lumberjack_chopping_tree_animate

lumberjack_chopping_tree_animate:
  type: task
  debug: false
  script:
    - animate <player> animation:ARM_SWING
    - wait 7t
    - playsound BLOCK_WOOD_BREAK <player.cursor_on>

lumberjack_chopping_tree_callback:
  type: task
  debug: false
  definitions: location
  script:
    - playsound sound:ENTITY_ITEM_PICKUP <player>
    - give item:<[location].material.name.replace[wood].with[log]>
    - run narrate_empty_inventory_slots

narrate_empty_inventory_slots:
  type: task
  debug: false
  script:
    - define empty <player.inventory.find_empty_slots.size>
    - if <player.item_in_offhand.material.name> == air:
      - define empty:--
    - define empty:-:<player.equipment.filter[material.name.equals[air]].size>
    - actionbar "<&6><[empty]> Inventory Spaces Left"

bundle_cancel:
  type: task
  debug: false
  script:
    - if <context.click> == RIGHT:
      - determine cancelled

lumberjack_chopping_block:
  type: entity
  entity_type: armor_stand
  mechanisms:
    gravity: false
    visible: false
  flags:
    right_click_script: lumberjack_chopping_block_interact
    on damaged: cancel

lumberjack_chopping_block_animate:
  type: task
  debug: false
  definitions: entity
  script:
    - animate <player> animation:ARM_SWING
    - wait 7t
    - animate <[entity]> ARMOR_STAND_HIT
    - playeffect at:<[entity].location.above[2]> effect:BLOCK_CRACK special_data:<[entity].equipment_map.get[helmet].material.name> quantity:4 offset:0.25,0.25,0.25

lumberjack_chopping_block_interact:
  type: task
  debug: false
  script:
    - ratelimit <player> 1t
    - if !<context.entity.equipment_map.is_empty>:
      - if <player.item_in_hand.material.name.advanced_matches[*_axe]>:
        - if !<script[lumberjack_data].data_key[data.choppables.<context.entity.equipment_map.get[helmet].material.name>].exists>:
          - narrate "<&c>You can not chop this."
          - stop
        - if <script[lumberjack_data].data_key[data.choppables.<context.entity.equipment_map.get[helmet].material.name>.capability_needed]> > <player.flag[character.capabilities.lumberjack]||0>:
          - narrate "<&c>You can not chop this wood yet."
          - stop
        - flag <player> temp.timed_action.chopping_block:<context.entity>
        - define time <script[lumberjack_data].data_key[data.choppables.<context.entity.equipment_map.get[helmet].material.name>.plank_cut_time]>
        - run start_timed_action "def:<&6>Chopping Log|<[time]>s|lumberjack_chopping_block_complete|<context.entity>" def.distance_from_origin:2 def.can_swap_items:false def.must_stare_at_target:true def.target:<context.entity> def.animation_task:lumberjack_chopping_block_animate
      - else if <player.item_in_hand.material.name> == air:
        - stop
      - else:
        - narrate "<&c>You require an axe to chop this."
    - else if <player.item_in_hand.material.name.advanced_matches[*_log]>:
      - define item <player.item_in_hand>
      - inventory set slot:<player.held_item_slot> o:air
      - wait 1t
      - equip <context.entity> head:<[item]>

lumberjack_chopping_block_complete:
  type: task
  debug: false
  definitions: block
  script:
    - stop if:<[block].equipment_map.is_empty>
    #- playeffect at:<[block].location.above[2]> effect:campfire_cosy_smoke quantity:6 offset:0.25,0.25,0.25 visibility:40
    - give <item[lumberjack_<[block].equipment_map.get[helmet].material.name.replace[log].with[planks]>]>
    - playsound sound:entity_item_pickup <player>
    - equip <[block]> head:air

lumberjack_packaging_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - ratelimit <player> 1t
    - if !<player.inventory.contains_item[empty_bundle]>:
      - narrate "<&c>You need an empty bundle for this."
      - stop
    - define item <player.item_in_hand>
    - if <script[lumberjack_packaging].data_key[data.stack_sizes.<[item].script.name>].exists>:
      - define quantity <script[lumberjack_packaging].parsed_key[data.stack_sizes.<[item].script.name>]>
      - if <player.inventory.contains_item[<[item].script.name>].quantity[<[quantity]>]>:
        - run start_timed_action "def:<&6>Packaging <[item].display>|4s|lumberjack_packaging" def.can_swap_items:false def.can_move:false
      - else:
        - narrate "<&c>You need atleast <[quantity]> <[item].display>"
    - else:
      - narrate "<&c>You don't have anything you can work with in your hands."

lumberjack_packaging_command:
  type: command
  name: lumberjack_package
  debug: false
  description: Not for manual usage
  usage: DON'T
  script:
    - adjust <queue> linked_player:<server.match_player[<context.args.get[1]>]>
    - inventory close
    - run lumberjack_packaging_interact

lumberjack_packaging:
  type: task
  debug: false
  data:
    stack_sizes:
      lumberjack_oak_planks: <server.flag[google_data.lumberjack.oak_planks.bundle_size]>
      lumberjack_birch_planks: <server.flag[google_data.lumberjack.birch_planks.bundle_size]>
      lumberjack_spruce_planks: <server.flag[google_data.lumberjack.spruce_planks.bundle_size]>
      lumberjack_jungle_planks: <server.flag[google_data.lumberjack.jungle_planks.bundle_size]>
      lumberjack_acacia_planks: <server.flag[google_data.lumberjack.acacia_planks.bundle_size]>
      lumberjack_dark_oak_planks: <server.flag[google_data.lumberjack.dark_oak_planks.bundle_size]>
      lumberjack_crimson_planks: <server.flag[google_data.lumberjack.crimson_planks.bundle_size]>
      lumberjack_warped_planks: <server.flag[google_data.lumberjack.warped_planks.bundle_size]>
  script:
    - if !<player.inventory.contains_item[empty_bundle]>:
      - narrate "<&c>You need an empty bundle for this."
      - stop
    - take item:empty_bundle quantity:1
    - define item <player.item_in_hand>
    - if <script[lumberjack_packaging].data_key[data.stack_sizes.<[item].script.name>].exists>:
      - define quantity <script[lumberjack_packaging].parsed_key[data.stack_sizes.<[item].script.name>]>
      - if <player.inventory.contains_item[<[item].script.name>].quantity[<[quantity]>]>:
        - take item:<[item].script.name> quantity:<[quantity]>
        - give item:<[item].script.name>_bundle