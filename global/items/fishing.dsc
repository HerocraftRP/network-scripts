fishing_wooden_rod:
  type: item
  debug: false
  display name: <&7>Wooden Fishing Rod
  material: fishing_rod
  data:
    production_capability: woodwork
    material: oak_planks
    type: tool
  flags:
    hook: iron_hook
    right_click_script: fishing_start
    capability_needed: 1
    interaction:
      1:
        script: fishing_rod_open
        display: <&b>Fishing<&co> <&6>Manage Rod
  lore:
    - <&e>Can utilize different hooks to catch fish
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
    - <&7>___________________
    - <empty>
    - <&a>Interaction 1<&co> <&b>Fishing<&co> <&6>Manage Rod
    - <&7>___________________

fishing_iron_rod:
  type: item
  debug: false
  display name: <&7>Iron Fishing Rod
  material: aquaculture_iron_fishing_rod
  data:
    production_capability: woodwork
    material: birch_planks
    type: tool
  flags:
    hook: iron_hook
    right_click_script: fishing_start
    capability_needed: 100
    interaction:
      1:
        script: fishing_rod_open
        display: <&b>Fishing<&co> <&6>Manage Rod
  lore:
    - <&e>Can utilize different hooks to catch fish
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
    - <&7>___________________
    - <empty>
    - <&a>Interaction 1<&co> <&b>Fishing<&co> <&6>Manage Rod
    - <&7>___________________
  mechanisms:
    custom_model_data: 1

fishing_golden_rod:
  type: item
  debug: false
  display name: <&7>Golden Fishing Rod
  material: aquaculture_golden_fishing_rod
  data:
    production_capability: woodwork
  flags:
    hook: iron_hook
    right_click_script: fishing_start
    capability_needed: 200
    interaction:
      1:
        script: fishing_rod_open
        display: <&b>Fishing<&co> <&6>Manage Rod
  lore:
    - <&e>Can utilize different hooks to catch fish
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
    - <&7>___________________
    - <empty>
    - <&a>Interaction 1<&co> <&b>Fishing<&co> <&6>Manage Rod
    - <&7>___________________
  mechanisms:
    custom_model_data: 2

fishing_diamond_rod:
  type: item
  debug: false
  display name: <&7>Diamond Fishing Rod
  material: aquaculture_diamond_fishing_rod
  data:
    production_capability: woodwork
  flags:
    hook: iron_hook
    right_click_script: fishing_start
    capability_needed: 300
    interaction:
      1:
        script: fishing_rod_open
        display: <&b>Fishing<&co> <&6>Manage Rod
  lore:
    - <&e>Can utilize different hooks to catch fish
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
    - <&7>___________________
    - <empty>
    - <&a>Interaction 1<&co> <&b>Fishing<&co> <&6>Manage Rod
    - <&7>___________________
  mechanisms:
    custom_model_data: 3

fishing_neptunium_rod:
  type: item
  debug: false
  display name: <&7>Neptunium Fishing Rod
  material: aquaculture_neptunium_fishing_rod
  data:
    production_capability: woodwork
  flags:
    hook: iron_hook
    right_click_script: fishing_start
    capability_needed: 400
    interaction:
      1:
        script: fishing_rod_open
        display: <&b>Fishing<&co> <&6>Manage Rod
  lore:
    - <&e>Can utilize different hooks to catch fish
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
    - <&7>___________________
    - <empty>
    - <&a>Interaction 1<&co> <&b>Fishing<&co> <&6>Manage Rod
    - <&7>___________________
  mechanisms:
    custom_model_data: 4

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