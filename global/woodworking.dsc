woodwork_data:
  type: data
  debug: false
  data:
    craftables:
      oak_planks:
        items:
          oak_slab:
            material_cost:
              oak_planks: 5
            rep_needed: 0
            rep_gained: 0.1
            needs_downshift: false
          oak_stairs:
            material_cost:
              oak_planks: 5
            rep_needed: 5
            rep_gained: 0.1
            needs_downshift: false
          stripped_oak_log:
            material_cost:
              oak_planks: 10
            rep_needed: 10
            rep_gained: 0.1
            needs_downshift: false
          wooden_tool_handle:
            material_cost:
              oak_planks: 15
            rep_needed: 0
            rep_gained: 0.1
            needs_downshift: false
          oak_fence:
            material_cost:
              oak_planks: 20
            rep_needed: 0
            rep_gained: 0.1
            needs_downshift: false
          oak_fence_gate:
            material_cost:
              oak_planks: 25
            rep_needed: 0
            rep_gained: 0.1
            needs_downshift: false
          oak_door:
            material_cost:
              oak_planks: 25
            rep_needed: 0
            rep_gained: 0.1
            needs_downshift: false
          oak_trapdoor:
            material_cost:
              oak_planks: 30
            rep_needed: 0
            rep_gained: 0.1
            needs_downshift: false
          oak_pressure_plate:
            material_cost:
              oak_planks: 35
            rep_needed: 0
            rep_gained: 0.1
            needs_downshift: false
          oak_button:
            material_cost:
              oak_planks: 40
            rep_needed: 0
            rep_gained: 0.1
            needs_downshift: false
          oak_sign:
            material_cost:
              oak_planks: 45
            rep_needed: 0
            rep_gained: 0.1
            needs_downshift: false
          oak_hanging_sign:
            material_cost:
              oak_planks: 50
            rep_needed: 0
            rep_gained: 0.1
            needs_downshift: false
          farmersdelight_oak_cabinet:
            material_cost:
              oak_planks: 55
            rep_needed: 0
            rep_gained: 0.1
            needs_downshift: false
          create_oak_window:
            material_cost:
              oak_planks: 60
            rep_needed: 0
            rep_gained: 0.1
            needs_downshift: false
          aquaculture_oak_fish_mount:
            material_cost:
              oak_planks: 65
            rep_needed: 0
            rep_gained: 0.1
            needs_downshift: false

woodwork_job_inventory:
  type: inventory
  debug: false
  inventory: chest
  title: <&7>woodwork
  size: 54
  data:
    any_click: cancel


woodwork_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - inventory close
    - wait 1t
    - stop if:<player.item_in_hand.material.name.advanced_matches[*_planks].not>
    - define craftCost <context.item.flag[craftCost]>
    - foreach <[craftCost]> key:needed_item as:quantity:
      - if !<player.inventory.contains_item[<[needed_item]>].quantity[<[quantity]>]>:
        - narrate "<&e>You need more <[needed_item].replace[_].with[<&sp>].to_titlecase>"
        - stop
    - foreach <[craftCost]> key:needed_item as:quantity:
      - take item:<[needed_item]> quantity:<[quantity]>
    - define woodwork_result <context.item.script.name||<context.item.material.name>>
    - flag <player> temp.timed_action.material:<context.item.flag[material]>
    - flag <player> temp.timed_action.cost:<context.item.flag[craftCost]>
    - flag <player> temp.timed_action.woodwork_location:<context.item.flag[saw]>
    - flag <player> temp.timed_action.woodwork_result:<[woodwork_result]>
    - spawn ARMOR_STAND[visible=false;equipment=<list[air|air|air|<context.item.flag[material]>]>;gravity=false;marker=true] <player.cursor_on.center.below[1.25].with_yaw[90].backward_flat[.75]> save:faked1
    - flag <player> temp.woodwork.armor_stand:<entry[faked1].spawned_entity>
    - run start_timed_action "def:<&6>Sawing <[woodwork_result].after[_].replace[_].with[<&sp>].to_titlecase>|4.5s|woodwork_callback|<context.item.flag[saw]>" def.animation_task:woodwork_animation def.can_swap_items:false def.cancel_script:woodwork_cancel
    - define as <entry[faked1].spawned_entity>
    - repeat 30:
      - stop if:<player.has_flag[temp.timed_action].not>
      - teleport <[as]> <[as].location.forward[0.05]>
      - playsound sound:create:saw_activate_wood <player.location> volume:0.5 custom
      - if <[value]> == 20:
        - playsound sound:create:confirm <player.location> volume:0.5 custom
        - playeffect effect:redstone special_data:1.75|white at:<[as].location.above[1.75]> quantity:20 offset:0.25,0.25,0.25
        - if <script[woodwork_data].data_key[data.craftables.<context.item.flag[material]>.items.<[woodwork_result]>.needs_downshift]>:
          - spawn ARMOR_STAND[visible=false;equipment=<list[air|air|air|<[woodwork_result]>]>;gravity=false;marker=true] <entry[faked1].spawned_entity.location.below[0.5]> save:faked2
          - define as <entry[faked2].spawned_entity>
          - remove <entry[faked1].spawned_entity>
          - flag <player> temp.woodwork.armor_stand:<entry[faked2].spawned_entity>
        - else:
          - adjust <[as]> equipment:air|air|air|<[woodwork_result]>
      - wait 3t
    - remove <[as]>

woodwork_animation:
  type: task
  debug: false
  script:
    - animate <player> animation:ARM_SWING

woodwork_cancel:
  type: task
  debug: false
  script:
    - remove <player.flag[temp.woodwork.armor_stand]>
    - foreach <player.flag[temp.timed_action.cost]> key:needed_item as:quantity:
      - give item:<[needed_item]> quantity:<[quantity]>

woodwork_callback:
  type: task
  debug: false
  script:
    - give item:<player.flag[temp.timed_action.woodwork_result]>
    - playsound sound:ENTITY_ITEM_PICKUP <player>

woodwork_test:
  type: task
  debug: false
  script:
    - spawn ARMOR_STAND[visible=false;equipment=<list[air|air|air|oak_planks]>;gravity=false;marker=true] <player.cursor_on.center.below[1.25].with_yaw[90].backward_flat[.75]> save:faked1
    - define as <entry[faked1].spawned_entity>
    - repeat 30:
      - teleport <[as]> <[as].location.forward[0.05]>
      - playsound sound:create:saw_activate_wood <player.location> volume:0.5 custom
      - if <[value]> == 20:
        - playsound sound:create:confirm <player.location> volume:0.5 custom
        - playeffect effect:redstone special_data:1.75|white at:<[as].location.above[1.75]> quantity:20 offset:0.25,0.25,0.25
        - spawn ARMOR_STAND[visible=false;equipment=<list[air|air|air|fantasyfurniture_nordicchair]>;gravity=false;marker=true] <entry[faked1].spawned_entity.location.below[0.5]> save:faked2
        - define as <entry[faked2].spawned_entity>
        - remove <entry[faked1].spawned_entity>
      - wait 3t
    - remove <[as]>

woodwork_inventory_open:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - wait 1t
    - stop if:<player.has_flag[timed_action]>
    - stop if:<player.item_in_hand.material.name.advanced_matches[*_planks].not>
    - if <player.flag[temp.job.name]||null> != woodwork:
      - narrate "<&c>You are not signed in for this job."
      - stop
    - define inv <inventory[woodwork_job_inventory]>
    - define material <player.item_in_hand.material.name>
    - foreach <server.flag[job_data.reputation_tables.woodwork.<[material]>]> key:repNeeded as:item:
      - if <player.flag[character.capabilities.woodwork]||0> >= <[repNeeded]>:
        - define craftCost <script[woodwork_data].data_key[data.craftables.<[material]>.items.<[item]>.material_cost]>
        - define lore <list[<&e>------------|<&e>Crafting Cost:]>
        - foreach <[craftCost]> key:material as:quantity:
          - define lore "<[lore].include[<&e><[quantity]> <[material].replace[_].with[<&sp>].to_titlecase>]>"
        - define lore <[lore].include[<&e>------------]>
        - define item <item[<[item]>].with[lore=<[lore]>]>
        - flag <[item]> run_script:woodwork_interact
        - flag <[item]> saw:<context.location>
        - flag <[item]> craftCost:<[craftCost]>
        - flag <[item]> material:<[material]>
        - inventory set slot:<[loop_index]> o:<[item]> d:<[inv]>
      - else:
        - foreach stop
    - inventory open d:<[inv]>