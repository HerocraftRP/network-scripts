corpse_system_events:
  type: world
  debug: false
  events:
    on player dies:
      - determine passively NO_MESSAGE
      - adjust <player> gamemode:spectator
      - wait 5t
      - define corpse <context.entity.location.find_entities[corpse_corpse].within[5].first||null>
      - stop if:<[corpse].equals[null]>
      - define death_location:<[corpse].location>
      - adjust <player> spectate:<[corpse]>
      - flag <player> dead:<[corpse]>
      - flag <player> on_teleport:cancel
      - flag <[corpse]> owner:<player>
      - adjust <player> respawn
      - wait 1t
      - teleport <player> <[death_location]>
      - flag <[corpse]> right_click_script:corpse_interact
      - wait 2t
      - teleport <[corpse]> <[corpse].location.above>
      - adjust <player> spectate:<[corpse]>
      - wait 2t
      - flag player giveup_timer:<util.time_now>
      - title title:<&c>Downed "subtitle:/giveup to respawn in <&e>60 seconds..." stay:2s
      - repeat 59:
        - wait 1s
        - if !<player.is_online> || <player.gamemode> != spectator:
          - stop
        - teleport <player> <[corpse].location>
        - adjust <player> spectate:<[corpse]>
        - title title:<&c>Downed "subtitle:/giveup to respawn in <&e><element[60].sub[<[value]>]>" fade_in:0t stay:1.5s
      - wait 1s
      - title title:<&c>Downed "subtitle:/giveup to respawn" fade_in:0t stay:10m
      - while <player.is_online> && <[corpse].is_spawned>:
        - teleport <player> <[corpse].location>
        - wait 1s

    on player quits flagged:dead:
      - teleport <player.flag[dead].location>
      - remove <player.flag[dead]>
      - title title:<&c>Downed "subtitle:/giveup to respawn in <&e>60 seconds..." stay:2s
      - wait 1t
      - adjust <player> spectate:<player.flag[corpse]>
      - while <player.is_online> && <[corpse].is_spawned>:
        - teleport <player> <[corpse].location>
        - wait 1s

corpse_giveup:
  type: command
  name: giveup
  debug: false
  description: Give up when dead
  usage: /giveup
  script:
    - if !<player.has_flag[dead]>:
      - stop
    - if <player.flag[giveup_timer].from_now.in_minutes> < 1:
      - narrate "<&c>You must wait longer.."
      - stop
    - if <player.flag[dead].vehicle.exists>:
      - adjust <player.flag[dead].vehicle> walk_speed:0.2
      - flag <player.flag[dead].vehicle> on_sneak:!
      - flag <player.flag[dead].vehicle> carried_corpse:!
    - run corpse_revive def:<player.flag[dead]>
    - wait 1t
    - teleport <player> <server.flag[respawn_points].random>

corpse_resurrect:
  type: task
  debug: false
  definitions: target
  script:
    - adjust <queue> linked_player:<[target].flag[owner]>
    - run corpse_revive

corpse_inventory:
  type: inventory
  title: Body
  debug: false
  inventory: chest
  size: 54
  data:
    #on_close: corpse_inventory_close
    click_script_slots:
      37: cancel
      38: cancel
      39: cancel
      40: cancel
      41: cancel
      42: cancel
      43: cancel
      44: cancel
      45: cancel
      46: cancel
      48: cancel
      50: cancel
      52: cancel
      54: cancel
    replacement_slots:
      40: 47
      47: 40
      38: 49
      49: 38
      39: 51
      51: 39
      37: 53
      53: 37

announce_slot:
  type: task
  debug: false
  script:
    - narrate <context.slot>

corpse_inventory_open:
  type: task
  debug: false
  definitions: corpse
  script:
    - define inv <inventory[CORPSE_<[corpse].flag[owner].uuid>].if_null[null]>
    - if <[inv]> != null:
      - inventory open d:<[inv]>
      - stop
    - note <inventory[corpse_inventory]> as:CORPSE_<[corpse].flag[owner].uuid>
    - foreach <[corpse].flag[owner].inventory.map_slots>:
      - inventory set slot:<script[corpse_inventory].data_key[data.replacement_slots.<[key]>]||<[key]>> d:<inventory[CORPSE_<[corpse].flag[owner].uuid>]> o:<[value]>
    - inventory open d:<inventory[CORPSE_<[corpse].flag[owner].uuid>]>

corpse_inventory_close:
  type: task
  debug: false
  script:
    - foreach <context.entity.flag[owner].inventory.map_slots>:
      - inventory set slot:<script[corpse_inventory].data_key[data.replacement_slots.<[key]>]||<[key]>> d:<[inv]> o:<[value]>
    - inventory set slot:41 o:PLAYER_HEAD[skin_blob=<context.entity.flag[owner].skin_blob>;display=<&c>]
    - inventory open d:<[inv]>

corpse_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - ratelimit <player> 2t
    - stop if:<player.gamemode.equals[spectator]>
    - wait 1t
    - stop if:<player.has_flag[carried_corpse]>
    - if !<player.is_sneaking>:
      - run start_timed_action "def:<&e>Picking Up Body...|3s|corpse_pickup|<context.entity>" def.can_move:false
    - else:
      - run start_timed_action "def:<&c>Looting Corpse...|5s|corpse_inventory_open|<context.entity>" def.can_move:false def.must_stay_sneak:true def.animation_task:loot_corpse_animation

loot_corpse_animation:
  type: task
  debug: false
  script:
    - if !<player.has_flag[animation_stage]>:
      - flag <player> animation_stage:0
    - if <player.flag[animation_stage]> == 0:
      - animate <player> animation:ARM_SWING_OFFHAND
      - flag <player> animation_stage:1
    - else:
      - animate <player> animation:ARM_SWING
      - flag <player> animation_stage:0

corpse_pickup:
  type: task
  debug: false
  definitions: corpse
  script:
    - if <[corpse].has_flag[carried_by]>:
      - define old_carrier <[corpse].flag[carried_by]>
      - adjust <[old_carrier]> walk_speed:0.2
      - flag <[old_carrier]> on_sneak:!
      - flag <[old_carrier]> carried_corpse:!
    - mount <[corpse]>|<player>
    - adjust <player> walk_speed:0.075
    - flag <[corpse]> carried_by:<player>
    - flag <player> on_sneak:corpse_drop_start
    - flag <player> carried_corpse:<[corpse]>

corpse_drop_start:
  type: task
  debug: false
  script:
    - run start_timed_action "def:<&e>Dropping Body...|1s|corpse_drop" def.must_stay_sneak:true

corpse_pickup_start:
  type: task
  debug: false
  script:
    - run start_timed_action "def:<&e>Grabbing Body...|3s|corpse_pickup" def.must_stay_sneak:true

corpse_drop:
  type: task
  debug: false
  script:
    - adjust <player> walk_speed:0.2
    - flag <player> on_sneak:!
    - if <player.flag[carried_corpse].is_spawned>:
      - define corpse <player.flag[carried_corpse]>
      - define rp <player.location.forward_flat[2].find_blocks_flagged[respawn_point].within[2].first.if_null[null]>
      - define respawn_point <[rp].flag[respawn_point].if_null[<[rp]>]>
      - define cart <player.eye_location.forward_flat[2].find_entities[astikorcarts_supply_cart|astikorcarts_animal_cart].within[2].first.if_null[null]>
      - teleport <[corpse]> <player.eye_location.above>
      - adjust <[corpse]> velocity:<player.location.forward.sub[<player.location>]>
      - if <[respawn_point]> != null:
        - teleport <player.flag[carried_corpse]> <[respawn_point].center>
        - run start_timed_action def:<&a>Healing|10s|corpse_revive|<[corpse]> player:<[corpse].flag[owner]>
      - else if <[cart]> != null:
        - wait 10t
        - mount <player.flag[carried_corpse]>|<[cart]>
        - adjust <player.flag[carried_corpse].flag[owner]> spectate:<[cart]>
        - flag <[cart]> right_click_script:get_corpse_entity
        - flag <[cart]> carried_corpse:<player.flag[carried_corpse]>
    - flag <player> carried_corpse:!

corpse_revive:
  type: task
  debug: false
  definitions: corpse
  script:
    - stop if:<player.is_online.not||true>
    - define location <player.flag[dead].location>
    - define inv <inventory[CORPSE_<player.uuid>]||null>
    - foreach <[inv].viewers||<list[]>>:
      - inventory close player:<[value]>
    - if <[inv]> != null:
      - inventory clear d:<player.inventory>
      - wait 1t
      - foreach <[inv].map_slots>:
        - foreach continue if:<[key].equals[41]>
        - inventory set slot:<script[corpse_inventory].data_key[data.replacement_slots.<[key]>]||<[key]>> d:<[inv]> o:<[value]>
    - adjust <player> bed_spawn_location
    - adjust <player> spawn_forced:false
    - adjust <player> respawn
    - teleport <[location]>
    - adjust <player> spectate:<player>
    - adjust <player> gamemode:adventure
    - remove <player.flag[dead]>
    - cast effect:xaeroworldmap_no_world_map duration:24h no_ambient no_icon no_clear hide_particles
    - cast effect:xaerominimap_no_minimap duration:24h no_ambient no_icon no_clear hide_particles
    # Restore Items
    - define inv <inventory[CORPSE_<player.uuid>]||null>
    - if <[inv]> != null:
      - inventory clear d:<player.inventory>
      - wait 1t
      - foreach <[inv].map_slots>:
        - inventory set slot:<script[corpse_inventory].data_key[data.replacement_slots.<[key]>]||<[key]>> d:<player.inventory> o:<[value]>
    - note remove as:CORPSE_<player.uuid>
    - title title:<&a>Revived stay:3s
    - flag <player> on_teleport:!
    - flag <player> dead:!
    - wait 5t
    - inventory update

get_corpse_entity:
  type: task
  debug: false
  script:
    - define corpse <context.entity.flag[carried_corpse]>
    - flag <context.entity> carried_corpse:!
    - flag <context.entity> right_click_script:!
    - adjust <[corpse].flag[owner]> spectate:<[corpse]>
    - mount <[corpse]>|<player>
    - adjust <player> walk_speed:0.075
    - flag <player> on_sneak:corpse_drop_start
    - flag <player> carried_corpse:<context.entity>