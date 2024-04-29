house_create:
  type: task
  debug: false
  definitions: location|uuid
  script:
    - if !<[location].exists>:
      - define location <player.cursor_on>
    - if <[location].material.name> != air:
      - narrate "<&c>Invalid location/positioning."
      - stop
    - if !<[uuid].exists>:
      - define uuid <util.random_uuid>
      - while <server.has_flag[housing.<[uuid]>]>:
        - define uuid <util.random_uuid>
    - define blocks <[location].flood_fill[20]>
    - foreach <[blocks]>:
      - flag <[value]> on_place:housing_place_check
      - flag <[value]> on_break:housing_break_check
      - flag <[value]> on_right_click:housing_use_check
      - flag <[value]> housing.id:<[uuid]>
      - flag server housing.<[uuid]>.members:<map>
      - flag server housing.<[uuid]>.blocks:->:<[value]>
    - narrate "<&a>Nearby Blocks set to home <[uuid]>"
    - determine passively <[uuid]>
    - run send_to_discord "def:<player.name> house UUID<&co> <[uuid]>"

house_set_door:
  type: task
  debug: false
  definitions: uuid|location|price|owner
  script:
    - if !<[location].exists>:
      - define location <player.cursor_on>
    - if !<[price].exists>:
      - define price 10000
    - define normalized_angle <[location].center.with_pose[0,<player.location.yaw.round_to_precision[90]>]>
    - if !<[uuid].exists>:
      - run house_create def:<[normalized_angle].forward[1]> save:uuid
      - define uuid <entry[uuid].created_queue.determination.first>
    - flag server housing.<[uuid]>.doors:->:<[location]>
    - define outside_cuboid <[normalized_angle].backward[2].left[1].to_cuboid[<[normalized_angle].backward[1].right[1]>]>
    - define inside_cuboid <[normalized_angle].forward[2].left[1].to_cuboid[<[normalized_angle].forward[1].right[1]>]>
    - note <[outside_cuboid]> as:housing_<[uuid]>_exit
    - note <[inside_cuboid]> as:housing_<[uuid]>_entrance
    - flag <cuboid[housing_<[uuid]>_entrance]> player_enters:housing_enter
    - flag <cuboid[housing_<[uuid]>_exit]> player_enters:housing_exit
    - flag <cuboid[housing_<[uuid]>_entrance]> housing.id:<[uuid]>
    - flag <cuboid[housing_<[uuid]>_exit]> housing.id:<[uuid]>
    - flag <[location].flood_fill[3]> housing.id:<[uuid]>
    - narrate "Door for house <[uuid]> set to <[location]>"
    - repeat 4:
      - define sign <[normalized_angle].backward[<[value]>].find_blocks[*sign].within[2].first||null>
      - if <[sign]> != null:
        - repeat stop
    - if <[sign]> == null:
      - narrate "<&c>Unable to automatically find sign."
      - narrate "<&a>UUID<&co> <[uuid]>"
      - narrate "<&e>UUID for house can be found in discord for copy/paste"
      - narrate "<&b>/ex run house_set_sign def:(uuid)"
    - else:
      - run house_set_sign def:<[uuid]>|<[price]>|<[sign]>
    - if <[owner].exists>:
      - run housing_set_owner def:<[uuid]>|<[owner]>

housing_enter:
  type: task
  debug: false
  script:
    - define uuid <context.area.flag[housing.id]>
    - if <server.flag[housing.<[uuid]>.members.<player.uuid>.build]||false>:
      - adjust <player> gamemode:survival

housing_exit:
  type: task
  debug: false
  script:
    - adjust <player> gamemode:adventure if:<player.gamemode.equals[survival]>

house_set_sign:
  type: task
  debug: false
  definitions: uuid|price|location
  script:
    - if !<[uuid].exists>:
      - narrate "<&c>ERROR - No UUID Specified"
      - stop
    - if !<[location].exists>:
      - define location <player.cursor_on>
    - if !<[price].exists>:
      - define price 10000
      - narrate "<&c>No Price Specified!"
      - narrate "<&e>Defaulting to 10000"
      - narrate "<&b>/ex run house_update_sign def:(uuid)|(price)"
      - narrate "<&e>UUID: <[uuid]>"
    - flag server housing.<[uuid]>.sign:<[location]>
    - adjust <[location]> "sign_contents:|<&a>For Sale|<&e><&n><[price]><&6> RC"
    - adjust <[location]> sign_glow_color:orange
    - flag <[location]> housing.id:<[uuid]>
    - narrate "Sign for house <[uuid]> set to <[location]>"

house_update_sign:
  type: task
  debug: false
  definitions: uuid|price
  script:
    - adjust <server.flag[housing.<[uuid]>.sign]> "sign_contents:|<&a>For Sale|<&e><&n><[price]><&6> RC"
    - adjust <server.flag[housing.<[uuid]>.sign]> sign_glow_color:orange
    - narrate "Price for house <[uuid]> set to <[price]>"

housing_place_check:
  type: task
  debug: false
  script:
    - define uuid <context.location.flag[housing.id]>
    - if <server.flag[housing.<[uuid]>.members].keys.contains[<player.uuid>]>:
      - if <server.flag[housing.<[uuid]>.members.<player.uuid>.build]>:
        - determine cancelled:false

housing_break_check:
  type: task
  debug: false
  script:
    - define uuid <context.location.flag[housing.id]>
    - if <server.flag[housing.<[uuid]>.members].keys.contains[<player.uuid>]>:
      - if <server.flag[housing.<[uuid]>.members.<player.uuid>.build]>:
        - determine cancelled:false

housing_use_check:
  type: task
  debug: false
  script:
    - define uuid <context.location.flag[housing.id]>
    - if <server.flag[housing.<[uuid]>.members].keys.contains[<player.uuid>]>:
      - if <server.flag[housing.<[uuid]>.members.<player.uuid>.use]>:
        - stop
    - determine cancelled

housing_set_owner:
  type: task
  debug: false
  definitions: uuid|owner
  script:
    - if !<[owner].exists>:
      - define owner <player>
    - flag server housing.<[uuid]>.members.<[owner].uuid>.build:true
    - flag server housing.<[uuid]>.owner.<[owner].uuid>
    - flag server housing.<[uuid]>.members.<[owner].uuid>.use:true

housing_set_member:
  type: task
  debug: false
  definitions: uuid|member|build|use
  script:
    - if !<[member].exists>:
      - define member <player>
    - if !<[build].exists>:
      - define build <player>
    - if !<[use].exists>:
      - define use <player>
    - flag server housing.<[uuid]>.members.<[member].uuid>.build:<[build]>
    - flag server housing.<[uuid]>.members.<[member].uuid>.use:<[use]>

