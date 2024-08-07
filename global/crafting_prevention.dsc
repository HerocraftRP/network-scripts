nuke_crafting_recipes:
  type: task
  debug: false
  data:
    farmers_delight:
      blacklist:
        farmersdelight_skillet: true
        farmersdelight_cooking_pot: true
        farmersdelight_stove: true
        farmersdelight_cutting_board: true
        farmersdelight_basket: true
        farmersdelight_carrot_crate: true
        farmersdelight_potato_crate: true
        farmersdelight_beetroot_crate: true
        farmersdelight_cabbage_crate: true
        farmersdelight_tomato_crate: true
        farmersdelight_onion_crate: true
        minecraft_hay_block: true
        farmersdelight_rice_bale: true
        farmersdelight_straw_bale: true
        farmersdelight_safety_net: true
        farmersdelight_oak_cabinet: true
        farmersdelight_spruce_cabinet: true
        farmersdelight_birch_cabinet: true
        farmersdelight_jungle_cabinet: true
        farmersdelight_acacia_cabinet: true
        farmersdelight_dark_oak_cabinet: true
        farmersdelight_crimson_cabinet: true
        farmersdelight_warped_cabinet: true
        farmersdelight_tatami_block_from_full: true
        farmersdelight_full_tatami_mat: true
        farmersdelight_half_tatami_mat: true
        farmersdelight_canvas_rug: true
        farmersdelight_canvas_sign: true
        farmersdelight_organic_compost_from_tree_bark: true
        farmersdelight_rope: true
        farmersdelight_flint_knife: true
        farmersdelight_iron_knife: true
        farmersdelight_diamond_knife: true
        farmersdelight_netherite_knife_smithing: true
        farmersdelight_golden_knife: true
  script:
    - foreach <server.recipe_ids> as:recipe:
      - if <[recipe].starts_With[farmersdelight]>:
        - if <script.data_key[data.farmers_delight.blacklist.<[recipe].replace[<&co>].with[_]>].exists>:
          - adjust server remove_recipes:<[recipe]>
      - else:
        - adjust server remove_recipes:<[recipe]>

bullshit_fix:
  type: world
  debug: false
  events:
    on pre script reload:
    - foreach <server.recipe_ids> as:recipe:
      - if <[recipe].starts_With[denizen]>:
        - adjust server remove_recipes:<[recipe]>