farming_interact:
  type: task
  debug: false
  data:
    farmables:
      WHEAT:
        material_given: FARMING_wheat
        quantity_given: 1
        seconds_needed: 2
        reputation_gained: 0.1
        reputation_needed: 0
      FARMERSDELIGHT_CABBAGES:
        material_given: FARMING_FARMERSDELIGHT_CABBAGE
        quantity_given: 3
        seconds_needed: 10
        reputation_gained: 0.1
        reputation_needed: 100
      CARROTS:
        material_given: FARMING_carrot
        quantity_given: 3
        seconds_needed: 10
        reputation_gained: 0.1
        reputation_needed: 200
      FARMERSDELIGHT_ONIONS:
        material_given: FARMING_FARMERSDELIGHT_ONION
        quantity_given: 3
        seconds_needed: 10
        reputation_gained: 0.1
        reputation_needed: 300
      FARMERSDELIGHT_TOMATOES:
        material_given: FARMING_FARMERSDELIGHT_TOMATO
        quantity_given: 3
        seconds_needed: 10
        reputation_gained: 0.1
        reputation_needed: 400
  script:
    - determine passively cancelled
    - ratelimit <player> 2t
    - if <player.location.distance[<context.location>]> > 2.5:
      - narrate "<&c>Get closer to harvest"
      - stop
    - wait 1t
    - if <player.has_flag[timed_action]>:
      - stop
    #- if <player.fake_block[<context.location>].name> == air:
      #- stop
    - if <player.flag[temp.job.name]||null> != farming:
      - narrate "<&c>You are not signed in for this job."
      - stop
    - if !<player.item_in_hand.material.name.advanced_matches[*_hoe]>:
      - narrate "<&c>You need the right tool for this..."
      - stop
    - if <player.flag[job.farming.reputation]||0> < <script[farming_interact].data_key[data.farmables.<context.location.material.name>.reputation_needed]>:
      - narrate "<&c>You lack the reputation to harvest this."
      - stop
    - define seconds <script[farming_interact].data_key[data.farmables.<context.location.material.name>.seconds_needed]>
    - flag <player> temp.timed_action.target:<context.location>
    - run start_timed_action "def:<&6>Harvesting <context.location.material.name.after[_].to_titlecase>|<[seconds]>s|farming_callback|<context.location>" def.can_move:false def.can_swap_items:false def.animation_task:farming_animation

farming_animation:
  type: task
  debug: false
  script:
    - animate <player> animation:ARM_SWING
    - wait 7t
    - playsound sound:BLOCK_CROP_BREAK <player.location>

farming_callback:
  type: task
  debug: false
  definitions: location
  script:
    - if !<player.has_flag[temp.timed_action.target]> || <[location]> != <player.flag[temp.timed_action.target]>:
      - stop
    - showfake air <[location]> duration:2m
    - give item:<item[<script[farming_interact].data_key[data.farmables.<[location].material.name>.material_given]>].with_flag[uuid=<util.random_uuid>]> quantity:1
    - playsound sound:entity_item_pickup <player>
    - run job_get_rep def:farming|<script[farming_interact].data_key[data.farmables.<[location].material.name>.reputation_gained]>
    - run narrate_empty_inventory_slots

farming_packaging_interact:
  type: task
  debug: true
  script:
    - determine passively cancelled
    - ratelimit <player> 1t
    - if !<player.inventory.contains_item[empty_bundle]>:
      - narrate "<&c>You need an empty bundle for this."
      - stop
    - define item <player.item_in_hand>
    - if <script[farming_packaging].data_key[data.stack_sizes.<[item].script.name>].exists>:
      - define quantity <script[farming_packaging].parsed_key[data.stack_sizes.<[item].script.name>]>
      - if <player.inventory.contains_item[<[item].script.name>].quantity[<[quantity]>]>:
        - run start_timed_action "def:<&6>Packaging <[item].display>|4s|farming_packaging" def.can_swap_items:false def.can_move:false
      - else:
        - narrate "<&c>You need atleast <[quantity]> <[item].display>"
    - else:
      - narrate "<&c>You don't have anything I can work with."

farming_packaging_command:
  type: command
  name: farming_package
  debug: false
  description: Not for manual usage
  permissions: not.a.perm
  usage: DON'T
  script:
    - adjust <queue> linked_player:<server.match_player[<context.args.get[1]>]>
    - inventory close
    - run farming_packaging_interact

farming_packaging:
  type: task
  debug: false
  data:
    stack_sizes:
      farming_wheat: <server.flag[google_data.farming.wheat.bundle_size]>
      farming_farmersdelight_rice: <server.flag[google_data.farming.farmersdelight_rice.bundle_size]>
      farming_carrot: <server.flag[google_data.farming.carrot.bundle_size]>
      farming_farmersdelight_onion: <server.flag[google_data.farming.farmersdelight_onion.bundle_size]>
      farming_farmersdelight_cabbage: <server.flag[google_data.farming.farmersdelight_cabbage.bundle_size]>
      farming_farmersdelight_tomato: <server.flag[google_data.farming.farmersdelight_tomato.bundle_size]>
  script:
    - if !<player.inventory.contains_item[empty_bundle]>:
      - narrate "<&c>You need an empty bundle for this."
      - stop
    - take item:empty_bundle quantity:1
    - define item <player.item_in_hand>
    - if <script[farming_packaging].data_key[data.stack_sizes.<[item].script.name>].exists>:
      - define quantity <script[farming_packaging].parsed_key[data.stack_sizes.<[item].script.name>]>
      - if <player.inventory.contains_item[<[item].script.name>].quantity[<[quantity]>]>:
        - take item:<[item].script.name> quantity:<[quantity]>
        - give item:<[item].script.name>_bundle