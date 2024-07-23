schematic_item:
  type: item
  debug: false
  display name: <&7>Blank Schematic
  material: sewingkit_common_pattern
  flags:
    interaction:
      1:
        script: use_schematic
        display: <&6>Learn Schematic
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co> <&6>Learn Schematic
    - "<&7>___________________"
  mechanisms:
    hides: ALL


get_schematic:
  type: procedure
  debug: false
  definitions: item
  script:
    - define schematic <item[schematic_item]>
    - define capability <[item].script.data_key[data.production_capability]>
    - define material <[item].script.data_key[data.material]>
    - define type <[item].script.data_key[data.type]>
    - define capability_needed <server.flag[profession_data.capability_tables_invert.<[capability]>.<[material]>.<[item].script.name>]>
    - define schematic <[schematic].with_flag[item:<[item]>]>
    - define schematic <[schematic].with_flag[capability:<[capability]>]>
    - define schematic <[schematic].with_flag[capability_needed:<[capability_needed]>]>
    - define schematic "<[schematic].with[display=<&6>Schematic<&co> <&e><[item].display>]>"
    - define schematic "<[schematic].with[lore=<list[<&6>Item Type<&co> <&e><[type].to_titlecase>|<&6>Capability<&co> <&e><[capability].to_titlecase>|<&6>Required<&co> <&e><[capability_needed]>].include[<[schematic].lore>]>]>"
    - determine <[schematic]>

use_schematic:
  type: task
  debug: false
  script:
    - define schematic <player.item_in_hand.flag[item]>
    - define capability <player.item_in_hand.flag[capability]>
    - define capRequired <player.item_in_hand.flag[capability_needed]>
    - if <player.has_flag[character.schematics.<[capability]>.<[schematic]>]>:
      - narrate "<&c>You already know this schematic."
      - stop
    - if <player.flag[character.capabilities.<[capability]>]||0> < <[capRequired]>:
      - narrate "<&c>You lack the capability to understand this."
      - stop
    - run start_timed_action "def:<&6>Learning Schematic|10s|use_schematic_callback|<player.item_in_hand>" def.can_swap_items:false

use_schematic_callback:
  type: task
  debug: false
  definitions: schematic
  script:
    - if <player.item_in_hand> != <[schematic]>:
      - narrate "<&c>You are no longer holding the schematic."
      - stop
    - define capability <player.item_in_hand.flag[capability]>
    - define capRequired <player.item_in_hand.flag[capability_needed]>
    - take iteminhand
    - flag player character.schematics.<[capability]>.<[capRequired]>:<[schematic].flag[item].script.name>
    - narrate "<&e>You learned to create <&b><[schematic].flag[item].display><&e>!"