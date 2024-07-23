protect_world_entities_and_blocks:
  type: task
  debug: false
  script:
    - define chunks <server.flag[chunk_loading.corner1].to_cuboid[<server.flag[chunk_loading.corner2]>].chunks>
    - foreach <[chunks]> as:chunk:
      - foreach <[chunk].cuboid.blocks[*_fence_gate|*_trapdoor|cauldron|days_in_the_middle_ages*|anvil|magistuarmory_pavise|fantasyfurniture_decorations*|*_shulker_box|fantasyfurniture_*_lockbox|chest|*_chest|*_dresser|FANTASYFURNITURE_*WARDROBE_BOTTOM|FANTASYFURNITURE_*WARDROBE_TOP|FANTASYFURNITURE_*DRAWER|FANTASYFURNITURE_*DESK_LEFT|hopper]> as:block:
        - flag <[block]> on_right_click:cancel
      - wait 1t
      #- foreach <[chunk].entities[armor_stand|*tem_frame]> as:entity:
        #- flag <[entity]> right_click_script:cancel
        #- flag <[entity]> on_damaged:cancel
      - announce "<&e>Chunk <[chunk].x>,<[chunk].z> is protected."
      - wait 1t
