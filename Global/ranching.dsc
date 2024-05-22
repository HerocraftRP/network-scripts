ranch_interact:
  type: task
  debug: false
  data:
    ranchables:
      cow:
        tool: bucket
        tool_material_given: milk_bucket
        tool_quantity_given: 1
        tool_seconds_needed: 2
        tool_reputation_gained: 0.1
        tool_reputation_needed: 0
        material_given: beef
        quantity_given: 1
        seconds_needed: 2
        reputation_gained: 0.1
        reputation_needed: 200
      pig:
        tool: air
        tool_material_given: brown_mushroom
        tool_quantity_given: 1
        tool_seconds_needed: 2
        tool_reputation_gained: 0.1
        tool_reputation_needed: 0
        material_given: porkchop
        quantity_given: 1
        seconds_needed: 2
        reputation_gained: 0.1
        reputation_needed: 100
      chicken:
        tool: air
        tool_material_given: egg
        tool_quantity_given: 1
        tool_seconds_needed: 2
        tool_reputation_gained: 0.1
        tool_reputation_needed: 0
        material_given: chicken
        quantity_given: 1
        seconds_needed: 2
        reputation_gained: 0.1
        reputation_needed: 0
      sheep:
        tool: shears
        tool_material_given: wool
        tool_quantity_given: 1
        tool_seconds_needed: 2
        tool_reputation_gained: 0.1
        tool_reputation_needed: 0
        material_given: farmersdelight_mutton_chops
        quantity_given: 1
        seconds_needed: 2
        reputation_gained: 0.1
        reputation_needed: 400
    animal_drops:
      pig:
        - porkchop
      cow:
        - beef
        - leather
      chicken:
        - chicken
        - feather
      sheep:
        - farmersdelight_mutton_chops
    animal_harvest:
      pig: brown_mushroom
      cow: milk_bucket
      chicken: egg
      sheep: white_wool
    animal_harvest_tool:
      pig: air
      cow: bucket
      chicken: air
      sheep: shears
  script:
    - determine passively cancelled
    - wait 1t
    - inventory update
    - ratelimit <player> 1t
    - wait 1t
    - if <player.flag[temp.job.name]||null> != ranching:
      - narrate "<&c>You are not signed in for this job."
      - stop
    - if <player.flag[job.ranching.reputation]||0> < <script[ranch_interact].data_key[data.ranchables.<context.entity.entity_type>.reputation_needed]>:
      - narrate "<&c>You lack the reputation to harvest this."
      - stop
    - if <player.item_in_hand.material.name> == <script.data_key[data.ranchables.<context.entity.entity_type>.tool]>:
      - if <script.data_key[data.animal_harvest].exists>:
        - if <player.has_flag[temp.last_harvested.<context.entity.uuid>]> && <player.flag[temp.last_harvested.<context.entity.uuid>].from_now.is_less_than[2m]>:
          - narrate "<&c>Animal has no produce."
          - stop
        - run start_timed_action "def:<&6>Harvesting from <context.entity.entity_type.replace[_].with[<&sp>].to_titlecase>|6s|harvest_callback|<context.entity>" def.distance_from_origin:2 def.can_swap_items:false def.target:<context.entity> def.animation_task:ranching_animation
      - stop
    - if !<player.item_in_hand.script.name.advanced_matches[*_butchering_knife]||false>:
      - stop
    - adjust <context.entity> has_ai:false
    - run start_timed_action "def:<&6>Butchering <context.entity.entity_type.replace[_].with[<&sp>].to_titlecase>|6s|ranch_callback|<context.entity>" def.distance_from_origin:2 def.can_swap_items:false def.target:<context.entity> def.animation_task:ranching_animation
    - wait 20t
    - if <player.has_flag[timed_action]>:
      - adjust <player> fake_entity_health:[entity=<context.entity>;health=0]
    - if <player.has_flag[timed_action]>:
      - adjust <player> show_entity:<context.entity>
    - wait 15s
    - adjust <player> show_entity:<context.entity>

ranch_butchering_knife:
  type: item
  debug: false
  display name: <&r>Flint Butchering Knife
  material: farmersdelight_flint_knife

ranching_animation:
  type: task
  debug: false
  script:
    - animate animation:ARM_SWING <player>

harvest_callback:
  type: task
  debug: false
  definitions: mob
  script:
    - wait 10t
    - if <script[ranch_interact].data_key[data.ranchables.<[mob].entity_type>.tool_material_given]> == milk_bucket:
      - inventory set slot:<player.held_item_slot> o:milk_bucket d:<player.inventory>
    - else:
      - give item:<item[<script[ranch_interact].data_key[data.animal_harvest.<[mob].entity_type>]>].with_flag[uuid=<util.random_uuid>]>
    - run job_get_rep def:ranching|<script[ranching_data].data_key[data.ranchables.<[mob].entity_type>.reputation_gained]>
    - playsound sound:ENTITY_ITEM_PICKUP <player>
    - adjust <[mob]> has_ai:true
    - flag <player> temp.last_harvested.<[mob].uuid>:<util.time_now>
    - run narrate_empty_inventory_slots

ranch_callback:
  type: task
  debug: false
  definitions: mob
  script:
    - wait 10t
    - foreach <script[ranch_interact].data_key[data.ranchables.<[mob].entity_type>.material_given]>:
      - give item:<item[<[value]>].with_flag[uuid=<util.random_uuid>]>
    - playsound sound:ENTITY_ITEM_PICKUP <player>
    - run job_get_rep def:ranching|<script[ranch_interact].data_key[data.ranchables.<[mob].entity_type>.reputation_gained]>
    - adjust <[mob]> has_ai:true
    - adjust <player> hide_entity:<[mob]>
    - run narrate_empty_inventory_slots

ranch_no_chicken_eggs:
  type: world
  debug: false
  events:
    on chicken spawns because EGG:
      - determine cancelled