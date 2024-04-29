tailoring_data:
  type: data
  debug: false
  data:
    craftables:
      default:
        items:
          sewingkit_leather_strip:
            material_cost:
              leather: 5
            rep_needed: 0
            rep_gained: 0.1
          sewingkit_leather_sheet:
            material_cost:
              leather: 10
            rep_needed: 1
            rep_gained: 0.1
          magistuarmory_woolen_fabric:
            material_cost:
              white_wool: 5
            rep_needed: 2
            rep_gained: 0.1
          sewingkit_wool_shoes:
            material_cost:
              oak_planks: 5
            rep_needed: 5
            rep_gained: 0.1
          sewingkit_wool_pants:
            material_cost:
              oak_planks: 5
            rep_needed: 10
            rep_gained: 0.1
          sewingkit_wool_shirt:
            material_cost:
              oak_planks: 5
            rep_needed: 15
            rep_gained: 0.1
          sewingkit_wool_hat:
            material_cost:
              oak_planks: 5
            rep_needed: 20
            rep_gained: 0.1
          leather_boots:
            material_cost:
              oak_planks: 5
            rep_needed: 25
            rep_gained: 0.1
          leather_leggings:
            material_cost:
              oak_planks: 5
            rep_needed: 30
            rep_gained: 0.1
          leather_chestplate:
            material_cost:
              oak_planks: 5
            rep_needed: 35
            rep_gained: 0.1
          leather_helmet:
            material_cost:
              oak_planks: 5
            rep_needed: 40
            rep_gained: 0.1
          comforts_sleeping_bag_white:
            material_cost:
              oak_planks: 5
            rep_needed: 45
            rep_gained: 0.1
          comforts_sleeping_bag_orange:
            material_cost:
              oak_planks: 5
            rep_needed: 50
            rep_gained: 0.1
          comforts_sleeping_bag_magenta:
            material_cost:
              oak_planks: 5
            rep_needed: 55
            rep_gained: 0.1
          comforts_sleeping_bag_light_blue:
            material_cost:
              oak_planks: 5
            rep_needed: 60
            rep_gained: 0.1
          comforts_sleeping_bag_yellow:
            material_cost:
              oak_planks: 5
            rep_needed: 65
            rep_gained: 0.1
          comforts_sleeping_bag_lime:
            material_cost:
              oak_planks: 5
            rep_needed: 70
            rep_gained: 0.1
          comforts_sleeping_bag_pink:
            material_cost:
              oak_planks: 5
            rep_needed: 75
            rep_gained: 0.1
          comforts_sleeping_bag_gray:
            material_cost:
              oak_planks: 5
            rep_needed: 80
            rep_gained: 0.1
          comforts_sleeping_bag_light_gray:
            material_cost:
              oak_planks: 5
            rep_needed: 85
            rep_gained: 0.1
          comforts_sleeping_bag_cyan:
            material_cost:
              oak_planks: 5
            rep_needed: 90
            rep_gained: 0.1
          comforts_sleeping_bag_purple:
            material_cost:
              oak_planks: 5
            rep_needed: 95
            rep_gained: 0.1
          comforts_sleeping_bag_blue:
            material_cost:
              oak_planks: 5
            rep_needed: 100
            rep_gained: 0.1
          comforts_sleeping_bag_brown:
            material_cost:
              oak_planks: 5
            rep_needed: 105
            rep_gained: 0.1
          comforts_sleeping_bag_green:
            material_cost:
              oak_planks: 5
            rep_needed: 110
            rep_gained: 0.1
          comforts_sleeping_bag_red:
            material_cost:
              oak_planks: 5
            rep_needed: 115
            rep_gained: 0.1
          comforts_sleeping_bag_black:
            material_cost:
              oak_planks: 5
            rep_needed: 120
            rep_gained: 0.1
          days_in_the_middle_ages_leather_coinpouch:
            material_cost:
              oak_planks: 5
            rep_needed: 125
            rep_gained: 0.1
          sophisticatedbackpacks_backpack:
            material_cost:
              oak_planks: 5
            rep_needed: 130
            rep_gained: 0.1


tailoring_job_inventory:
  type: inventory
  debug: false
  inventory: chest
  title: <&7>tailoring
  size: 54

tailoring_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - wait 1t
    - inventory close
    - define location <context.item.flag[saw]>
    - define craftCost <context.item.flag[craftCost]>
    - foreach <[craftCost]> key:needed_item as:quantity:
      - if !<player.inventory.contains_item[<[needed_item]>].quantity[<[quantity]>]>:
        - narrate "<&e>You need more <[needed_item].replace[_].with[<&sp>].to_titlecase>"
        - stop
    - foreach <[craftCost]> key:needed_item as:quantity:
      - take item:<[needed_item]> quantity:<[quantity]>
    - flag <player> temp.timed_action.cost:<[craftCost]>
    - flag <player> temp.timed_action.tailor_result:<context.item.material.name>
    - run start_timed_action "def:<&6>Sewing <context.item.material.name.after[_].replace[_].with[<&sp>].to_titlecase>|4.5s|tailoring_callback|<context.item.flag[saw]>" def.animation_task:woodwork_animation def.can_swap_items:false def.cancel_script:tailoring_cancel def.distance_from_origin:2
    - spawn ARMOR_STAND[visible=false;arms=true;gravity=false;marker=true] <[location].below.center.above.with_yaw[270].left[0.5]> save:faked1
    - flag <player> temp.timed_action.armor_stand:<entry[faked1].spawned_entity>
    - equip <entry[faked1].spawned_entity> hand:<player.item_in_hand>
    - define as <entry[faked1].spawned_entity>
    - define default_pose <[as].armor_pose_map.get[right_arm]>
    - repeat 3 as:big_loop:
      - adjust <[as]> armor_pose:[right_arm=<[default_pose]>]
      - repeat 30:
        - repeat stop if:<[as].is_spawned.not>
        - define pose <element[1].add[<[value].mul[-0.05]>]>
        - adjust <[as]> armor_pose:[right_arm=<[pose]>,0,0]
        #- playsound sound:create:saw_activate_wood <player.location> volume:0.5 custom
        - wait 1t
    - remove <[as]> if:<[as].is_spawned>

tailoring_animation:
  type: task
  debug: false
  script:
    - animate <player> animation:ARM_SWING

tailoring_cancel:
  type: task
  debug: false
  script:
    - remove <player.flag[temp.timed_action.armor_stand]>
    - foreach <player.flag[temp.timed_action.cost]> key:needed_item as:quantity:
      - give item:<[needed_item]> quantity:<[quantity]>

tailoring_callback:
  type: task
  debug: false
  script:
    - give item:<player.flag[temp.timed_action.tailor_result]>
    - playsound sound:ENTITY_ITEM_PICKUP <player>
    - run job_get_rep def:tailor|<script[tailoring_data].data_key[data.craftables.default.items.<player.flag[temp.timed_action.tailor_result]>.rep_gained]>


tailoring_inventory_open:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - wait 1t
    - if <player.flag[temp.job.name]||null> != tailor:
      - narrate "<&c>You are not signed in for this job."
      - stop
    - stop if:<player.has_flag[timed_action]>
    - stop if:<player.item_in_hand.material.name.advanced_matches[*_needle].not>
    - define inv <inventory[tailoring_job_inventory]>
    - foreach <server.flag[job_data.reputation_tables.tailoring.default]> key:repNeeded as:item:
      - if <player.flag[job.tailoring.reputation]||0> < <[repNeeded]>:
        - foreach stop
      - define craftCost <script[tailoring_data].data_key[data.craftables.default.items.<[item]>.material_cost]>
      - define lore <list[<&e>------------|<&e>Crafting Cost:]>
      - foreach <[craftCost]> key:material as:quantity:
        - define lore "<[lore].include[<&e><[quantity]> <[material].replace[_].with[<&sp>].to_titlecase>]>"
      - define lore <[lore].include[<&e>------------]>
      - define item <item[<[item]>].with[lore=<[lore]>]>
      - flag <[item]> run_script:tailoring_interact
      - flag <[item]> saw:<context.location>
      - flag <[item]> craftCost:<[craftCost]>
      - inventory set slot:<[loop_index]> o:<[item]> d:<[inv]>
    - inventory open d:<[inv]>