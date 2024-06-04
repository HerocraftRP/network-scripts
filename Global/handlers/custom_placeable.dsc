placeable_template:
  type: item
  debug: false
  material: oak_log
  flags:
    right_click_script: custom_placeable
  data:
    tick_timer: 1m
    placed_material: oak_log
    can_place_on:
    - mossy_cobblestone
    - mossy_stone_bricks
    - stone_bricks
    - cracked_stone_bricks
    - cobblestone
    - gravel
    - dead_brain_coral_block
    - dark_prismarine
    - prismarine
    persist_between_storms: false
    # In scripts you can set data by running:
    ## - run add_placeable_data def:<[location]>|(variable_name)|(variable_value)

    # You can retrieve the data by using the tag:
    ## <[location].proc[get_placeable_data].context[(variable_name)]>

    # There is a functional example included in this template below
    scripts:
        # Called when it's placed
        on_place:
          - narrate "<&6>Placed!"
        # Called when it's broken by a Player
        on_break:
          - narrate "<&c>Broken!"
        # When right clicked, check "on player right clicks block" for available context
        # https://meta.denizenscript.com/Docs/Events/clicks%20block
        # preferably use <[location]> instead of <context.location>
        interact:
        - if <[location].proc[get_placeable_data].context[has_been_clicked]>:
          - narrate "<&e>This has been clicked before!"
          - narrate "<&c>Removing this block."
          - run clear_custom_placeable def:<[location]>
        - else:
          - run add_placeable_data def:<[location]>|has_been_clicked|true
          - narrate "<&e>You are the first to click this block!"

        # Called when it's time to tick the placeable
        # Only has <[location]> available for definitions
        tick:
        - run clear_custom_placeable def:<[location]>

custom_placeable:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - define item_script <context.item.script>
    - define location <context.relative>
    # Make the placeable be placed on the top of the block
    - if <context.relative.sub[<context.location>].y> != 1:
      - narrate "<&c>I have to place it on top..."
      - stop
    # Make sure the intended location is air
    - if <[location].material.name> != air:
      - narrate "<&c>I don't have enough room to place it here."
      - stop
    # Check the item script for what blocks it can be placed on
    - if !<[item_script].data_key[data.can_place_on].contains[<context.location.material.name>]>:
      - narrate "<&c>I'm not able to place this here."
      - stop
    - ratelimit <[location].simple> 1t
    - modifyblock <[location]> <[item_script].data_key[data.placed_material]> no_physics
    # Build the placeable, and data structure
    - define uuid <util.random_uuid>
    - flag server custom_placeables.locations.<[location].simple>.time_placed:<util.time_now>
    - flag server custom_placeables.locations.<[location].simple>.last_tick:<util.time_now>
    - flag server custom_placeables.locations.<[location].simple>.storm:<server.flag[shutdown_counter]>
    - flag server custom_placeables.locations.<[location].simple>.script:<context.item.script.name>
    - flag server custom_placeables.locations.<[location].simple>.uuid:<[uuid]>
    - flag server custom_placeables.locations.<[location].simple>.placed_by:<player.flag[data.name]>
    - run add_framework_flag def:on_right_click|custom_placeable_destroy|<[location]>
    - run add_framework_flag def:on_right_click|custom_placeable_interact|<[location]>
    - if <[item_script].data_key[data.scripts.on_place].exists>:
      - inject <script[<context.item.script.name>]> path:data.scripts.on_place
    # Finished building, take the item and schedule the next time it ticks
    - take iteminhand quantity:1
    - if <[item_script].data_key[data.scripts.tick].exists>:
      - runlater custom_placeable_tick def:<[location]>|<[uuid]> delay:<[item_script].data_key[data.tick_timer]>

add_placeable_data:
  type: task
  debug: false
  definitions: location|key|value
  script:
    - if <server.has_flag[custom_placeables.locations.<[location].simple>]>:
      - flag server custom_placeables.locations.<[location].simple>.data.<[key]>:<[value]>
    - else:
      - run clear_custom_placeable def:<[location]>

get_placeable_data:
  type: procedure
  debug: false
  definitions: location|key
  script:
    - if <server.has_flag[custom_placeables.locations.<[location].simple>.data.<[key]>]>:
      - determine <server.flag[custom_placeables.locations.<[location].simple>.data.<[key]>]>
    - else:
      - determine false

custom_placeable_destroy:
  type: task
  debug: false
  definitions: location
  script:
    - determine passively cancelled
    - if <player.is_sneaking>:
      - define location <context.location> if:<[location].exists.not>
      - if <server.has_flag[custom_placeables.locations.<[location].simple>]>:
        - define display <item[<server.flag[custom_placeables.locations.<[location].simple>.script]>].display>
        - run start_timed_action "def:<&c>Destroying <[Display]>|10s|custom_placeable_destroy_callback|<[location]>" def.distance_from_origin:1
        - stop

custom_placeable_destroy_callback:
  type: task
  debug: false
  definitions: location
  script:
    - if <server.has_flag[custom_placeables.locations.<[location].simple>.script]>:
      - define item_script <server.flag[custom_placeables.locations.<[location].simple>.script]>
      - define display <item[<[item_script]>].display>
      - if <[item_script].data_key[data.scripts.on_break].exists>:
        - inject <script[<context.item.script.name>]> path:data.scripts.on_break
      - run clear_custom_placeable def:<[location]>
      - narrate "<&c>Destroyed <[display]>."

custom_placeable_tick:
  type: task
  debug: false
  definitions: location|uuid
  script:
    # Make sure the location still has a placeable
    - if <server.has_flag[custom_placeables.locations.<[location].simple>]>:
      # Make sure the placeable still has the UUID for this execution of code (prevents running code from old placeables)
      - if <[uuid]> != <server.flag[custom_placeables.locations.<[location].simple>.uuid]>:
        - stop
      # Define the script and execute the tick code
      - define item_script <script[<server.flag[custom_placeables.locations.<[location].simple>.script]>]>
      - inject <[item_script]> path:data.scripts.tick
      # If the placeable is still there, schedule the next tick
      - if <server.has_flag[custom_placeables.locations.<[location].simple>]>:
        - flag server custom_placeables.locations.<[location].simple>.last_tick:<util.time_now>
        - if <[item_script].data_key[data.tick_timer].exists>:
          - runlater custom_placeable_tick def:<[location]>|<[uuid]> delay:<[item_script].data_key[data.tick_timer]>

custom_placeable_interact:
  type: task
  debug: false
  script:
    - ratelimit <player> 1t
    - define location <context.location>
    - define item_script <script[<server.flag[custom_placeables.locations.<[location].simple>.script]>]>
    - inject <[item_script]> path:data.scripts.interact

clear_custom_placeable:
  type: task
  debug: false
  definitions: location
  script:
    - define location <context.location||null> if:<[location].exists.not>
    - define location <player.cursor_on> if:<[location].equals[null]>
    - stop if:<server.has_flag[custom_placeables.locations.<[location].simple>].not>
    - define simple_location <[location].simple>
    - modifyblock <[location]> air
    - flag server custom_placeables.locations.<[simple_location]>:!
    - run remove_framework_flag def:on_right_click|custom_placeable_interact|<[location]>