mining_stone_bundle:
  type: item
  material: paper
  display name: <&6>Bundle of Stone
  flags:
    right_click_script: unbundle_bundle
  mechanisms:
    custom_model_data: 2

mining_create_copper_nugget_bundle:
  type: item
  material: paper
  display name: <&6>Bundle of Copper Nugger
  flags:
    right_click_script: unbundle_bundle
  mechanisms:
    custom_model_data: 2

mining_iron_nugget_bundle:
  type: item
  material: paper
  display name: <&6>Bundle of Iron Nugget
  flags:
    right_click_script: unbundle_bundle
  mechanisms:
    custom_model_data: 2

mining_epicsamurai_silver_nugget_bundle:
  type: item
  material: paper
  display name: <&6>Bundle of Silver Nugget
  flags:
    right_click_script: unbundle_bundle
  mechanisms:
    custom_model_data: 2

mining_epicsamurai_steel_nugget_bundle:
  type: item
  material: paper
  display name: <&6>Bundle of Steel Nugget
  flags:
    right_click_script: unbundle_bundle
  mechanisms:
    custom_model_data: 2

mining_packaging_command:
  type: command
  name: mining_package
  debug: false
  description: Not for manual usage
  usage: DON'T
  script:
    - adjust <queue> linked_player:<server.match_player[<context.args.get[1]>]>
    - inventory close
    - run mining_packaging

mining_packaging:
  type: task
  debug: false
  data:
    stack_sizes:
      stone: <server.flag[google_data.mining.stone.bundle_size]>
      create_copper_nugget: <server.flag[google_data.mining.create_copper_nugget.bundle_size]>
      iron_nugget: <server.flag[google_data.mining.iron_nugget.bundle_size]>
      epicsamurai_silver_nugget: <server.flag[google_data.mining.epicsamurai_silver_nugget.bundle_size]>
      epicsamurai_steel_nugget: <server.flag[google_data.mining.epicsamurai_steel_nugget.bundle_size]>
  script:
    - define item <player.item_in_hand>
    - if <script[mining_packaging].data_key[data.stack_sizes.<[item].material.name>].exists>:
      - define quantity <script[mining_packaging].parsed_key[data.stack_sizes.<[item].material.name>]>
      - if <player.inventory.contains_item[<[item].material.name>].quantity[<[quantity]>]>:
        - take item:<[item].material.name> quantity:<[quantity]>
        - give item:mining_<[item].material.name>_bundle

mining_interact:
  type: task
  debug: false
  data:
    mineables:
      raw_iron_block:
        material_given: stone
        quantity_given: 2
        reputation_gained: 0.05
        reputation_needed: 0
      copper_ore:
        material_given: create_copper_nugget
        quantity_given: 3
        reputation_gained: 0.05
        reputation_needed: 100
      iron_ore:
        material_given: iron_nugget
        quantity_given: 3
        reputation_gained: 0.05
        reputation_needed: 200
      epicsamurai_silver_ore:
        material_given: epicsamurai_silver_nugget
        quantity_given: 1
        reputation_gained: 0.05
        reputation_needed: 300
      epicsamurai_steel_block:
        material_given: epicsamurai_steel_nugget
        quantity_given: 1
        reputation_gained: 0.05
        reputation_needed: 400
  script:
    - determine passively cancelled
    - stop if:<player.item_in_hand.material.name.advanced_matches[*_pickaxe].not>
    - if <player.flag[temp.job.name]||null> != mining:
      - narrate "<&c>You are not signed in for this job."
      - stop
    - if <script.data_key[data.mineables.<context.location.material.name>.reputation_needed]||0> > <player.flag[job.mining.reputation]>:
      - narrate "<&c>You cannot mine this yet."
      - stop
    - if <script.data_key[data.mineables.<context.location.material.name>.reputation_needed]||0> > <player.flag[job.mining.reputation]>:
      - narrate "<&c>You lack the reputation to harvest this."
      - stop
    - define seconds <script.data_key[data.mineables.<context.location.material.name>.quantity_given].mul[3]>
    - if <player.has_flag[temp.mining.<context.location.simple>.count]>:
      - define seconds:-:<player.flag[temp.mining.<context.location.simple>.count]>
    - flag <player> temp.timed_action.mining_location:<context.location>
    - if <util.delta_time_since_start.in_seconds.is_decimal>:
      - wait <element[20].sub[<duration[0.<util.delta_time_since_start.in_seconds.after[.]>s].in_ticks>]>t
    - run start_timed_action def:<&6>Mining|<[seconds]>s|mining_callback|<context.location> def.animation_task:mining_animation def.must_stare_at_block:true def.can_swap_items:false def.target:<context.location>

mining_animation:
  type: task
  debug: false
  script:
    - animate animation:ARM_SWING <player>
    - wait 7t
    - stop if:<player.has_flag[temp.timed_action].not>
    - flag player temp.mining.<player.flag[temp.timed_action.mining_location].simple>.count:++
    - playsound sound:BLOCK_NETHERITE_BLOCK_BREAK <player.flag[temp.timed_action.mining_location]> volume:0.5
    - blockcrack <player.flag[temp.timed_action.mining_location]> progress:<player.flag[temp.mining.<player.flag[temp.timed_action.mining_location].simple>.count]> players:<player> duration:10m
    - if <player.flag[temp.mining.<player.flag[temp.timed_action.mining_location].simple>.count].mod[3]> != 0:
      - stop
    - wait 2t
    - give item:<item[<script[mining_interact].data_key[data.mineables.<player.flag[temp.timed_action.mining_location].material.name>.material_given]>].with_flag[uuid:<util.random_uuid>]>
    - playsound sound:ENTITY_ITEM_PICKUP <player>

mining_callback:
  type: task
  debug: false
  definitions: block
  script:
    - run job_get_rep def:mining|<script[mining_interact].data_key[data.mineables.<[block].material.name>.reputation_gained]>
    - showfake <[block]> air duration:10m
    - wait 10m
    - flag player temp.mining.<[block].simple>:!
    - run narrate_empty_inventory_slots