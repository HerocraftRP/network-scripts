capabilities_data:
  type: data
  capability:
    lumberjack_harvest:
      type: gathering
      capability: lumberjack
      tool: *_axe
      action_string: <&6>Chopping Logs
      action_time: 5s
      animation_task: lumberjack_chopping_tree_animate
      fake_to_air: false
      fake_to_air_duration: 0s
      harvests:
        oak_*:
          material_given: oak_log
          quantity_given: 1
          capability_gained: 0.001
          capability_needed: 1
        birch_*:
          material_given: birch_log
          quantity_given: 1
          seconds_needed: 5
          capability_gained: 0.001
          capability_needed: 100
        spruce_*:
          material_given: spruce_log
          quantity_given: 1
          seconds_needed: 5
          capability_gained: 0.001
          capability_needed: 200
        jungle_*:
          material_given: jungle_log
          quantity_given: 1
          capability_gained: 0.001
          capability_needed: 300
        acacia_*:
          material_given: acacia_log
          quantity_given: 1
          capability_gained: 0.001
          capability_needed: 400
        dark_oak_*:
          material_given: dark_oak_log
          quantity_given: 1
          capability_gained: 0.001
          capability_needed: 500
    lumberjack_chop:
      type: gathering
      capability: lumberjack
      tool: *_axe
      action_string: <&6>Splitting Planks
      action_time: 5s
      animation_task: lumberjack_chopping_block_animate
      fake_to_air: false
      fake_to_air_duration: 0s
      harvests:
        oak_log:
          material_given: lumberjack_oak_planks
          quantity_given: 1
          capability_gained: 0.001
          capability_needed: 1
        birch_log:
          material_given: lumberjack_birch_planks
          quantity_given: 1
          capability_gained: 0.001
          capability_needed: 1
        spruce_log:
          material_given: lumberjack_spruce_planks
          quantity_given: 1
          seconds_needed: 5
          capability_gained: 0.05
          capability_needed: 200
        jungle_log:
          material_given: lumberjack_jungle_planks
          quantity_given: 1
          capability_gained: 0.05
          capability_needed: 300
        acacia_log:
          material_given: lumberjack_acacia_planks
          quantity_given: 1
          capability_gained: 0.05
          capability_needed: 400
        dark_oak_log:
          material_given: lumberjack_dark_oak_planks
          quantity_given: 1
          capability_gained: 0.05
          capability_needed: 500
    mining:
      type: gathering
      capability: mining
      tool: *_pickaxe
      action_string: <&6>Mining Mineral
      action_time: 8.5s
      animation_task: mining_animation
      fake_to_air: true
      fake_to_air_duration: 10m
      harvests:
        raw_iron_block:
          material_given: mining_stone
          quantity_given: 1
          capability_gained: 0.05
          capability_needed: 0
        copper_ore:
          material_given: mining_copper_nugget
          quantity_given: 1
          capability_gained: 0.05
          capability_needed: 100
        iron_ore:
          material_given: mining_iron_nugget
          quantity_given: 1
          capability_gained: 0.05
          capability_needed: 200
        epicsamurai_silver_ore:
          material_given: mining_silver_nugget
          quantity_given: 1
          capability_gained: 0.05
          capability_needed: 300
        epicsamurai_steel_block:
          material_given: mining_steel_nugget
          quantity_given: 1
          capability_gained: 0.05
          capability_needed: 400
    farming:
      type: gathering
      capability: farming
      tool: *_hoe
      action_string: <&6>Harvesting Crop
      action_time: 5s
      animation_task: farming_animation
      fake_to_air: true
      fake_to_air_duration: 5m
      harvests:
        WHEAT:
          material_given: FARMING_wheat
          quantity_given: 1
          capability_gained: 0.1
          capability_needed: 0
        FARMERSDELIGHT_CABBAGES:
          material_given: FARMING_FARMERSDELIGHT_CABBAGE
          quantity_given: 3
          capability_gained: 0.1
          capability_needed: 100
        CARROTS:
          material_given: FARMING_carrot
          quantity_given: 3
          capability_gained: 0.1
          capability_needed: 200
        FARMERSDELIGHT_ONIONS:
          material_given: FARMING_FARMERSDELIGHT_ONION
          quantity_given: 3
          capability_gained: 0.1
          capability_needed: 300
        FARMERSDELIGHT_TOMATOES:
          material_given: FARMING_FARMERSDELIGHT_TOMATO
          quantity_given: 3
          capability_gained: 0.1
          capability_needed: 400
    ranching:
      type: ranching
      capability: ranching
      cow:
        bucket:
          action_string: <&6>Milking Cow
          action_time: 2
          animation_task: noop
          material_given: milk_bucket
          quantity_given: 1
          capability_gained: 0.1
          capability_needed: 0
          fake_kill_entity: false
        ranch_butchering_knife:
          action_string: <&6>Butchering Cow
          action_time: 2
          animation_task: noop
          material_given: beef
          quantity_given: 1
          capability_gained: 0.1
          capability_needed: 200
          fake_kill_entity: true
      pig:
        air:
          action_string: <&6>?!?!?!??!?
          action_time: 2
          animation_task: noop
          material_given: brown_mushroom
          quantity_given: 1
          capability_gained: 0.1
          capability_needed: 0
          fake_kill_entity: false
        ranch_butchering_knife:
          action_string: <&6>Butchering Pig
          action_time: 2
          animation_task: noop
          material_given: porkchop
          quantity_given: 1
          capability_gained: 0.1
          capability_needed: 100
          fake_kill_entity: true
      chicken:
        air:
          action_string: <&6>Gathering Egg
          action_time: 2
          animation_task: noop
          material_given: egg
          quantity_given: 1
          capability_gained: 0.1
          capability_needed: 0
          fake_kill_entity: false
        ranch_butchering_knife:
          action_string: <&6>Butchering Chicken
          action_time: 2
          animation_task: noop
          material_given: chicken
          quantity_given: 1
          capability_gained: 0.1
          capability_needed: 0
          fake_kill_entity: true
      sheep:
        shears:
          action_string: <&6>Shearing Sheep
          action_time: 2
          animation_task: noop
          material_given: white_wool
          quantity_given: 1
          capability_gained: 0.1
          capability_needed: 0
          fake_kill_entity: false
        ranch_butchering_knife:
          action_string: <&6>Butchering Sheep
          action_time: 2
          animation_task: noop
          material_given: farmersdelight_mutton_chops
          quantity_given: 1
          capability_gained: 0.1
          capability_needed: 400
          fake_kill_entity: true
    smelting:
      type: inhand_production
      capability: blacksmith
      action_string: <&6>Smelting Metal
      action_time: 5s
      animation_task: noop
      cancel_task: profession_refund_production
      crafting_menu: false
      crafts:
        mining_copper_nugget:
          capability_needed: 100
          material_cost: 18
          material_given: blacksmith_copper_ingot
        mining_iron_nugget:
          capability_needed: 200
          material_cost: 18
          material_given: blacksmith_iron_ingot
        mining_silver_nugget:
          capability_needed: 300
          material_cost: 18
          material_given: blacksmith_silver_nugget
        mining_steel_nugget:
          capability_needed: 400
          material_cost: 18
          material_given: blacksmith_steel_nugget
    blacksmith:
      type: place_production
      capability: blacksmith
      tool: magistuarmory_blacksmith_hammer
      action_string: <&6>Smithing Item
      action_time: 9s
      animation_task: noop
      cancel_task: profession_refund_production
      crafting_menu: true
      materials:
        stone:
          need_shift: true
          shift: <[passthrough].center.below[0.62].forward[0.25]>
          capability_needed: 1
          items:
            blacksmith_magistuarmory_stone_stylet:
              material_cost:
                mining_stone: 3
                woodwork_wooden_tool_handle: 2
              capability_needed: 0
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_shortsword:
              material_cost:
                mining_stone: 6
                woodwork_wooden_tool_handle: 2
              capability_needed: 5
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_katzbalger:
              material_cost:
                mining_stone: 10
                woodwork_wooden_tool_handle: 2
              capability_needed: 10
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_pike:
              material_cost:
                mining_stone: 10
                woodwork_wooden_tool_handle: 2
              capability_needed: 20
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_ahlspiess:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 25
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_estoc:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 30
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_bastardsword:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 35
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_claymore:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 40
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_zweihander:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 45
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_lochaberaxe:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 55
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_concavehalberd:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 60
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_heavymace:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 65
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_heavywarhammer:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 70
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_lucernhammer:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 75
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_morgenstern:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 80
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_guisarme:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 85
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_heatershield:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 95
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_target:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 100
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_buckler:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 105
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_rondache:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 110
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_tartsche:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 115
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_ellipticalshield:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 120
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_roundshield:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 125
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_pavese:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 130
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
            blacksmith_magistuarmory_stone_kiteshield:
              material_cost:
                mining_stone: 15
                woodwork_wooden_tool_handle: 2
              capability_needed: 135
              rep_gained: 0.1
              need_shift: true
              shift: <[passthrough].above[0.1].forward[0.4].right[0.2]>
        iron_ingot:
          need_shift: false
          items:
            blacksmith_magistuarmory_iron_stylet:
              material_cost:
                mining_stone: 3
                woodwork_wooden_tool_handle: 2
              capability_needed: 0
              rep_gained: 0.1
              need_shift: true
              shift: <[location].above[0.1].right[0.2]>
    sewing:
      type: inhand_production
      capability: tailoring
      tool: tailoring_sewing_needle
      action_string: <&6>Sewing
      action_time: 6s
      animation_task: noop
      cancel_task: profession_refund_production
      crafting_menu: true
      materials:
        tailoring_sewing_needle:
          items:
            sewingkit_leather_strip:
              material_cost:
                leather: 5
              capability_needed: 0
              rep_gained: 0.1
            sewingkit_leather_sheet:
              material_cost:
                leather: 10
              capability_needed: 1
              rep_gained: 0.1
            magistuarmory_woolen_fabric:
              material_cost:
                white_wool: 5
              capability_needed: 2
              rep_gained: 0.1
            sewingkit_wool_shoes:
              material_cost:
                oak_planks: 5
              capability_needed: 5
              rep_gained: 0.1
            sewingkit_wool_pants:
              material_cost:
                oak_planks: 5
              capability_needed: 10
              rep_gained: 0.1
            sewingkit_wool_shirt:
              material_cost:
                oak_planks: 5
              capability_needed: 15
              rep_gained: 0.1
            sewingkit_wool_hat:
              material_cost:
                oak_planks: 5
              capability_needed: 20
              rep_gained: 0.1
            leather_boots:
              material_cost:
                oak_planks: 5
              capability_needed: 25
              rep_gained: 0.1
            leather_leggings:
              material_cost:
                oak_planks: 5
              capability_needed: 30
              rep_gained: 0.1
            leather_chestplate:
              material_cost:
                oak_planks: 5
              capability_needed: 35
              rep_gained: 0.1
            leather_helmet:
              material_cost:
                oak_planks: 5
              capability_needed: 40
              rep_gained: 0.1
            comforts_sleeping_bag_white:
              material_cost:
                oak_planks: 5
              capability_needed: 45
              rep_gained: 0.1
            comforts_sleeping_bag_orange:
              material_cost:
                oak_planks: 5
              capability_needed: 50
              rep_gained: 0.1
            comforts_sleeping_bag_magenta:
              material_cost:
                oak_planks: 5
              capability_needed: 55
              rep_gained: 0.1
            comforts_sleeping_bag_light_blue:
              material_cost:
                oak_planks: 5
              capability_needed: 60
              rep_gained: 0.1
            comforts_sleeping_bag_yellow:
              material_cost:
                oak_planks: 5
              capability_needed: 65
              rep_gained: 0.1
            comforts_sleeping_bag_lime:
              material_cost:
                oak_planks: 5
              capability_needed: 70
              rep_gained: 0.1
            comforts_sleeping_bag_pink:
              material_cost:
                oak_planks: 5
              capability_needed: 75
              rep_gained: 0.1
            comforts_sleeping_bag_gray:
              material_cost:
                oak_planks: 5
              capability_needed: 80
              rep_gained: 0.1
            comforts_sleeping_bag_light_gray:
              material_cost:
                oak_planks: 5
              capability_needed: 85
              rep_gained: 0.1
            comforts_sleeping_bag_cyan:
              material_cost:
                oak_planks: 5
              capability_needed: 90
              rep_gained: 0.1
            comforts_sleeping_bag_purple:
              material_cost:
                oak_planks: 5
              capability_needed: 95
              rep_gained: 0.1
            comforts_sleeping_bag_blue:
              material_cost:
                oak_planks: 5
              capability_needed: 100
              rep_gained: 0.1
            comforts_sleeping_bag_brown:
              material_cost:
                oak_planks: 5
              capability_needed: 105
              rep_gained: 0.1
            comforts_sleeping_bag_green:
              material_cost:
                oak_planks: 5
              capability_needed: 110
              rep_gained: 0.1
            comforts_sleeping_bag_red:
              material_cost:
                oak_planks: 5
              capability_needed: 115
              rep_gained: 0.1
            comforts_sleeping_bag_black:
              material_cost:
                oak_planks: 5
              capability_needed: 120
              rep_gained: 0.1
            days_in_the_middle_ages_leather_coinpouch:
              material_cost:
                oak_planks: 5
              capability_needed: 125
              rep_gained: 0.1
            sophisticatedbackpacks_backpack:
              material_cost:
                oak_planks: 5
              capability_needed: 130
              rep_gained: 0.1
    woodwork:
      type: inhand_production
      capability: woodwork
      tool: none
      action_string: <&6>Working Wood
      action_time: 6s
      animation_task: noop
      cancel_task: profession_refund_production
      crafting_menu: true
      materials:
        oak_planks:
          items:
            oak_slab:
              material_cost:
                oak_planks: 5
              capability_needed: 0
              rep_gained: 0.1
              needs_downshift: false
            oak_stairs:
              material_cost:
                oak_planks: 5
              capability_needed: 5
              rep_gained: 0.1
              needs_downshift: false
            stripped_oak_log:
              material_cost:
                oak_planks: 10
              capability_needed: 10
              rep_gained: 0.1
              needs_downshift: false
            woodwork_wooden_tool_handle:
              material_cost:
                oak_planks: 15
              capability_needed: 15
              rep_gained: 0.1
              needs_downshift: false
            oak_fence:
              material_cost:
                oak_planks: 20
              capability_needed: 20
              rep_gained: 0.1
              needs_downshift: false
            oak_fence_gate:
              material_cost:
                oak_planks: 25
              capability_needed: 25
              rep_gained: 0.1
              needs_downshift: false
            oak_door:
              material_cost:
                oak_planks: 25
              capability_needed: 30
              rep_gained: 0.1
              needs_downshift: false
            oak_trapdoor:
              material_cost:
                oak_planks: 30
              capability_needed: 35
              rep_gained: 0.1
              needs_downshift: false
            oak_pressure_plate:
              material_cost:
                oak_planks: 35
              capability_needed: 40
              rep_gained: 0.1
              needs_downshift: false
            oak_button:
              material_cost:
                oak_planks: 40
              capability_needed: 45
              rep_gained: 0.1
              needs_downshift: false
            oak_sign:
              material_cost:
                oak_planks: 45
              capability_needed: 50
              rep_gained: 0.1
              needs_downshift: false
            oak_hanging_sign:
              material_cost:
                oak_planks: 50
              capability_needed: 55
              rep_gained: 0.1
              needs_downshift: false
            farmersdelight_oak_cabinet:
              material_cost:
                oak_planks: 55
              capability_needed: 60
              rep_gained: 0.1
              needs_downshift: false
            create_oak_window:
              material_cost:
                oak_planks: 60
              capability_needed: 70
              rep_gained: 0.1
              needs_downshift: false
            aquaculture_oak_fish_mount:
              material_cost:
                oak_planks: 65
              capability_needed: 75
              rep_gained: 0.1
              needs_downshift: false
    fletching:
      type: inhand_production
      capability: fletching
      tool: oak_planks
      action_string: <&6>Fletching
      action_time: 6s
      animation_task: noop
      cancel_task: profession_refund_production
      crafting_menu: true
      materials:
        oak_planks:
          items:
            wooden_hoe:
              material_cost:
                lumberjack_oak_planks: 5
              capability_needed: 0
              rep_gained: 0.1
              needs_downshift: false

##Entity/Location Interaction Flags

# All Farming Crops
profession_farming_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - define capability farming
    - define material <context.location.material.name>
    - define passthrough <context.location>
    - inject profession_interact_<script[capabilities_data].data_key[capability.farming.type]>

# Chopping Trees
profession_lumberjack_harvest_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - define capability lumberjack_harvest
    - define material <context.location.material.name>
    - define passthrough <context.location>
    - inject profession_interact_<script[capabilities_data].data_key[capability.lumberjack_harvest.type]>

# Chopping Logs into Planks
profession_lumberjack_chop_interact:
  type: task
  debug: false
  script:
    - if <context.entity.equipment_map.is_empty>:
      - if <script[capabilities_data].data_key[capability.lumberjack_chop.harvests.<player.item_in_hand.material.name>].exists>:
        - define item <player.item_in_hand>
        - inventory set slot:<player.held_item_slot> o:air
        - wait 1t
        - equip <context.entity> head:<[item]>
      - stop
    - else if <player.item_in_hand.material.name> == air:
      - stop
    - define capability lumberjack_chop
    - define material <context.entity.equipment_map.get[helmet].material.name>
    - define passthrough <context.entity>
    - inject profession_interact_<script[capabilities_data].data_key[capability.lumberjack_chop.type]>

# All Mineble Ores
profession_mining_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - define capability mining
    - define material <context.location.material.name>
    - define passthrough <context.location>
    - inject profession_interact_<script[capabilities_data].data_key[capability.mining.type]>

# All Ranching Animals
profession_ranching_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - define capability ranching
    - define passthrough <context.entity>
    - inject profession_interact_<script[capabilities_data].data_key[capability.ranching.type]>

# All Blacksmithing Anvils
profession_blacksmith_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - define capability blacksmith
    - define passthrough <context.location>
    - inject profession_interact_<script[capabilities_data].data_key[capability.blacksmith.type]>

# Smelting Furnace
profession_smelting_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - define capability smelting
    - define passthrough <context.location>
    - inject profession_interact_<script[capabilities_data].data_key[capability.smelting.type]>

# All Sewing Tables
profession_sewing_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - define capability sewing
    - define passthrough <context.location>
    - inject profession_interact_<script[capabilities_data].data_key[capability.sewing.type]>

# All Cooking Blocks
profession_cooking_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - define capability cooking
    - define passthrough <context.entity>
    - inject profession_interact_<script[capabilities_data].data_key[capability.cooking.type]>

# All Woodwork Saws
profession_woodwork_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - define capability woodwork
    - define passthrough <context.location>
    - inject profession_interact_<script[capabilities_data].data_key[capability.woodwork.type]>

# All Fletching Saws
profession_fletching_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - define capability fletching
    - define passthrough <player>
    - inject profession_interact_<script[capabilities_data].data_key[capability.fletching.type]>

##Shared Profession Scripts
profession_generic_callback:
  type: task
  debug: false
  definitions: capability_used|give_item
  script:
    - if <[give_item]||false>:
      - foreach <player.flag[temp.timed_action.results]> as:item:
        - foreach <player.flag[temp.timed_action.result_quantity].get[<[loop_index]>]>:
          - give item:<[item]>
    - playsound sound:ENTITY_ITEM_PICKUP <player>
    - run narrate_empty_inventory_slots

##Shared Production Crafting Scripts
profession_craft_production:
  type: task
  debug: false
  script:
    - define material <context.item.flag[material]>
    - define capability <context.item.flag[capability]>
    - stop if:<player.item_in_hand.advanced_matches[<script[capabilities_data].data_key[capability.<[capability]>.tool]>].not>
    - define craftCost <context.item.flag[craftCost]>
    - foreach <[craftCost]> key:needed_item as:quantity:
      - if !<player.inventory.contains_item[<[needed_item]>].quantity[<[quantity]>]>:
        - narrate "<&e>You need more <[needed_item].replace[_].with[<&sp>].to_titlecase>"
        - stop
    - foreach <[craftCost]> key:needed_item as:quantity:
      - take item:<[needed_item]> quantity:<[quantity]>
    - flag <player> temp.timed_action.crafting_location:<context.item.flag[crafting_location]>
    - flag <player> temp.timed_action.cost:<context.item.flag[craftCost]>
    - flag <player> temp.timed_action.results:<list[<context.item.script.name>]>
    - flag <player> temp.timed_action.result_quantity:<list[1]>
    - flag <player> temp.timed_action.material:<context.item.flag[material]>
    - flag <player> temp.timed_action.capability_used:<context.item.flag[capability]>
    - define action_string <script[capabilities_data].parsed_key[capability.<[capability]>.action_string]>
    - define action_time <script[capabilities_data].data_key[capability.<[capability]>.action_time]>
    - define animation_task <script[capabilities_data].data_key[capability.<[capability]>.animation_task]>
    - define cancel_task <script[capabilities_data].data_key[capability.<[capability]>.cancel_task]>
    - run start_timed_action def:<[action_string]>|<[action_time]>|profession_craft_production_callback|<context.item.flag[crafting_location]> def.animation_task:<[animation_task]> def.distance_from_origin:1 def.cancel_script:<[cancel_task]>
    - inventory close

profession_refund_production:
  type: task
  debug: false
  script:
    - remove <player.flag[temp.timed_action.removable]> if:<player.has_flag[temp.timed_action.removable]>
    - foreach <player.flag[temp.timed_action.cost]> key:needed_item as:quantity:
      - give item:<[needed_item]> quantity:<[quantity]>

profession_craft_production_callback:
  type: task
  debug: false
  script:
    - run profession_generic_callback def:<player.flag[temp.timed_action.capability_used]>|true

profession_crafting_menu_open:
  type: task
  debug: false
  definitions: capability|material|passthrough
  script:
    - define inv <inventory[profession_place_production_inventory]>
    - define capability_used <script[capabilities_data].data_key[capability.<[capability]>.capability]>
    - foreach <server.flag[profession_data.capability_tables.<[capability]>.<[material]>]> key:capNeeded as:item:
      - if <player.flag[character.capabilities.<[capability_used]>]||0> < <[capNeeded]>:
        - foreach stop
      - else:
        - define craftCost <script[capabilities_data].data_key[capability.<[capability]>.materials.<[material]>.items.<[item]>.material_cost]>
        - define lore <list[<&e>------------|<&e>Crafting Cost:]>
        - foreach <[craftCost]> key:material as:quantity:
          - define lore "<[lore].include[<&e><[quantity]> <[material].replace[_].with[<&sp>].to_titlecase>]>"
        - define lore <[lore].include[<&e>------------]>
        - define item <item[<[item]>].with[lore=<[lore]>]>
        - flag <[item]> run_script:profession_craft_production
        - flag <[item]> crafting_location:<[passthrough]>
        - flag <[item]> material:<[material]>
        - flag <[item]> capability:<[capability]>
        - flag <[item]> craftCost:<[craftCost]>
        - inventory set slot:<[loop_index]> o:<[item]> d:<[inv]>
    - inventory open d:<[inv]>

## Gathering
profession_interact_gathering:
  type: task
  debug: false
  definitions: capability
  script:
    - determine passively cancelled
    - wait 1t
    - if <player.has_flag[timed_action]>:
      - stop
    - foreach <script[capabilities_data].data_key[capability.<[capability]>.harvests].keys>:
      - if <[material].advanced_matches[<[value]>]>:
        - define material <[value]>
        - foreach stop
    - define capability_used <script[capabilities_data].data_key[capability.<[capability]>.capability]>
    - if <player.flag[character.capabilities.<[capability_used]>]||0> < <script[capabilities_data].data_key[capability.<[capability]>.harvests.<[material]>.capability_needed]>:
      - narrate "<&c>You lack the capability to harvest this."
      - stop
    - if !<player.item_in_hand.material.name.advanced_matches[<script[capabilities_data].data_key[capability.<[capability]>.tool]>]>:
      - narrate "<&c>You need the right tool for this..."
      - stop
    - define item_given <item[<script[capabilities_data].data_key[capability.<[capability]>.harvests.<[material]>.material_given]>]>
    - define quantity_given <script[capabilities_data].data_key[capability.<[capability]>.harvests.<[material]>.quantity_given]>
    - flag player temp.timed_action.results:<list[<[item_given]>]>
    - flag player temp.timed_action.result_quantity:<list[<[quantity_given]>]>
    - flag player temp.timed_action.capability:<[capability]>
    - flag player temp.timed_action.capability_used:<script[capabilities_data].data_key[capability.<[capability]>.capability]>
    - if <util.delta_time_since_start.in_seconds.is_decimal>:
      - announce <element[20].sub[<duration[0.<util.delta_time_since_start.in_seconds.after[.]>s].in_ticks>]>
      - wait <element[20].sub[<duration[0.<util.delta_time_since_start.in_seconds.after[.]>s].in_ticks>]>t
    - run start_timed_action def:<script[capabilities_data].parsed_key[capability.<[capability]>.action_string]>|<script[capabilities_data].parsed_key[capability.<[capability]>.action_time]>|profession_interact_gathering_callback|<[passthrough]> def.distance_from_origin:1 def.can_swap_items:false def.animation_task:<script[capabilities_data].data_key[capability.<[capability]>.animation_task]>

profession_interact_gathering_callback:
  type: task
  debug: false
  definitions: passthrough
  script:
    - define capability <player.flag[temp.timed_action.capability]>
    - if <[passthrough].object_type> == ENTITY:
      - equip <[passthrough]> head:air
    - else if <script[capabilities_data].data_key[capability.<[capability]>.fake_to_air]>:
      - showfake <[passthrough]> air duration:<script[capabilities_data].data_key[capability.<[capability]>.fake_to_air_duration]>
    - run profession_generic_callback def:<player.flag[temp.timed_action.capability_used]>|true

## Ranching
profession_interact_ranching:
  type: task
  debug: false
  definitions: capability
  script:
    - determine passively cancelled
    - define item_in_hand <player.item_in_hand>
    - wait 1t
    - inventory update
    - ratelimit <player> 1t
    - define tool null
    - foreach <script[capabilities_data].data_key[capability.<[capability]>.<context.entity.entity_type>].keys>:
      - if <[item_in_hand].advanced_matches[<[value]>]>:
        - define tool <[value]>
        - foreach stop
    - if <[tool]> == null:
      - narrate "<&c>You cannot harvest with this tool."
      - stop
    - if <player.flag[job.ranching.reputation]||0> < <script[capabilities_data].data_key[capability.<[capability]>.<[passthrough].entity_type>.<[tool]>.capability_needed]>:
      - narrate "<&c>You lack the reputation to harvest this."
      - stop
    - if <player.has_flag[temp.last_harvested.<[passthrough].uuid>]> && <player.flag[temp.last_harvested.<[passthrough].uuid>].from_now.is_less_than[2m]>:
      - narrate "<&c>Animal has no produce."
      - stop
    - define action_string <script[capabilities_data].parsed_key[capability.<[capability]>.<[passthrough].entity_type>.<[tool]>.action_string]>
    - define action_time <script[capabilities_data].data_key[capability.<[capability]>.<[passthrough].entity_type>.<[tool]>.action_time]>
    - define animation_task <script[capabilities_data].data_key[capability.<[capability]>.<[passthrough].entity_type>.<[tool]>.animation_task]>
    - define item_given <script[capabilities_data].data_key[capability.<[capability]>.<[passthrough].entity_type>.<[tool]>.material_given]>
    - define quantity_given <script[capabilities_data].data_key[capability.<[capability]>.<[passthrough].entity_type>.<[tool]>.quantity_given]>
    - flag player temp.timed_action.results:<list[<[item_given]>]>
    - flag player temp.timed_action.result_quantity:<list[<[quantity_given]>]>
    - flag player temp.timed_action.tool:<[tool]>
    - run start_timed_action def:<[action_string]>|<[action_time]>|profession_interact_ranching_callback|<[passthrough]> def.distance_from_origin:2 def.can_swap_items:false def.animation_task:<[animation_task]>

profession_interact_ranching_callback:
  type: task
  debug: false
  definitions: entity
  script:
    - stop if:<player.has_flag[temp.timed_action.tool].not>
    - define tool <player.flag[temp.timed_action.tool]>
    - if <[tool]> == bucket:
      - inventory set slot:<player.held_item_slot> o:milk_bucket d:<player.inventory>
      - run profession_generic_callback def:ranching
    - else:
      - run profession_generic_callback def:ranching|true
    - if <script[capabilities_data].data_key[capability.ranching.<[entity].entity_type>.<[tool]>.fake_kill_entity]>:
      - adjust <player> fake_entity_health:[entity=<[entity]>;health=0]
      - wait 10t
      - adjust <player> hide_entity:<[entity]>
      - wait 10s
      - adjust <player> show_entity:<[entity]>
    - else:
      - flag <player> temp.last_harvested.<[entity].uuid>:<util.time_now>

## Inhand Production
profession_interact_inhand_production:
  type: task
  debug: false
  definitions: capability
  script:
    - determine passively cancelled
    - wait 1t
    - if <player.item_in_hand.material.name> == air:
      - narrate "<&c>You're not holding anything to smelt."
      - stop
    - define material null
    - if <script[capabilities_data].data_key[capability.<[capability]>.crafting_menu]>:
      - run profession_crafting_menu_open def:<[capability]>|<player.item_in_hand.script.name>||<player.item_in_hand.material.name>>|<[passthrough]>
      - stop
    - foreach <script[capabilities_data].data_key[capability.<[capability]>.crafts].keys>:
      - if <player.item_in_hand.advanced_matches[<[value]>]>:
        - define material <[value]>
        - foreach stop
    - if <[material]> == null:
      - narrate "<&c>You cannot make anything with this."
      - stop
    - define capability_used <script[capabilities_data].data_key[capability.<[capability]>.capability]>
    - if <player.flag[character.capabilities.<[capability_used]>]||0> < <script[capabilities_data].data_key[capability.<[capability]>.crafts.<[material]>.capability_needed]>:
      - narrate "<&c>You lack the reputation to harvest this."
      - stop
    - define craftCost <script[capabilities_data].data_key[capability.<[capability]>.crafts.<[material]>.material_cost]>
    - if !<player.inventory.contains_item[<[material]>].quantity[<[craftCost]>]>:
      - narrate "<&e>You need more <[material].after[_].replace[_].with[<&sp>].to_titlecase>"
      - stop
    - take item:<[material]> quantity:<[craftCost]>
    - define result <script[capabilities_data].data_key[capability.<[capability]>.crafts.<[material]>.material_given]>
    - define action_string <script[capabilities_data].parsed_key[capability.<[capability]>.action_string]>
    - define action_time <script[capabilities_data].data_key[capability.<[capability]>.action_time]>
    - define animation_task <script[capabilities_data].data_key[capability.<[capability]>.animation_task]>
    - define cancel_task <script[capabilities_data].data_key[capability.<[capability]>.cancel_task]>
    - flag <player> temp.timed_action.results:<list[<[result]>]>
    - flag <player> temp.timed_action.result_quantity:<list[1]>
    - flag <player> temp.timed_action.cost:<map.with[<[material]>].as[<[craftCost]>]>
    - flag <player> temp.timed_action.capability:<[capability]>
    - flag <player> temp.timed_action.capability_used:<[capability_used]>
    - else:
      - run start_timed_action "def:<[action_string]>|<[action_time]>|profession_interact_inhand_production_callback|<[passthrough]>" def.distance_from_origin:1 def.animation_task:<[animation_task]> def.can_swap_items:false def.cancel_script:<[cancel_task]>

profession_interact_inhand_production_callback:
  type: task
  debug: false
  script:
    - define capability <player.flag[temp.timed_action.capability]>
    - run profession_generic_callback def:<player.flag[temp.timed_action.capability_used]>|true

## Place Production
profession_place_production_inventory:
  type: inventory
  debug: false
  inventory: chest
  title: <&6>Craftin Menu
  size: 54
  data:
    any_click: cancel

profession_interact_place_production:
  type: task
  debug: false
  definitions: capability
  script:
    - define material <player.item_in_hand.material.name>
    # Get item off workspace, if placed
    - if <[material]> == air:
      - if <[passthrough].has_flag[armor_stand]>:
        - inventory set slot:<player.held_item_slot> o:<[passthrough].flag[armor_stand].equipment_map.get[helmet]>
        - remove <[passthrough].flag[armor_stand]>
        - flag <[passthrough]> armor_stand:!
    # Place item on workspace
    - else if !<[passthrough].has_flag[armor_stand]>:
      - if <script[capabilities_data].data_key[capability.<[capability]>.materials.<[material]>.need_shift]>:
        - spawn <entity[blacksmith_armor_stand].with[equipment=<list[air|air|air|<[material]>]>]> <script[capabilities_data].parsed_key[capability.<[capability]>.materials.<[material]>.shift]> save:as
      - else:
        - spawn <entity[blacksmith_armor_stand].with[equipment=<list[air|air|air|<[material]>]>]> <[location].center.below[0.65].forward[0.8]> save:as
      - inventory set slot:<player.held_item_slot> o:air
      - flag <[passthrough]> armor_stand:<entry[as].spawned_entity>
    # Using tool on Workspace
    - else if <[material].advanced_matches[<script[capabilities_data].data_key[capability.<[capability]>.tool]>]>:
      - define as <[passthrough].flag[armor_stand]>
      - define working_material <[as].equipment_map.get[helmet].material.name||null>
      - if <[working_material]> == null:
        - narrate "<&c>You need to place a material on this workspace."
        - stop
      - define capability_used <script[capabilities_data].data_key[capability.<[capability]>.capability]>
      - if <player.flag[character.capabilities.<[capability_used]>]||0> < <script[capabilities_data].data_key[capability.<[capability]>.materials.<[working_material]>.capability_needed]>:
        - narrate "<&c>You lack the capability to work this material."
        - stop
      # Open Crafting Inventory
      - run profession_crafting_menu_open def:<[capability]>|<[working_material]>|<[passthrough]>
