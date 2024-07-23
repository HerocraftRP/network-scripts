lumberjack_wooden_axe:
  type: item
  debug: false
  material: wooden_axe
  display name: <&7>Wooden Axe
  lore:
    - <&e>Can chop wood, and foes!
    - <&6>Weapon Type<&co> <&e><script.data_key[flags.weapon_type].to_titlecase>
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: woodwork
    material: oak_planks
    type: weapon
  flags:
    display: <&7>Wooden Axe
    weapon_type: axe
    capability_needed: 0

lumberjack_stone_axe:
  type: item
  debug: false
  material: stone_axe
  display name: <&7>Stone Axe
  lore:
    - <&e>Can chop wood, and foes!
    - <&6>Weapon Type<&co> <&e><script.data_key[flags.weapon_type].to_titlecase>
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: blacksmith
    material: stone
    type: weapon
  flags:
    display: <&7>Stone Axe
    weapon_type: axe
    capability_needed: 100

lumberjack_iron_axe:
  type: item
  debug: false
  material: iron_axe
  display name: <&7>Iron Axe
  lore:
    - <&e>Can chop wood, and foes!
    - <&6>Weapon Type<&co> <&e><script.data_key[flags.weapon_type].to_titlecase>
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: blacksmith
    material: iron
    type: weapon
  flags:
    display: <&7>Iron Axe
    weapon_type: axe
    capability_needed: 200

lumberjack_gold_axe:
  type: item
  debug: false
  material: golden_axe
  display name: <&7>Gold Axe
  lore:
    - <&e>Can chop wood, and foes!
    - <&6>Weapon Type<&co> <&e><script.data_key[flags.weapon_type].to_titlecase>
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: blacksmith
    material: gold
    type: weapon
  flags:
    display: <&7>Gold Axe
    weapon_type: axe
    capability_needed: 300

lumberjack_diamond_axe:
  type: item
  debug: false
  material: diamond_axe
  display name: <&7>Diamond Axe
  lore:
    - <&e>Can chop wood, and foes!
    - <&6>Weapon Type<&co> <&e><script.data_key[flags.weapon_type].to_titlecase>
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: blacksmith
    material: diamond
    type: weapon
  flags:
    display: <&7>Diamond Axe
    weapon_type: axe
    capability_needed: 400

lumberjack_netherite_axe:
  type: item
  debug: false
  material: netherite_axe
  display name: <&7>Netherite Axe
  lore:
    - <&e>Can chop wood, and foes!
    - <&6>Weapon Type<&co> <&e><script.data_key[flags.weapon_type].to_titlecase>
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: blacksmith
    material: netherite
    type: weapon
  flags:
    display: <&7>Netherite Axe
    weapon_type: axe
    capability_needed: 500

lumberjack_oak_wood:
  type: item
  debug: false
  material: oak_wood
  display name: <&6>Oak Wood
  lore:
    - <&e>Can be Split at a Logging Site

lumberjack_birch_wood:
  type: item
  debug: false
  material: birch_wood
  display name: <&6>Birch Wood
  lore:
    - <&e>Can be Split at a Logging Site

lumberjack_spruce_wood:
  type: item
  debug: false
  material: spruce_wood
  display name: <&6>Spruce Wood
  lore:
    - <&e>Can be Split at a Logging Site

lumberjack_jungle_wood:
  type: item
  debug: false
  material: jungle_wood
  display name: <&6>Jungle Wood
  lore:
    - <&e>Can be Split at a Logging Site

lumberjack_acacia_wood:
  type: item
  debug: false
  material: acacia_wood
  display name: <&6>Acacia Wood
  lore:
    - <&e>Can be Split at a Logging Site

lumberjack_dark_oak_wood:
  type: item
  debug: false
  material: herocraft_bundle
  display name: <&6>Dark Oak Wood
  lore:
    - <&e>Can be Split at a Logging Site

lumberjack_oak_planks_bundle:
  type: item
  debug: false
  material: herocraft_bundle
  display name: <&6>Bundle of Oak Planks
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


lumberjack_birch_planks_bundle:
  type: item
  debug: false
  material: herocraft_bundle
  display name: <&6>Bundle of Birch Planks
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


lumberjack_spruce_planks_bundle:
  type: item
  debug: false
  material: herocraft_bundle
  display name: <&6>Bundle of Spruce Planks
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


lumberjack_jungle_planks_bundle:
  type: item
  debug: false
  material: herocraft_bundle
  display name: <&6>Bundle of Jungle Planks
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


lumberjack_acacia_planks_bundle:
  type: item
  debug: false
  material: herocraft_bundle
  display name: <&6>Bundle of Acacia Planks
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


lumberjack_dark_oak_planks_bundle:
  type: item
  debug: false
  material: herocraft_bundle
  display name: <&6>Bundle of Dark Oak Planks
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


lumberjack_crimson_planks_bundle:
  type: item
  debug: false
  material: herocraft_bundle
  display name: <&6>Bundle of Crimson Planks
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


lumberjack_warped_planks_bundle:
  type: item
  debug: false
  material: herocraft_bundle
  display name: <&6>Bundle of Warped Planks
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


lumberjack_oak_planks:
  type: item
  material: oak_planks
  display name: <&6>Oak Planks
  flags:
    interaction:
      1:
        script: lumberjack_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

lumberjack_birch_planks:
  type: item
  material: birch_planks
  display name: <&6>Birch Planks
  flags:
    interaction:
      1:
        script: lumberjack_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

lumberjack_spruce_planks:
  type: item
  material: spruce_planks
  display name: <&6>Spruce Planks
  flags:
    interaction:
      1:
        script: lumberjack_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

lumberjack_jungle_planks:
  type: item
  material: jungle_planks
  display name: <&6>Jungle Planks
  flags:
    interaction:
      1:
        script: lumberjack_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

lumberjack_acacia_planks:
  type: item
  material: acacia_planks
  display name: <&6>Acacia Planks
  flags:
    interaction:
      1:
        script: lumberjack_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

lumberjack_dark_oak_planks:
  type: item
  material: dark_oak_planks
  display name: <&6>Dark Oak Planks
  flags:
    interaction:
      1:
        script: lumberjack_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"