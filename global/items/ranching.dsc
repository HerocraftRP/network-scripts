ranching_wooden_knife:
  type: item
  debug: false
  material: aquaculture_wooden_fillet_knife
  display name: <&7>Wooden Butcher Knife
  lore:
    - <&e>Can slaughter Animals, but is not a great weapon.
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: woodwork
    material: oak_planks
    type: tool
    tool_tier: 0
  flags:
    display: <&7>Wooden Butcher Knife
    capability_needed: 0

ranching_stone_knife:
  type: item
  debug: false
  material: aquaculture_stone_fillet_knife
  display name: <&7>Stone Butchering Knife
  lore:
    - <&e>Can slaughter Animals, but is not a great weapon.
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: blacksmith
    material: stone
    type: tool
    tool_tier: 1
  flags:
    display: <&7>Stone Butchering Knife
    capability_needed: 100

ranching_iron_knife:
  type: item
  debug: false
  material: aquaculture_stone_fillet_knife
  display name: <&7>Iron Butchering Knife
  lore:
    - <&e>Can slaughter Animals, but is not a great weapon.
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: blacksmith
    material: iron
    tool_tier: 2
  flags:
    display: <&7>Iron Butchering Knife
    capability_needed: 200

ranching_golden_knife:
  type: item
  debug: false
  material: aquaculture_gold_fillet_knife
  display name: <&7>Golden Butchering Knife
  lore:
    - <&e>Can slaughter Animals, but is not a great weapon.
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: blacksmith
    material: golden
    type: tool
    tool_tier: 3
  flags:
    display: <&7>Golden Butchering Knife
    capability_needed: 300

ranching_diamond_knife:
  type: item
  debug: false
  material: aquaculture_diamond_fillet_knife
  display name: <&7>Diamond Butchering Knife
  lore:
    - <&e>Can slaughter Animals, but is not a great weapon.
    - <&6>Capability Needed<&co> <&e><script.data_key[flags.capability_needed]>
  data:
    production_capability: blacksmith
    material: golden
    type: tool
    tool_tier: 4
  flags:
    display: <&7>Diamond Butchering Knife
    capability_needed: 400

ranching_shears:
  type: item
  debug: false
  material: shears
  display name: <&7>Shears
  lore:
    - <&e>Can remove wool from sheep.
    - <&6>Capability Needed<&co> <&e><script.parsed_key[flags.capability_needed]>
  data:
    production_capability: blacksmith
    material: iron
    type: tool
    tool_tier: 0
  flags:
    display: <&7>Shears
    capability_needed: <script[capabilities_data].data_key[capability.ranching.sheep.ranching_shears.capability_needed]>

ranching_bucket:
  type: item
  debug: false
  material: bucket
  display name: <&7>Bucket
  lore:
    - <&e>Can hold milk from cows.
    - <&6>Capability Needed<&co> <&e><script.parsed_key[flags.capability_needed]>
  data:
    production_capability: blacksmith
    material: iron
    type: tool
    tool_tier: 0
  flags:
    display: <&7>Shears
    capability_needed: <script[capabilities_data].data_key[capability.ranching.cow.ranching_bucket.capability_needed]>