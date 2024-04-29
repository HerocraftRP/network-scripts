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
        reputation_gained: 0.1
        reputation_needed: 0
      birch_log:
        material_given: birch_planks
        quantity_given: 1
        seconds_needed: 5
        plank_cut_time: 8
        reputation_gained: 0.1
        reputation_needed: 100
      spruce_log:
        material_given: spruce_planks
        quantity_given: 1
        seconds_needed: 5
        plank_cut_time: 8
        reputation_gained: 0.1
        reputation_needed: 200
      jungle_log:
        material_given: jungle_planks
        quantity_given: 1
        seconds_needed: 5
        plank_cut_time: 8
        reputation_gained: 0.1
        reputation_needed: 300
      acacia_log:
        material_given: acacia_planks
        quantity_given: 1
        seconds_needed: 5
        plank_cut_time: 8
        reputation_gained: 0.1
        reputation_needed: 400
      dark_oak_log:
        material_given: dark_oak_planks
        quantity_given: 1
        seconds_needed: 5
        plank_cut_time: 8
        reputation_gained: 0.1
        reputation_needed: 500

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
    - if <player.flag[job.farming.reputation]||0> < <script[lumberjack_data].data_key[data.choppables.<context.location.material.name>.reputation_needed]>:
      - narrate "<&c>You lack the reputation to harvest this."
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
    - give item:<[location].material.name>
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

lumberjack_oak_planks_bundle:
  type: item
  debug: false
  material: paper
  display name: <&6>Bundle of Oak Planks
  flags:
    right_click_script: unbundle_bundle
  mechanisms:
    custom_model_data: 2

lumberjack_birch_planks_bundle:
  type: item
  debug: false
  material: paper
  display name: <&6>Bundle of Birch Planks
  flags:
    right_click_script: unbundle_bundle
  mechanisms:
    custom_model_data: 2

lumberjack_spruce_planks_bundle:
  type: item
  debug: false
  material: paper
  display name: <&6>Bundle of Spruce Planks
  flags:
    right_click_script: unbundle_bundle
  mechanisms:
    custom_model_data: 2

lumberjack_jungle_planks_bundle:
  type: item
  debug: false
  material: paper
  display name: <&6>Bundle of Jungle Planks
  flags:
    right_click_script: unbundle_bundle
  mechanisms:
    custom_model_data: 2

lumberjack_acacia_planks_bundle:
  type: item
  debug: false
  material: paper
  display name: <&6>Bundle of Acacia Planks
  flags:
    right_click_script: unbundle_bundle
  mechanisms:
    custom_model_data: 2

lumberjack_dark_oak_planks_bundle:
  type: item
  debug: false
  material: paper
  display name: <&6>Bundle of Dark Oak Planks
  flags:
    right_click_script: unbundle_bundle
  mechanisms:
    custom_model_data: 2

lumberjack_crimson_planks_bundle:
  type: item
  debug: false
  material: paper
  display name: <&6>Bundle of Crimson Planks
  flags:
    right_click_script: unbundle_bundle
  mechanisms:
    custom_model_data: 2

lumberjack_warped_planks_bundle:
  type: item
  debug: false
  material: paper
  display name: <&6>Bundle of Warped Planks
  flags:
    right_click_script: unbundle_bundle
  mechanisms:
    custom_model_data: 2

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
  script:
    - animate <player> animation:ARM_SWING
    - wait 7t
    - animate <player.flag[chopping_block]> ARMOR_STAND_HIT

lumberjack_chopping_block_interact:
  type: task
  debug: false
  script:
    - ratelimit <player> 1t
    - if !<context.entity.equipment_map.is_empty>:
      - if <player.item_in_hand.material.name.advanced_matches[*_axe]>:
        - if <script[lumberjack_data].data_key[data.choppables.<context.entity.equipment_map.get[helmet].material.name>.reputation_needed]> > <player.flag[job.lumberjack.reputation]>:
          - narrate "<&c>You can not chop this wood yet."
          - stop
        - flag <player> chopping_block:<context.entity>
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
    - give <[block].equipment_map.get[helmet].material.name.replace[log].with[planks]>
    - playsound sound:entity_item_pickup <player>
    - run job_get_rep def:lumberjack|<script[lumberjack_data].data_key[data.choppables.<[block].equipment_map.get[helmet].material.name>.reputation_gained]>
    - equip <[block]> head:air

lumberjack_packaging_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - ratelimit <player> 1t
    - define item <player.item_in_hand>
    - if <script[lumberjack_packaging].data_key[data.stack_sizes.<[item].material.name>].exists>:
      - define quantity <script[lumberjack_packaging].parsed_key[data.stack_sizes.<[item].material.name>]>
      - if <player.inventory.contains_item[<[item].material.name>].quantity[<[quantity]>]>:
        - run start_timed_action "def:<&6>Packaging <[item].material.name.replace[_].with[<&sp>].to_titlecase>|2s|lumberjack_packaging" def.can_swap_items:false def.can_move:false
      - else:
        - narrate "<&c>You need atleast <[quantity]> <[item].material.name.replace[_].with[<&sp>].to_titlecase>"
    - else:
      - narrate "<&c>You don't have anything I can work with in your hands."

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
      oak_planks: <server.flag[google_data.lumberjack.oak_planks.bundle_size]>
      birch_planks: <server.flag[google_data.lumberjack.birch_planks.bundle_size]>
      spruce_planks: <server.flag[google_data.lumberjack.spruce_planks.bundle_size]>
      jungle_planks: <server.flag[google_data.lumberjack.jungle_planks.bundle_size]>
      acacia_planks: <server.flag[google_data.lumberjack.acacia_planks.bundle_size]>
      dark_oak_planks: <server.flag[google_data.lumberjack.dark_oak_planks.bundle_size]>
      crimson_planks: <server.flag[google_data.lumberjack.crimson_planks.bundle_size]>
      warped_planks: <server.flag[google_data.lumberjack.warped_planks.bundle_size]>
  script:
    - define item <player.item_in_hand>
    - if <script[lumberjack_packaging].data_key[data.stack_sizes.<[item].material.name>].exists>:
      - define quantity <script[lumberjack_packaging].parsed_key[data.stack_sizes.<[item].material.name>]>
      - if <player.inventory.contains_item[<[item].material.name>].quantity[<[quantity]>]>:
        - take item:<[item].material.name> quantity:<[quantity]>
        - give item:lumberjack_<[item].material.name>_bundle