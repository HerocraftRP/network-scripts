cooking_stone_knife:
  type: item
  debug: false
  material: farmersdelight_flint_knife
  display name: <&7>Stone Cooking Knife
  lore:
    - <&e>Can slice food, but is not a great weapon.
  data:
    production_capability: blacksmith
    material: stone
    type: tool
    tool_tier: 0
  flags:
    display: <&7>Stone Cooking Knife

cooking_iron_knife:
  type: item
  debug: false
  material: farmersdelight_iron_knife
  display name: <&7>Iron Cooking Knife
  lore:
    - <&e>Can slice food, but is not a great weapon.
  data:
    production_capability: blacksmith
    material: iron
    type: tool
    tool_tier: 1
  flags:
    display: <&7>Iron Cooking Knife

cooking_golden_knife:
  type: item
  debug: false
  material: farmersdelight_golden_knife
  display name: <&7>Golden Cooking Knife
  lore:
    - <&e>Can slice food, but is not a great weapon.
  data:
    production_capability: blacksmith
    material: golden
    type: tool
    tool_tier: 2
  flags:
    display: <&7>Golden Cooking Knife

cooking_diamond_knife:
  type: item
  debug: false
  material: farmersdelight_diamond_knife
  display name: <&7>Diamond Cooking Knife
  lore:
    - <&e>Can slice food, but is not a great weapon.
  data:
    production_capability: blacksmith
    material: diamond
    type: tool
    tool_tier: 3
  flags:
    display: <&7>Diamond Cooking Knife

cooking_netherite_knife:
  type: item
  debug: false
  material: farmersdelight_netherite_knife
  display name: <&7>Netherite Cooking Knife
  lore:
    - <&e>Can slice food, but is not a great weapon.
  data:
    production_capability: blacksmith
    material: netherite
    type: tool
    tool_tier: 4
  flags:
    display: <&7>Netherite Cooking Knife

cooking_free_slop_item:
  type: item
  debug: false
  material: suspicious_stew
  display name: <&6>Sewer Slop
  lore:
    - <&e>You're really gunna eat this?
  flags:
    on_consume: cooking_free_slop_eaten

cooking_free_slop_eaten:
  type: task
  debug: false
  script:
    - cast confusion hide_particles
    - adjust <player> thirst:10
    - adjust <player> food_level:10