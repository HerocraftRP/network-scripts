placeable_recall_ward:
  type: item
  debug: false
  material: ars_nouveau_purple_sbed
  display name: <&d>Recall Ward
  flags:
    right_click_script: custom_placeable
    on_place: uncancel
  data:
    placed_material: ars_nouveau_purple_sbed
    can_place_on:
    - mossy_cobblestone
    - mossy_stone_bricks
    - stone_bricks
    - dirt_path
    - cracked_stone_bricks
    - cobblestone
    - gravel
    - dead_brain_coral_block
    - dark_prismarine
    - prismarine
    persist_between_storms: false
    scripts:
        on_place:
          - give <item[ward_recall_scroll_item].with[raw_nbt=<script[ward_recall_scroll_item].parsed_key[data.raw_nbt.an_warp_scroll]>].with_flag[location:<[location]>]>
          - narrate "<&e>You retrieve the <item[ward_recall_scroll_item].display>."
          - run add_placeable_data def:<[location]>|tp_location|<[location].above[0.3].with_yaw[<player.location.yaw.add[180]>]>

ward_recall_scroll_item:
  type: item
  debug: false
  material: ars_nouveau_warp_scroll
  display name: <&6>Recall Scroll
  flags:
    right_click_script: placeable_recall_scroll_use
  data:
    raw_nbt:
      an_warp_scroll:
        yRot: float:<[location].pitch>
        x: int:<[location].x>
        xRot: float:<[location].yaw>
        y: int:<[location].y>
        dim: string:minecraft:overworld
        z: int:<[location].z>

placeable_recall_scroll_use:
  type: task
  debug: false
  definitions: location
  script:
    - determine passively cancelled
    - define location <context.item.flag[location]> if:<[location].exists.not>
    - if !<server.has_flag[custom_placeables.locations.<[location].simple>]>:
      - take iteminhand
      - narrate "<&c>The Recall Scroll disintegrates in your hand.<&nl><&e>The Recall Ward must have been broken..."
      - stop
    - define tp_location <[location].proc[get_placeable_data].context[tp_location]>
    - run start_timed_action "def:<&d>Recalling|8s|placeable_recall_scroll_use_callback|<[tp_location]>" def.distance_from_origin:2
    - take iteminhand
    - run clear_custom_placeable def:<[location]>
    - narrate "<&e>The scroll burns up in your hand, destroying the linked ward."

placeable_recall_scroll_use_callback:
  type: task
  debug: false
  definitions: location
  script:
    - teleport <[location]>
    - narrate "<&d>Returned to Recall Ward."