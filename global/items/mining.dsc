mining_wooden_pickaxe:
  type: item
  debug: false
  material: wooden_pickaxe
  display name: <&7>Wooden Pickaxe
  lore:
    - <&e>Can mine, but is not a great weapon.
    - <&6>Weapon Type<&co> <&e><script.data_key[flags.weapon_type].to_titlecase>
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: woodwork
    material: oak_planks
    type: tool
    tool_tier: 0
  flags:
    display: <&7>Wooden Pickaxe
    weapon_type: axe
    capability_needed: 0

mining_stone_pickaxe:
  type: item
  debug: false
  material: stone_pickaxe
  display name: <&7>Stone Pickaxe
  lore:
    - <&e>Can mine, but is not a great weapon.
    - <&6>Weapon Type<&co> <&e><script.data_key[flags.weapon_type].to_titlecase>
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: blacksmith
    material: stone
    type: tool
    tool_tier: 1
  flags:
    display: <&7>Stone Pickaxe
    weapon_type: axe
    capability_needed: 100

mining_iron_pickaxe:
  type: item
  debug: false
  material: iron_pickaxe
  display name: <&7>Iron Pickaxe
  lore:
    - <&e>Can mine, but is not a great weapon.
    - <&6>Weapon Type<&co> <&e><script.data_key[flags.weapon_type].to_titlecase>
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: blacksmith
    material: iron
    type: tool
    tool_tier: 2
  flags:
    display: <&7>Stone Pickaxe
    weapon_type: axe
    capability_needed: 200

mining_golden_pickaxe:
  type: item
  debug: false
  material: golden_pickaxe
  display name: <&7>Golden Pickaxe
  lore:
    - <&e>Can mine, but is not a great weapon.
    - <&6>Weapon Type<&co> <&e><script.data_key[flags.weapon_type].to_titlecase>
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: blacksmith
    material: gold
    type: tool
    tool_tier: 3
  flags:
    display: <&7>Stone Pickaxe
    weapon_type: axe
    capability_needed: 300

mining_diamond_pickaxe:
  type: item
  debug: false
  material: diamond_pickaxe
  display name: <&7>Diamond Pickaxe
  lore:
    - <&e>Can mine, but is not a great weapon.
    - <&6>Weapon Type<&co> <&e><script.data_key[flags.weapon_type].to_titlecase>
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: blacksmith
    material: diamond
    type: tool
    tool_tier: 4
  flags:
    display: <&7>Diamond Pickaxe
    weapon_type: axe
    capability_needed: 400

mining_netherite_pickaxe:
  type: item
  debug: false
  material: netherite_pickaxe
  display name: <&7>Netherite Pickaxe
  lore:
    - <&e>Can mine, but is not a great weapon.
    - <&6>Weapon Type<&co> <&e><script.data_key[flags.weapon_type].to_titlecase>
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: blacksmith
    material: netherite
    type: tool
    tool_tier: 5
  flags:
    display: <&7>Netherite Pickaxe
    weapon_type: axe
    capability_needed: 500

mining_stone_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Stone
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

mining_iron_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Iron Nuggets
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

mining_gold_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Gold Nuggets
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

mining_diamond_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Diamonds
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

mining_netherite_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Netherite Scrap
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

mining_create_copper_nugget_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Copper Nugget
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

mining_iron_nugget_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Iron Nugget
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

mining_epicsamurai_silver_nugget_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Silver Nugget
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

mining_epicsamurai_steel_nugget_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Steel Nugget
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

mining_stone:
  type: item
  material: stone
  display name: <&6>Stone
  flags:
    interaction:
      1:
        script: mining_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

mining_create_copper_nugget:
  type: item
  material: create_copper_nugget
  display name: <&6>Copper Nugget
  flags:
    interaction:
      1:
        script: mining_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

mining_iron_nugget:
  type: item
  material: iron_nugget
  display name: <&6>Iron Nugget
  flags:
    interaction:
      1:
        script: mining_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

mining_gold_nugget:
  type: item
  material: gold_nugget
  display name: <&6>Gold Nugget
  flags:
    interaction:
      1:
        script: mining_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

mining_diamond:
  type: item
  material: diamond
  display name: <&6>Diamond
  flags:
    interaction:
      1:
        script: mining_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

mining_netherite_scrap:
  type: item
  material: netherite_scrap
  display name: <&6>Netherite Scrap
  flags:
    interaction:
      1:
        script: mining_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

mining_silver_nugget:
  type: item
  material: epicsamurai_silver_nugget
  display name: <&6>Silver Nugget
  flags:
    interaction:
      1:
        script: mining_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

mining_steel_nugget:
  type: item
  material: epicsamurai_steel_nugget
  display name: <&6>Steel Nugget
  flags:
    interaction:
      1:
        script: mining_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

