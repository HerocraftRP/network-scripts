placeable_containment_ward:
  type: item
  debug: false
  material: ars_nouveau_imbuement_chamber
  display name: <&d>Containment Ward
  flags:
    right_click_script: custom_placeable
  data:
    tick_timer: 30m
    placed_material: ars_nouveau_imbuement_chamber
    can_place_on:
    - dirt
    - grass_block
    - cobblestone
    - gravel
    - dead_bubble_coral_block
    - dead_brain_coral
    - andesite
    - mossy_cobblestone
    - polished_andesite
    - stone_bricks
    - mossy_stone_bricks
    - cracked_stone_bricks
    - cracked_mossy_stone_bricks
    - spruce_planks
    - stripped_dark_oak_wood
    persist_between_storms: true
    scripts:
        on_place:
          - ~run initiate_containment_ward def:<[location]>|20 save:as
          - flag <[location]> containment_ward.number:<entry[as].created_queue.determination>
        on_break:
          - ~run initiate_containment_clear def:<[location].flag[containment_ward.number]>
          - flag <[location]> containment_ward.number:!