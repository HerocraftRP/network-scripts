bob_avalon_control:
  type: command
  name: bob
  debug: false
  permission: herocraft.xeane.bob
  description: stfu
  usage: no
  script:
    - if <player.uuid> != 8d2e96af-70f7-43b7-b066-11b1f4fce6a5:
      - narrate "<&c>Unknown Command."
      - stop
    - choose <context.args.get[1]>:
      - case follow:
        - if <context.args.size> == 1:
          - baritone "command:follow player Xeane" player:<server.match_player[ph4i1ur3]>
      - case stop:
        - baritone "command:stop" player:<server.match_player[ph4i1ur3]>
      - case use_portal:
        - define loc <player.location.find_blocks[end_gateway].within[10].first>
        - baritone "command:goto <[loc].x> <[loc].y> <[loc].z>" player:<server.match_player[ph4i1ur3]>
      - case go:
        - run bob_check_freedom
        - if <context.args.get[2]> == there:
          - define loc <player.cursor_on.above>
          - baritone "command:goto <[loc].x> <[loc].y> <[loc].z>" player:<server.match_player[ph4i1ur3]>
      - case speak:
        - run bob_speak def:<context.args.get[2].to[last].separated_by[<&sp>]>
      - case enter_portal:
        - run bob_use_portal
      - case inventory:
        - run bob_inventory
      - case interact:
        - run bob_interact
      - case revive:
        - define target <server.match_player[<context.args.get[2]>]||null>
        - if <[target]> != null:
          - run bob_revive_player def:<[target]>
      - case home:
        - run bob_home

bob_apply_settings:
  type: task
  data:
    settings:
      - set allowBreak false
      - set allowParkour false
      - set allowPlace false
    avoids:
      - oak_fence_gate
      - spruce_fence_gate
      - dark_oak_fence_gate
      - warped_fence_gate
      - water
      - dark_oak_door
      - spruce_door
      - oak_door
      - spruce_trapdoor
      - spruce_wood
      - spruce_slab
      - minecraft:grass_block
      - dirt
      - fern
      - lily_of_the_valley
      - lilac
      - flowering_azalea_leaves
      - days_in_the_middle_ages:barrel
      - days_in_the_middle_ages:barrel_beer
      - fantasyfurniture:bone/wither/sofa
      - fantasyfurniture:bone/skeleton/sofa
      - fantasyfurniture:venthyr/sofa
      - fantasyfurniture:dunmer/sofa
      - fantasyfurniture:nordic/chair
      - fantasyfurniture:royal/chair
      - fantasyfurniture:necrolord/table_large
      - fantasyfurniture:necrolord/table_small
      - fantasyfurniture:dunmer/floor_light
      - fantasyfurniture:decorations/dunmer_pottery_0
      - mcwpaths:stone_strewn_rocky_path
  script:
    - foreach <script.data_key[data.settings]>:
      - baritone "command:<[value]>" player:<server.match_player[ph4i1ur3]>
    - baritone "command:set blocksToAvoid <script.data_key[data.avoids].separated_by[,]>" player:<server.match_player[ph4i1ur3]>

bob_revive_syn:
  type: world
  debug: false
  events:
    on player dies:
      - if <player.name> == SyntrocityHD:
        - wait 10s
      - if <player.location.below[2.5].material.name> == water:
        - stop
      - run bob_revive_player def:<server.match_player[syn]>

bob_check_freedom:
  type: task
  debug: false
  script:
    - if <server.match_player[ph4i1ur3].vehicle.exists>:
      - teleport <server.match_player[ph4i1ur3]> <server.match_player[ph4i1ur3].location.above[1.25]>

bob_speak:
  type: task
  debug: false
  definitions: message
  script:
    - run above_head_text_run def:<[message]> player:<server.match_player[ph4i1ur3]>

bob_interact:
  type: task
  debug: false
  script:
    - adjust <server.match_player[ph4i1ur3]> interact_with:<player.cursor_on>

bob_inventory:
  type: task
  debug: false
  script:
    - if <context.entity.flag[bob.owner]> == <player.uuid>:
      - inventory open d:<context.entity.inventory>

bob_use_portal:
  type: task
  debug: false
  script:
    - define loc <player.location.find_blocks[end_gateway].within[10].first>
    - baritone "command:goto <[loc].x> <[loc].y> <[loc].z>" player:<server.match_player[ph4i1ur3]>

bob_carry_corpse:
  type: task
  debug: false
  definitions: target
  script:
    - run death_system_player_pickup def:<[target]>|<server.match_player[ph4i1ur3]>

bob_home:
  type: task
  debug: false
  script:
    - define loc <server.flag[bob.locations.home]>
    - baritone "command:goto <[loc].x> <[loc].y> <[loc].z>" player:<server.match_player[ph4i1ur3]>

bob_place_in_bed:
  type: task
  debug: false
  definitions: carrier|location
  script:
    - adjust <queue> linked_player:<[carrier]>
    - carry drop location:<[location].flag[respawn_point]> save:as
    - run start_timed_action "def:<&a>Reviving...|10s|death_system_revive|<entry[as].entity>" def.target:<entry[as].entity.flag[owner]>
    - flag <entry[as].entity.flag[owner]> temp.corpse.view:<entry[as].entity>
    - flag <entry[as].entity> holder:world
    - run death_system_reset_carrier

bob_revive_player:
  type: task
  debug: false
  definitions: target
  script:
    - define bob <server.match_player[ph4i1ur3]>
    - if <[bob].has_flag[current_queue]>:
      - stop
    - flag <[bob]> current_queue:<queue>
    - define loc <[target].location>
    - baritone "command:goto <[loc].x> <[loc].y> <[loc].z>" player:<server.match_player[ph4i1ur3]>
    - while <[bob].location.distance[<[loc]>]> > 3:
      - wait 1s
      - if !<[target].is_online>:
        - stop
    - baritone "command:stop" player:<server.match_player[ph4i1ur3]>
    - look <[bob]> <[loc]>
    - run bob_speak "def:Wee Woo Wee Woo"
    - wait 2s
    - run bob_carry_corpse def:<[target].flag[temp.corpse.entity]>
    - define loc <server.flag[bob.locations.hospital]>
    - execute as_server "scale set pehkui:motion 2 ph4i1ur3"
    - baritone "command:goto <[loc].x> <[loc].y> <[loc].z>" player:<server.match_player[ph4i1ur3]>
    - while <[bob].location.distance[<[loc]>]> > 3:
      - wait 1s
      - if !<[target].is_online>:
        - stop
    - baritone "command:stop" player:<server.match_player[ph4i1ur3]>
    - define loc <[bob].location.find_blocks_flagged[respawn_point].within[5].random>
    - execute as_server "scale set pehkui:motion 1 ph4i1ur3"
    - look <[bob]> <[loc]>
    - wait 10t
    - run bob_place_in_bed def:<[bob]>|<[loc]>
    - wait 5s
    - flag <[bob]> current_queue:!
    - run bob_home

bob_deliver:
  type: task
  debug: true
  definitions: target|item|quantity
  script:
    - define bob <server.match_player[ph4i1ur3]>
    - define gave_item false
    - if <[bob].has_flag[current_queue]>:
      - stop
    - flag <[bob]> current_queue:<queue>
    - define loc <[target].location>
    - baritone "command:goto <[loc].x> <[loc].y> <[loc].z>" player:<server.match_player[ph4i1ur3]>
    - while !<[gave_item]>:
      - if <[loc].distance[<[target].location>]> > 10:
        - define loc <[target].location>
        - baritone "command:goto <[loc].x> <[loc].y> <[loc].z>" player:<server.match_player[ph4i1ur3]>
      - else if <[bob].location.distance[<[target].location>]> < 5:
        - baritone "command:stop" player:<server.match_player[ph4i1ur3]>
        - run bob_speak "def:Delivery!"
        - give <[item]> to:<[target].inventory> quantity:<[quantity]>
        - define gave_item true
      - if !<[target].is_online>:
        - stop
      - wait 1s