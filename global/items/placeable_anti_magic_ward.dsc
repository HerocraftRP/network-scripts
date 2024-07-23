placeable_anti_magic_ward:
  type: item
  debug: false
  material: ars_nouveau_imbuement_chamber
  display name: <&d>Anti-Magic Ward
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
    persist_between_storms: true
    scripts:
        on_place:
          - ~run initiate_anti_magic_ward def:<[location]>|20 save:as
          - flag <[location]> anti_magic_ward.number:<entry[as].created_queue.determination>
        on_break:
          - ~run initiate_anti_magic_ward_clear def:<[location].flag[anti_magic_ward.number]>
          - flag <[location]> anti_magic_ward.number:!