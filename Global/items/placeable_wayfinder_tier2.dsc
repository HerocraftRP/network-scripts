placeable_wayfinder_tier2:
  type: item
  debug: false
  material: waystones_portstone
  display name: <&d>Portstone
  flags:
    right_click_script: custom_placeable
  data:
    tick_timer: 30m
    placed_material: waystones_portstone
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
          - run add_placeable_data def:<[location]>|tp_location|<[location].center.with_yaw[<player.location.yaw.sub[-180]>].forward_flat>
        interact:
          - define owner <server.flag[custom_placeables.locations.<context.location.flag[placed_block].simple>.placed_by]>
          - if <[owner]> != <player.flag[data.name]>:
            - narrate "<&c>This portstone does not respond to you."
            - stop
          - give <item[ward_recall_scroll_item2].with[raw_nbt=<script[ward_recall_scroll_item2].parsed_key[data.raw_nbt]>].with_flag[location:<context.location.flag[placed_block]>]>
          - narrate "<&e>You retrieve a <item[ward_recall_scroll_item].display>."


ward_recall_scroll_item2:
  type: item
  debug: false
  material: ars_nouveau_warp_scroll
  display name: <&6>Recall Scroll
  flags:
    right_click_script: placeable_recall_scroll_use2
  data:
    raw_nbt:
      unique: string:<util.random_uuid>
      an_warp_scroll:
        yRot: float:<[location].pitch>
        x: int:<[location].x>
        xRot: float:<[location].yaw>
        y: int:<[location].y>
        dim: string:minecraft:overworld
        z: int:<[location].z>


placeable_recall_scroll_use2:
  type: task
  debug: false
  definitions: location
  script:
    - determine passively cancelled
    - define location <context.item.flag[location]> if:<[location].exists.not>
    - if !<server.has_flag[custom_placeables.locations.<[location].simple>]>:
      - take iteminhand
      - narrate "<&c>The Recall Scroll disintegrates in your hand.<&nl><&e>The recall point must have been destroyed..."
      - stop
    - define tp_location <[location].proc[get_placeable_data].context[tp_location]>
    - run start_timed_action "def:<&d>Recalling|8s|placeable_recall_scroll_use_callback2|<[tp_location]>" def.distance_from_origin:2
    - take iteminhand
    - narrate "<&e>The scroll burns up in your hand, hold still."

placeable_recall_scroll_use_callback2:
  type: task
  debug: false
  definitions: location
  script:
    - teleport <player> <[location]>
    - narrate "<&d>Returned to Recall Ward."