blacksmith_data:
  type: data
  debug: false
  data:
    craftables:
      stone:
        items:
          magistuarmory_stone_stylet:
            material_cost:
              stone: 3
              wooden_tool_handle: 2
            rep_needed: 0
            rep_gained: 0.1
          magistuarmory_stone_shortsword:
            material_cost:
              stone: 6
              wooden_tool_handle: 2
            rep_needed: 5
            rep_gained: 0.1
          magistuarmory_stone_katzbalger:
            material_cost:
              stone: 10
              wooden_tool_handle: 2
            rep_needed: 10
            rep_gained: 0.1
          magistuarmory_stone_pike:
            material_cost:
              stone: 10
              wooden_tool_handle: 2
            rep_needed: 20
            rep_gained: 0.1
          magistuarmory_stone_ahlspiess:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 25
            rep_gained: 0.1
          magistuarmory_stone_estoc:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 30
            rep_gained: 0.1
          magistuarmory_stone_bastardsword:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 35
            rep_gained: 0.1
          magistuarmory_stone_claymore:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 40
            rep_gained: 0.1
          magistuarmory_stone_zweihander:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 45
            rep_gained: 0.1
          magistuarmory_stone_flamebladedsword:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 50
            rep_gained: 0.1
          magistuarmory_stone_lochaberaxe:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 55
            rep_gained: 0.1
          magistuarmory_stone_concavehalberd:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 60
            rep_gained: 0.1
          magistuarmory_stone_heavymace:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 65
            rep_gained: 0.1
          magistuarmory_stone_heavywarhammer:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 70
            rep_gained: 0.1
          magistuarmory_stone_lucernhammer:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 75
            rep_gained: 0.1
          magistuarmory_stone_morgenstern:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 80
            rep_gained: 0.1
          magistuarmory_stone_guisarme:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 85
            rep_gained: 0.1
          aquaculture_stone_fillet_knife:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 90
            rep_gained: 0.1
          magistuarmory_stone_heatershield:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 95
            rep_gained: 0.1
          magistuarmory_stone_target:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 100
            rep_gained: 0.1
          magistuarmory_stone_buckler:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 105
            rep_gained: 0.1
          magistuarmory_stone_rondache:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 110
            rep_gained: 0.1
          magistuarmory_stone_tartsche:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 115
            rep_gained: 0.1
          magistuarmory_stone_ellipticalshield:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 120
            rep_gained: 0.1
          magistuarmory_stone_roundshield:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 125
            rep_gained: 0.1
          magistuarmory_stone_pavese:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 130
            rep_gained: 0.1
          magistuarmory_stone_kiteshield:
            material_cost:
              stone: 15
              wooden_tool_handle: 2
            rep_needed: 135
            rep_gained: 0.1



blacksmith_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - inventory close
    - wait 1t
    - stop if:<player.item_in_hand.material.name.advanced_matches[magistuarmory_blacksmith_hammer].not>
    - define craftCost <context.item.flag[craftCost]>
    - foreach <[craftCost]> key:needed_item as:quantity:
      - if !<player.inventory.contains_item[<[needed_item]>].quantity[<[quantity]>]>:
        - narrate "<&e>You need more <[needed_item].replace[_].with[<&sp>].to_titlecase>"
        - stop
    - foreach <[craftCost]> key:needed_item as:quantity:
      - take item:<[needed_item]> quantity:<[quantity]>
    - flag <player> temp.timed_action.smithing_location:<context.item.flag[anvil]>
    - flag <player> temp.timed_action.cost:<context.item.flag[craftCost]>
    - flag <player> temp.timed_action.smithing_result:<context.item.material.name>
    - flag <player> temp.timed_action.material:<context.item.flag[material]>
    - run start_timed_action "def:<&6>Smithing <context.item.material.name.after[_].replace[_].with[<&sp>].to_titlecase>|10s|blacksmith_callback|<context.item.flag[anvil]>" def.animation_task:blacksmithing_animation def.can_swap_items:false def.must_stare_at_block:true def.target:<context.item.flag[anvil]> def.cancel_script:blacksmith_cancelled
    #- fakespawn ARMOR_STAND[equipment=<list[air|air|air|<context.item.material.name>]>;marker=true;armor_pose=<map.with[head].as[4.71,0,0]>] <context.item.flag[temp.blacksmith.anvil].center.below[1].forward_flat[0.25]> duration:10s

blacksmith_cancelled:
  type: task
  debug: false
  script:
    - foreach <player.flag[temp.timed_action.cost]> key:needed_item as:quantity:
      - give item:<[needed_item]> quantity:<[quantity]>

blacksmithing_animation:
  type: task
  debug: false
  script:
    - animate animation:ARM_SWING <player>
    - wait 7t
    - playsound sound:BLOCK_ANVIL_LAND <player.flag[temp.timed_action.smithing_location]> volume:0.25

blacksmith_job_inventory:
  type: inventory
  debug: false
  inventory: chest
  title: <&7>Blacksmithing
  size: 54
  data:
    any_click: cancel

blacksmith_callback:
  type: task
  debug: false
  script:
    - define data <script[blacksmith_data].data_key[data.craftables.<player.flag[temp.timed_action.material]>.items.<player.flag[temp.timed_action.smithing_result]>]>
    - define result_item <item[<player.flag[temp.timed_action.smithing_result]>]>
    - define durability_percentage <player.flag[job.blacksmith.reputation].if_null[0].div[<[data].get[rep_needed].add[100]>]>
    - define durability <[result_item].max_durability.sub[<[durability_percentage].mul[<[result_item].max_durability>]>]>
    - give item:<[result_item].with[durability=<[durability].round_down>]>
    - playsound sound:ENTITY_ITEM_PICKUP <player>
    - run job_get_rep def:woodwork|<[data].get[rep_gained]>

blacksmith_inventory_open:
  type: task
  debug: true
  script:
    - determine passively cancelled
    - wait 1t
    - stop if:<player.has_flag[temp.timed_action]>
    - if <player.flag[temp.job.name]||null> != blacksmith:
      - narrate "<&c>You are not signed in for this job."
      - stop
    - stop if:<player.item_in_hand.material.name.equals[magistuarmory_blacksmith_hammer].not>
    - define inv <inventory[blacksmith_job_inventory]>
    - define material stone
    - foreach <server.flag[job_data.reputation_tables.blacksmith.<[material]>]> key:repNeeded as:item:
      - if <player.flag[job.blacksmith.reputation]||0> < <[repNeeded]>:
        - foreach stop
      - else:
        - define craftCost <script[blacksmith_data].data_key[data.craftables.<[material]>.items.<[item]>.material_cost]>
        - define lore <list[<&e>------------|<&e>Crafting Cost:]>
        - foreach <[craftCost]> key:material as:quantity:
          - define lore "<[lore].include[<&e><[quantity]> <[material].replace[_].with[<&sp>].to_titlecase>]>"
        - define lore <[lore].include[<&e>------------]>
        - define item <item[<[item]>].with[lore=<[lore]>]>
        - flag <[item]> run_script:blacksmith_interact
        - flag <[item]> anvil:<context.location>
        - flag <[item]> material:<[material]>
        - flag <[item]> craftCost:<[craftCost]>
        - inventory set slot:<[loop_index]> o:<[item]> d:<[inv]>
    - inventory open d:<[inv]>