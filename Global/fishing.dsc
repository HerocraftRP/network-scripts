fishing_cod_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Cod
  flags:
    interaction:
      1:
        script: unbundle_bundle
        display: <&e>Unbundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Unbundle
    - "<&7>___________________"


fishing_salmon_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Salmon
  flags:
    interaction:
      1:
        script: unbundle_bundle
        display: <&e>Unbundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Unbundle
    - "<&7>___________________"

fishing_ink_sac_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Ink Sacs
  flags:
    interaction:
      1:
        script: unbundle_bundle
        display: <&e>Unbundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Unbundle
    - "<&7>___________________"

fishing_bone_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Bones
  flags:
    interaction:
      1:
        script: unbundle_bundle
        display: <&e>Unbundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Unbundle
    - "<&7>___________________"

fishing_kelp_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Kelp
  flags:
    interaction:
      1:
        script: unbundle_bundle
        display: <&e>Unbundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Unbundle
    - "<&7>___________________"

fishing_cod:
  type: item
  material: cod
  display name: <&6>Cod
  allow in material recipes: true
  flags:
    interaction:
      1:
        script: fishing_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

fishing_salmon:
  type: item
  material: cod
  display name: <&6>Salmon
  allow in material recipes: true
  flags:
    interaction:
      1:
        script: fishing_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

fishing_ink_sac:
  type: item
  material: cod
  display name: <&6>Ink Sac
  allow in material recipes: true
  flags:
    interaction:
      1:
        script: fishing_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

fishing_bone:
  type: item
  material: cod
  display name: <&6>Bone
  allow in material recipes: true
  flags:
    interaction:
      1:
        script: fishing_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

fishing_kelp:
  type: item
  material: cod
  display name: <&6>Kelp
  allow in material recipes: true
  flags:
    interaction:
      1:
        script: fishing_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

fishing_table:
  type: data
  data:
    loot_table_per_level:
      0:
        fishing_cod: 20
        leather_boots[durability=60]: 30
      1:
        fishing_cod: 20
        fishing_salmon: 20
        leather_boots[durability=60]: 30
      2:
        fishing_cod: 20
        fishing_salmon: 20
        fishing_ink_sac: 20
        leather_boots[durability=60]: 20
      3:
        fishing_cod: 20
        fishing_salmon: 20
        fishing_ink_sac: 20
        fishing_bone: 10
        leather_boots[durability=60]: 15
      4:
        fishing_cod: 20
        fishing_salmon: 20
        fishing_ink_sac: 20
        leather_boots[durability=60]: 10
        fishing_bone: 10
        fishing_kelp: 10
      5:
        fishing_cod: 20
        fishing_salmon: 20
        fishing_ink_sac: 20
        leather_boots[durability=60]: 5
        fishing_bone: 10
        fishing_kelp: 10

basic_fishing_rod:
  type: item
  debug: false
  display name: <&r>Basic Fishing Rod
  material: fishing_rod
  flags:
    hook: iron_hook
    right_click_script: fishing_start
    interaction:
      1:
        script: fishing_rod_open
        display: <&b>Fishing<&co> <&6>Manage Rod
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co> <&b>Fishing<&co> <&6>Manage Rod
    - "<&7>___________________"

iron_fishing_rod:
  type: item
  debug: false
  display name: <&r>Iron Fishing Rod
  material: fishing_rod
  flags:
    right_click_script: fishing_start
  mechanisms:
    custom_model_data: 1

golden_fishing_rod:
  type: item
  debug: false
  display name: <&r>Golden Fishing Rod
  material: fishing_rod
  flags:
    right_click_script: fishing_start
  mechanisms:
    custom_model_data: 2

diamond_fishing_rod:
  type: item
  debug: false
  display name: <&r>Diamond Fishing Rod
  material: fishing_rod
  flags:
    right_click_script: fishing_start
  mechanisms:
    custom_model_data: 3

neptunium_fishing_rod:
  type: item
  debug: false
  display name: <&r>Neptunium Fishing Rod
  material: fishing_rod
  flags:
    right_click_script: fishing_start
  mechanisms:
    custom_model_data: 4

fishing_start:
  type: task
  debug: false
  script:
    - define hook <context.item.flag[hook]>
    - define capability_needed <script[capabilities_data].data_key[capability.fishing.capability_for_hook.<[hook]>]>
    - if <player.flag[character.capabilities.fishing]||0> < <[capability_needed]>:
      - narrate "<&c>You lack the capability to use this hook."
      - narrate "<&e>Learn more Fishing, or change Hooks."
      - determine cancelled

fishing_packaging_command:
  type: command
  name: fishing_package
  debug: false
  description: Not for manual usage
  permissions: not.a.perm
  usage: DON'T
  script:
    - adjust <queue> linked_player:<server.match_player[<context.args.get[1]>]>
    - inventory close
    - run fishing_packaging_interact

fishing_packaging_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - ratelimit <player> 1t
    - if !<player.inventory.contains_item[empty_bundle]>:
      - narrate "<&c>You need an empty bundle for this."
      - stop
    - wait 1t
    - define item <player.item_in_hand>
    - if <script[fishing_packaging].data_key[data.stack_sizes.<[item].material.name>].exists>:
      - define quantity <script[fishing_packaging].data_key[data.stack_sizes.<[item].script.name>]>
      - if <player.inventory.contains_item[<[item].script.name>].quantity[<[quantity]>]>:
        - run start_timed_action "def:<&6>Packaging <[item].display>|4s|fishing_packaging" def.can_swap_items:false def.can_move:false
      - else:
        - narrate "<&c>You need atleast <[quantity]> <[item].display>"
    - else:
      - narrate "<&c>I can work with this."

fishing_packaging:
  type: task
  debug: false
  data:
    stack_sizes:
      cod: 18
      salmon: 16
      ink_sac: 28
      bone: 20
      kelp: 19
  script:
    - if !<player.inventory.contains_item[empty_bundle]>:
      - narrate "<&c>You need an empty bundle for this."
      - stop
    - take item:empty_bundle quantity:1
    - define item <player.item_in_hand>
    - if <script[fishing_packaging].data_key[data.stack_sizes.<[item].material.name>].exists>:
      - define quantity <script[fishing_packaging].data_key[data.stack_sizes.<[item].material.name>]>
      - if <player.inventory.contains_item[<[item].script.name>].quantity[<[quantity]>]>:
        - take item:<[item].script.name> quantity:<[quantity]>
        - give item:fishing_<[item].material.name>_bundle

fishing_hook_iron:
  type: item
  debug: false
  material: aquaculture_iron_hook
  display name: <&7>Iron Hook
  lore:
    - "<&6>Fishing: <&b>1"
    - <&e>String up an Iron Hook
    - <&e>This Hook catches <&b>Cod
  flags:
    run_script: fishing_set_hook
    hook: iron_hook
  mechanisms:
    hides: all

fishing_hook_gold:
  type: item
  debug: false
  material: aquaculture_gold_hook
  display name: <&7>Gold Hook
  lore:
    - "<&6>Fishing: <&b>100"
    - <&e>String up an Gold Hook
    - <&e>This Hook catches <&b>Salmon
  flags:
    run_script: fishing_set_hook
    hook: gold_hook
  mechanisms:
    hides: all

fishing_hook_diamond:
  type: item
  debug: false
  material: aquaculture_diamond_hook
  display name: <&7>Diamond Hook
  lore:
    - "<&6>Fishing: <&b>200"
    - <&e>String up an Diamond Hook
    - <&e>This Hook catches <&b>Ink Sacs
  flags:
    run_script: fishing_set_hook
    hook: diamond_hook
  mechanisms:
    hides: all

fishing_hook_light:
  type: item
  debug: false
  material: aquaculture_light_hook
  display name: <&7>Light Hook
  lore:
    - "<&6>Fishing: <&b>300"
    - <&e>String up an Light Hook
    - <&e>This Hook catches <&b>Bones
  flags:
    run_script: fishing_set_hook
    hook: light_hook
  mechanisms:
    hides: all

fishing_hook_heavy:
  type: item
  debug: false
  material: aquaculture_heavy_hook
  display name: <&7>Heavy Hook
  lore:
    - "<&6>Fishing: <&b>400"
    - <&e>String up an Heavy Hook
    - <&e>This Hook catches <&b>Kelp
  flags:
    run_script: fishing_set_hook
    hook: heavy_hook
  mechanisms:
    hides: all

fishing_hook_redstone:
  type: item
  debug: false
  material: aquaculture_redstone_hook
  display name: <&7>Redstone Hook
  lore:
    - "<&6>Fishing: <&b>500"
    - <&e>String up an Redstone Hook
    - <&e>This Hook catches <&b>?????
  flags:
    run_script: fishing_set_hook
    hook: redstone_hook
  mechanisms:
    hides: all


fishing_rod_inventory:
  type: inventory
  debug: false
  inventory: chest
  title: <&7>Tacklebox
  slots:
    - [fishing_hook_iron] [fishing_hook_gold] [fishing_hook_diamond] [fishing_hook_light] [fishing_hook_heavy] [fishing_hook_redstone] [] [] []
  data:
    drag: cancel
    any_click: cancel

fishing_rod_open:
  type: task
  debug: false
  script:
    - inventory open d:fishing_rod_inventory

fishing_set_hook:
  type: task
  debug: false
  script:
    - define hook <context.item.flag[hook]>
    - define capability_needed <script[capabilities_data].data_key[capability.fishing.capability_for_hook.<[hook]>]>
    - if <player.flag[character.capabilities.fishing]||0> < <[capability_needed]>:
      - narrate "<&c>You lack the capability to use this hook."
      - narrate "<&e>Learn more Fishing, or choose another Hook."
      - determine cancelled
    - else:
      - narrate "<&e>You string up your rod with a <context.item.display>"
      - inventory flag slot:<player.held_item_slot> hook:<[hook]>