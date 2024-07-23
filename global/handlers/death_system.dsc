death_system:
  type: world
  debug: false
  events:
    on player respawns:
      - if <player.has_flag[temp.respawn_location]>:
        - determine <player.flag[temp.respawn_location]>
    on player dies:
      # Sanity Check
      - adjust <queue> linked_player:<context.entity>
      # Event related stuff, before we wait 1t for respawn
      - determine passively NO_MESSAGE
      - define location <player.location>
      - flag <player> temp.respawn_location:<[location]>
      - wait 1t
      # Put them in spectator, and show the "DOWNED" Screen
      - adjust <player> gamemode:spectator
      - title title:<&c>Downed stay:3s
      # Find the spawned Corpse Entity
      - define corpse <[location].find_entities[corpse_corpse].within[5].first||null>
      - repeat 8:
        - if <[corpse].equals[null]>:
          - wait 5t
          - define corpse <[location].find_entities[corpse_corpse].within[5].first||null>
        - else:
          - repeat stop
      # If fail, immediate respawn
      - if <[corpse].equals[null]>:
        - adjust <player> gamemode:adventure
        - teleport <player> <server.flag[respawn_points].random>
        - stop
      # Corpse Size changes
      - execute as_server "scale set pehkui:base <script[set_character_traits].data_key[data.races.<player.flag[character.race]>.base_scale]> <[corpse].uuid>"
      - execute as_server "scale set pehkui:width <player.flag[character.weight]> <[corpse].uuid>"
      - execute as_server "scale set pehkui:height <player.flag[character.height]> <[corpse].uuid>"
      # Remove All Potion Effects
      - foreach <player.effects_data>:
        - cast remove <[value].get[type]>
      # Corpse Location Fix
      - teleport <[corpse]> <[corpse].location.above>
      - define death_location <[corpse].location>
      # Player and Corpse flags
      - flag <player> temp.corpse.entity:<[corpse]>
      - flag <player> temp.corpse.view:<[corpse]>
      - flag <[corpse]> owner:<player>
      - flag <[corpse]> holder:world
      - flag <[corpse]> race:<player.flag[character.race]>
      - flag <[corpse]> right_click_script:death_system_corpse_interact
      - flag player temp.corpse.giveup_timer:<util.time_now>
      # Start the teleport loop for attaching the player to the corpse
      - run death_teleport_loop
      # Show the giveup timer countdown
      - title title:<&c>Downed "subtitle:/giveup to respawn in <&e>60 seconds..." stay:2s
      - repeat 59:
        - wait 1s
        - if !<player.is_online> || <player.gamemode> != spectator:
          - stop
        - title title:<&c>Downed "subtitle:/giveup to respawn in <&e><element[60].sub[<[value]>]>" fade_in:0t stay:1.5s
      - wait 1s
      - title title:<&c>Downed "subtitle:/giveup to respawn" fade_in:0t stay:10m

death_system_giveup:
  type: command
  name: giveup
  debug: false
  description: Give up when dead
  usage: /giveup
  script:
    - if !<player.has_flag[temp.corpse.entity]>:
      - stop
    - if <player.flag[temp.corpse.giveup_timer].from_now.in_minutes> < 1:
      - narrate "<&c>You must wait longer.."
      - stop
    #- run remove_framework_flag def:on_teleport|cancel
    - run death_system_revive def:<player> def.new_life:true

## Called to repeatedly teleport a player to their Corpse, while dead.
# Need a better system, eventually
death_teleport_loop:
  type: task
  debug: false
  script:
    - while <player.has_flag[temp.corpse]> && <player.is_online>:
      - teleport <player.flag[temp.corpse.view].location>
      - wait 5t

## Called when a player starts to carry the corpse
death_system_player_pickup:
  type: task
  debug: false
  definitions: corpse|carrier
  data:
    can_carry:
      human:
        human: true
        orc: true
        elytrian: true
        fae: true
      orc:
        human: true
        orc: true
        elytrian: true
        fae: true
      elytrian:
        human: true
        orc: false
        elytrian: true
        fae: true
      fae:
        human: false
        orc: false
        elytrian: false
        fae: true
  script:
    - if <[carrier].exists>:
      - adjust <queue> linked_player:<[carrier]>
    - else:
      - define carrier <player>
    # Prevent Multiple Player Pickup
    - if <[corpse].has_flag[carried_by]> && <[corpse].flag[carried_by].entity_type> == PLAYER:
      - narrate "<&c>The corpse has been moved."
      - stop
    - else if <[corpse].has_flag[carried_by]> && <[corpse].flag[carried_by].entity_type.starts_with[ASTIKOR]>:
      - teleport <[corpse]> <[corpse].flag[carried_by].location.above[0.5]>
      - wait 1t
    # Data Flags
    - if !<script.data_key[data.can_carry.<player.flag[character.race]>.<[corpse].flag[race]>]>:
      - narrate "<&c>This corpse is too heavy for your race to lift."
      - stop
    - flag <[corpse].flag[owner]> temp.corpse.view:<[carrier]>
    - flag <[corpse]> holder:player
    - flag <[corpse]> carried_by:<[carrier]>
    - flag <[carrier]> temp.carried_corpse:<[corpse]>
    - run add_framework_flag def:on_sneak|death_system_drop_start
    - run add_framework_flag def:player_right_clicks|death_system_check
    - run add_framework_flag def:modded_player_right_clicks|cancel
    # Carry the Corpse
    - carry entity:<[corpse]>
    - remove <[corpse]>

death_system_corpse_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - ratelimit <player> 2t
    - stop if:<player.location.distance[<context.entity.location>].is_more_than[2]>
    - stop if:<player.gamemode.equals[spectator]>
    - wait 1t
    - stop if:<player.has_flag[carried_corpse]>
    - if !<player.is_sneaking>:
      - run death_system_pickup_start def:<context.entity>
    - else:
      - run start_timed_action "def:<&c>Looting Corpse...|5s|corpse_inventory_open|<context.entity>" def.can_move:false def.must_stay_sneak:true def.animation_task:loot_corpse_animation

death_system_pickup_start:
  type: task
  debug: false
  definitions: corpse
  script:
    ## TODO
    ## Large Races pick up small races easily
    - run start_timed_action "def:<&e>Grabbing Body...|5s|death_system_player_pickup|<[corpse]>" def.distance_from_origin:2

death_system_drop_start:
  type: task
  debug: false
  script:
    - run start_timed_action "def:<&e>Dropping Body...|1s|death_system_drop" def.must_stay_sneak:true

death_system_drop:
  type: task
  debug: false
  definitions: corpse|carrier
  script:
    - define carrier <player> if:<[carrier].exists.not>
    - define corpse <[carrier].flag[temp.carried_corpse]>
    - carry drop location:<player.location.forward_flat[1.8].above[0.8].with_yaw[<player.location.yaw.sub[90]>]> save:as
    - flag <entry[as].entity.flag[owner]> temp.corpse.view:<entry[as].entity>
    - flag <entry[as].entity> carried_by:!
    - run death_system_reset_carrier def:<[carrier]>

death_system_reset_carrier:
  type: task
  debug: false
  definitions: target
  script:
    - define target <player> if:<[target].exists.not>
    - flag <[target].flag[temp.carried_corpse]> carried_by:!
    - flag <[target]> temp.carried_corpse:!
    - run remove_framework_flag def:on_sneak|death_system_drop_start|<[target]>
    - run remove_framework_flag def:player_right_clicks|death_system_check|<[target]>
    - run remove_framework_flag def:modded_player_right_clicks|cancel|<[target]>

death_system_cleanup_death:
  type: task
  debug: false
  script:
    - define corpse <player.flag[temp.corpse.entity]>
    - define corpse_location_type <[corpse].flag[holder]>
    - choose <[corpse_location_type]>:
      # - remove corpse
      # - close inventory for any viewers
      - case player:
        - stop
      - case world:
        - remove <[corpse]>
      - case cart:
        - stop

death_system_check:
  type: task
  debug: false
  script:
    - ratelimit <player> 2t
    - if <context.entity.exists> && <list[ASTIKORCARTS_ANIMAL_CART|ASTIKORCARTS_SUPPLY_CART].contains[<context.entity.entity_type>]>:
      - run start_timed_action "def:<&e>Placing Body Into Cart|3s|death_system_place_in_cart|<context.entity>" def.distance_from_origin:2
    - else if <context.location.exists> && <context.location.has_flag[respawn_point]>:
      - carry drop location:<context.location.flag[respawn_point]> save:as
      - run start_timed_action "def:<&a>Reviving...|10s|death_system_revive|<entry[as].entity>" player:<entry[as].entity.flag[owner]>
      - flag <entry[as].entity.flag[owner]> temp.corpse.view:<entry[as].entity>
      - flag <entry[as].entity> holder:world
      - run death_system_reset_carrier
    - determine cancelled

death_system_place_in_cart:
  type: task
  debug: false
  definitions: cart
  script:
    - carry drop location:<player.location.forward_flat[1.8].above[0.8].with_yaw[<player.location.yaw.sub[90]>]> save:as
    - mount <entry[as].entity>|<[cart]>
    - flag <entry[as].entity.flag[owner]> temp.corpse.view:<entry[as].entity>
    - flag <entry[as].entity> carried_by:<[cart]>
    - run death_system_reset_carrier

death_system_change_holder:
  type: task
  debug: false
  script:
    - define corpse_location_type <player.flag[corpse].flag[holder]>

death_system_revive:
  type: task
  debug: false
  definitions: corpse|new_life
  script:
    # Danity Check
    - stop if:<player.is_online.not||true>
    - adjust <player> gamemode:adventure
    # Reset Character Attributes
    - execute as_server "scale set pehkui:base <script[set_character_traits].data_key[data.races.<player.flag[character.race]>.base_scale]> <player.name>"
    - execute as_server "scale set pehkui:width <player.flag[character.weight]> <player.name>"
    - execute as_server "scale set pehkui:height <player.flag[character.height]> <player.name>"
    # Feed/Water if low, don't need to die immediately again.
    - adjust <player> thirst:5 if:<player.thirst.is_less_than[5]>
    - adjust <player> food_level:5 if:<player.food_level.is_less_than[5]>
    - run death_system_cleanup_death
    # Handle respawn
    - if <[new_life]||false>:
      - title title:<&a>Revived "subtitle:New Life Rule applied!" stay:3s
      - wait 1t
      - teleport <player> <server.flag[respawn_points].random>
    - else:
      - title title:<&a>Revived
    - flag <player> temp.corpse:!
    - wait 1t
    - inventory update