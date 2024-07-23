blacksmith_stone_sheet:
  type: item
  debug: false
  material: create_sturdy_sheet
  display name: <&7>Stone Sheet
  data:
    production_capability: blacksmith
    material: stone
    type: ingredient
  lore:
    - <&e>Used by Blacksmiths

blacksmith_stone_sword:
  type: item
  debug: false
  material: stone_sword
  display name: <&7>Stone Sword
  data:
    production_capability: blacksmith
    material: stone
    type: weapon
  flags:
    display: <&7>Stone Sword
    weapon_type: sword
    capability_needed: 100

blacksmith_stone_greatsword:
  type: item
  debug: false
  material: epicfight_stone_greatsword
  display name: <&7>Stone Greatsword
  data:
    production_capability: blacksmith
    material: stone
    type: weapon
  flags:
    display: <&7>Stone Greatsword
    weapon_type: sword
    capability_needed: 100

blacksmith_stone_spear:
  type: item
  debug: false
  material: epicfight_stone_spear
  display name: <&7>Stone Spear
  data:
    production_capability: blacksmith
    material: stone
    type: weapon
  flags:
    display: <&7>Stone Spear
    weapon_type: spear
    capability_needed: 100

blacksmith_stone_roundshield:
  type: item
  debug: false
  material: MAGISTUARMORY_STONE_ROUNDSHIELD
  display name: <&7>Stone Roundshield
  data:
    production_capability: blacksmith
    material: stone
    type: shield
  flags:
    display: <&7>Stone Roundshield

blacksmith_stone_kiteshield:
  type: item
  debug: false
  material: MAGISTUARMORY_STONE_KITESHIELD
  display name: <&7>Stone Kiteshield
  data:
    production_capability: blacksmith
    material: stone
    type: shield
  flags:
    display: <&7>Stone Kiteshield

## LEGACY ITEMS BELOW

blacksmith_magistuarmory_stone_stylet:
  type: item
  debug: false
  material: magistuarmory_stone_stylet
  display name: <&7>Stone Stylet
  data:
    material: stone
    type: weapon
  lore:
    - <&6>Damage: <&e><script.data_key[flags.weapon_damage]>
    - <&6>Attack Speed: <&e>Average
  flags:
    display: <&7>Stone Stylet
    weapon_type: melee
    capability_needed: 100

blacksmith_magistuarmory_stone_shortsword:
  type: item
  debug: false
  material: magistuarmory_stone_shortsword
  display name: <&7>Stone Shortsword
  data:
    material: stone
    type: weapon
  lore:
    - <&6>Damage: <&e><script.data_key[flags.weapon_damage]>
    - <&6>Attack Speed: <&e>Average
  flags:
    display: <&7>Stone Shortsword
    weapon_type: melee
    weapon_damage: 2
    capability_needed: 100
  mechanisms:
    HIDES: all

blacksmith_magistuarmory_stone_katzbalger:
  type: item
  debug: false
  material: magistuarmory_stone_katzbalger
  display name: <&7>Stone Katzbalger
  data:
    material: stone
    type: weapon
  lore:
    - <&6>Damage: <&e><script.data_key[flags.weapon_damage]>
    - <&6>Attack Speed: <&e>Slow
  flags:
    display: <&7>Stone Katzbalger
    weapon_type: melee
    weapon_damage: 3
    capability_needed: 100
  mechanisms:
    HIDES: all

blacksmith_epicfight_stone_spear:
  type: item
  debug: false
  material: epicfight_stone_spear
  display name: <&7>Stone Spear
  data:
    material: stone
    type: weapon
  lore:
    - <&6>Damage: <&e><script.data_key[flags.weapon_damage]>
    - <&6>Attack Speed: <&e>Average
  flags:
    display: <&7>Stone Spear
    weapon_type: melee
    weapon_damage: 3
    capability_needed: 100
  mechanisms:
    HIDES: all

blacksmith_magistuarmory_stone_ahlspiess:
  type: item
  debug: false
  material: magistuarmory_stone_ahlspiess
  display name: <&7>Stone Ahlspiess
  data:
    material: stone
    type: weapon
  lore:
    - <&6>Damage: <&e><script.data_key[flags.weapon_damage]>
    - <&6>Attack Speed: <&e>Slow
  flags:
    display: <&7>Stone Ahlspiess
    weapon_type: melee
    weapon_damage: 3
    capability_needed: 100
  mechanisms:
    HIDES: all

## Scheduled for Removal
blacksmith_magistuarmory_stone_estoc:
  type: item
  debug: false
  material: magistuarmory_stone_estoc
  display name: <&7>Stone Estoc
  flags:
    display: <&7>Stone Estoc

blacksmith_magistuarmory_stone_bastardsword:
  type: item
  debug: false
  material: magistuarmory_stone_bastardsword
  display name: <&7>Stone Bastard Sword
  data:
    material: stone
    type: weapon
  lore:
    - <&6>Damage: <&e><script.data_key[flags.weapon_damage]>
    - <&6>Attack Speed: <&e>Slow
  flags:
    display: <&7>Stone Bastard Sword
    weapon_type: melee
    weapon_damage: 4
    capability_needed: 100
  mechanisms:
    HIDES: all

blacksmith_magistuarmory_stone_claymore:
  type: item
  debug: false
  material: magistuarmory_stone_claymore
  display name: <&7>Stone Claymore
  data:
    material: stone
    type: weapon
  lore:
    - <&6>Damage: <&e><script.data_key[flags.weapon_damage]>
    - <&6>Attack Speed: <&e>Slow
  flags:
    display: <&7>Stone Claymore
    weapon_type: melee
    weapon_damage: 4
    capability_needed: 100
  mechanisms:
    HIDES: all

blacksmith_magistuarmory_stone_zweihander:
  type: item
  debug: false
  material: magistuarmory_stone_zweihander
  display name: <&7>Stone Zweihander
  data:
    material: stone
    type: weapon
  lore:
    - <&6>Damage: <&e><script.data_key[flags.weapon_damage]>
    - <&6>Attack Speed: <&e>Slow
  flags:
    display: <&7>Stone Claymore
    weapon_type: melee
    weapon_damage: 4
    capability_needed: 100
  mechanisms:
    HIDES: all

blacksmith_magistuarmory_stone_lochaberaxe:
  type: item
  debug: false
  material: magistuarmory_stone_lochaberaxe
  display name: <&7>Stone Lochaberaxe
  data:
    material: stone
    type: weapon
  lore:
    - <&6>Damage: <&e><script.data_key[flags.weapon_damage]>
    - <&6>Attack Speed: <&e>Very Slow
  flags:
    display: <&7>Stone Lochaberaxe
    weapon_type: melee
    weapon_damage: 5
    capability_needed: 100
  mechanisms:
    HIDES: all

blacksmith_magistuarmory_stone_concavehalberd:
  type: item
  debug: false
  material: magistuarmory_stone_concavehalberd
  display name: <&7>Stone Concave Halberd
  data:
    material: stone
    type: weapon
  lore:
    - <&6>Damage: <&e><script.data_key[flags.weapon_damage]>
    - <&6>Attack Speed: <&e>Very Slow
  flags:
    display: <&7>Stone Concave Halberd
    weapon_type: melee
    weapon_damage: 5
    capability_needed: 100
  mechanisms:
    HIDES: all

blacksmith_magistuarmory_stone_heavymace:
  type: item
  debug: false
  material: magistuarmory_stone_heavymace
  display name: <&7>Stone Heavy Mace
  data:
    material: stone
    type: weapon
  lore:
    - <&6>Damage: <&e><script.data_key[flags.weapon_damage]>
    - <&6>Attack Speed: <&e>Average
  flags:
    display: <&7>Stone Heavy Mace
    weapon_type: melee
    weapon_damage: 3
    capability_needed: 100
  mechanisms:
    HIDES: all

blacksmith_magistuarmory_stone_heavywarhammer:
  type: item
  debug: false
  material: magistuarmory_stone_heavywarhammer
  display name: <&7>Stone Warhammer
  data:
    material: stone
    type: weapon
  lore:
    - <&6>Damage: <&e><script.data_key[flags.weapon_damage]>
    - <&6>Attack Speed: <&e>Average
  flags:
    display: <&7>Stone Warhammer
    weapon_type: melee
    weapon_damage: 3
    capability_needed: 100
  mechanisms:
    HIDES: all

blacksmith_magistuarmory_stone_lucernhammer:
  type: item
  debug: false
  material: magistuarmory_stone_lucernhammer
  display name: <&7>Stone Lucern Hammer
  data:
    material: stone
    type: weapon
  lore:
    - <&6>Damage: <&e><script.data_key[flags.weapon_damage]>
    - <&6>Attack Speed: <&e>Average
  flags:
    display: <&7>Stone Warhammer
    weapon_type: melee
    weapon_damage: 3
    capability_needed: 100
  mechanisms:
    HIDES: all

blacksmith_magistuarmory_stone_morgenstern:
  type: item
  debug: false
  material: magistuarmory_stone_morgenstern
  display name: <&7>Stone Morgenstern
  data:
    material: stone
    type: weapon
  lore:
    - <&6>Damage: <&e><script.data_key[flags.weapon_damage]>
    - <&6>Attack Speed: <&e>Average
  flags:
    display: <&7>Stone Morgenstern
    weapon_type: melee
    weapon_damage: 3
    capability_needed: 100
  mechanisms:
    HIDES: all

blacksmith_magistuarmory_stone_guisarme:
  type: item
  debug: false
  material: magistuarmory_stone_guisarme
  display name: <&7>Stone Guisarme
  data:
    material: stone
    type: weapon
  lore:
    - <&6>Damage: <&e><script.data_key[flags.weapon_damage]>
    - <&6>Attack Speed: <&e>Average
  flags:
    display: <&7>Stone Guisarme
    weapon_type: melee
    weapon_damage: 3
    capability_needed: 100
  mechanisms:
    HIDES: all

blacksmith_magistuarmory_stone_heatershield:
  type: item
  debug: false
  material: magistuarmory_stone_heatershield
  display name: <&7>Stone Heater Shield
  data:
    material: stone
    type: shield
  flags:
    display: <&7>Stone Heater Shield
    weapon_type: melee
    capability_needed: 100

blacksmith_magistuarmory_stone_target:
  type: item
  debug: false
  material: magistuarmory_stone_target
  display name: <&7>Stone Targe
  data:
    material: stone
    type: shield
  flags:
    display: <&7>Stone Targe
    weapon_type: melee
    capability_needed: 100

blacksmith_magistuarmory_stone_buckler:
  type: item
  debug: false
  material: magistuarmory_stone_buckler
  display name: <&7>Stone Buckler
  data:
    material: stone
    type: shield
  flags:
    display: <&7>Stone Buckler
    capability_needed: 100

blacksmith_magistuarmory_stone_rondache:
  type: item
  debug: false
  material: magistuarmory_stone_rondache
  display name: <&7>Stone Rondache
  data:
    material: stone
    type: shield
  flags:
    display: <&7>Stone Rondache
    capability_needed: 100

blacksmith_magistuarmory_stone_tartsche:
  type: item
  debug: false
  material: magistuarmory_stone_tartsche
  display name: <&7>Stone Tartsche
  data:
    material: stone
    type: shield
  flags:
    display: <&7>Stone Tartsche
    capability_needed: 100

blacksmith_magistuarmory_stone_ellipticalshield:
  type: item
  debug: false
  material: magistuarmory_stone_ellipticalshield
  display name: <&7>Stone Elliptical Shield
  data:
    material: stone
    type: shield
  flags:
    display: <&7>Stone Elliptical Shield
    capability_needed: 100

blacksmith_magistuarmory_stone_roundshield:
  type: item
  debug: false
  material: magistuarmory_stone_roundshield
  display name: <&7>Stone Round Shield
  data:
    material: stone
    type: shield
  flags:
    display: <&7>Stone Round Shield
    capability_needed: 100

blacksmith_magistuarmory_stone_pavese:
  type: item
  debug: false
  material: magistuarmory_stone_pavese
  display name: <&7>Stone Pavese
  data:
    material: stone
    type: shield
  flags:
    display: <&7>Stone Pavese
    capability_needed: 100

blacksmith_magistuarmory_stone_kiteshield:
  type: item
  debug: false
  material: magistuarmory_stone_kiteshield
  display name: <&7>Stone Kiteshield
  data:
    material: stone
    type: shield
  flags:
    display: <&7>Stone Kiteshield
    capability_needed: 100

blacksmith_stone_nails:
  type: item
  debug: false
  material: tripwire_hook
  display name: <&7>Stone Nails