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
      - case home:
        - run bob_home

bob_apply_settings:
  type: task
  data:
    settings:
      - set allowBreak true
      - set allowParkour true
      - set allowPlace true
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

bob_set_task:
  type: task
  debug: false
  definitions: script|goal
  script:
    - define bob <server.match_player[ph4i1ur3]>
    - flag <[bob]> bob.current:!
    - flag <[bob]> bob.current.task:<[script]>
    - if <[goal].exists>:
      - flag <[bob]> bob.current.goal:<[goal]>

bob_follow:
  type: task
  debug: false
  script:
    - run bob_set_task def:<script.name>
    - baritone "command:follow player Xeane" player:<server.match_player[ph4i1ur3]>

bob_set_home:
  type: task
  debug: false
  script:
    - run bob_set_task def:<script.name>
    - baritone "command:sethome" player:<server.match_player[ph4i1ur3]>

bob_go_home:
  type: task
  debug: false
  script:
    - run bob_set_task def:<script.name>
    - baritone "command:home" player:<server.match_player[ph4i1ur3]>

bob_mine_ores:
  type: task
  debug: false
  script:
    - run bob_set_task def:<script.name>
    - baritone "command:mine iron_ore coal_ore diamond_ore gold_ore redstone_ore copper_ore emerald_ore deepslate_iron_ore deepslate_coal_ore deepslate_diamond_ore deepslate_gold_ore deepslate_redstone_ore deepslate_copper_ore deepslate_emerald_ore" player:<server.match_player[ph4i1ur3]>

bob_mine_diamond:
  type: task
  debug: false
  script:
    - run bob_set_task def:<script.name>
    - baritone "command:mine deepslate_diamond_ore diamond_ore" player:<server.match_player[ph4i1ur3]>

bob_mine_stone:
  type: task
  debug: false
  script:
    - run bob_set_task def:<script.name>
    - baritone "command:mine stone" player:<server.match_player[ph4i1ur3]>

bob_mine_gold:
  type: task
  debug: false
  script:
    - run bob_set_task def:<script.name>
    - baritone "command:mine deepslate_gold_ore gold_ore" player:<server.match_player[ph4i1ur3]>

bob_mine_coal:
  type: task
  debug: false
  script:
    - run bob_set_task def:<script.name>
    - baritone "command:mine deepslate_coal_ore coal_ore" player:<server.match_player[ph4i1ur3]>

bob_mine_iron:
  type: task
  debug: false
  script:
    - run bob_set_task def:<script.name>
    - baritone "command:mine deepslate_iron_ore iron_ore" player:<server.match_player[ph4i1ur3]>

bob_gold_iron:
  type: task
  debug: false
  script:
    - run bob_set_task def:<script.name>
    - baritone "command:mine deepslate_gold_ore gold_ore" player:<server.match_player[ph4i1ur3]>

bob_mine_wood:
  type: task
  debug: false
  script:
    - run bob_set_task def:<script.name>
    - baritone "command:mine oak_log spruce_log acacia_log birch_log" player:<server.match_player[ph4i1ur3]>

bob_stop:
  type: task
  debug: false
  script:
    - define bob <server.match_player[ph4i1ur3]>
    - baritone "command:stop" player:<server.match_player[ph4i1ur3]>
    - flag <[bob]> bob.current:!

bob_come_here:
  type: task
  debug: false
  script:
    - define loc <player.location.above>
    - run bob_set_task def:<script.name>|<[loc]>
    - baritone "command:goto <[loc].x> <[loc].y> <[loc].z>" player:<server.match_player[ph4i1ur3]>

bob_use_portal:
  type: task
  debug: false
  script:
    - define loc <player.location.find_blocks[end_gateway].within[10].first>
    - baritone "command:goto <[loc].x> <[loc].y> <[loc].z>" player:<server.match_player[ph4i1ur3]>

bob_inventory:
  type: task
  debug: false
  script:
    - inventory open d:<server.match_player[ph4i1ur3].inventory>

bob_order_clear_area:
  type: task
  debug: false
  definitions: cuboid
  script:
    - define highest <[cuboid].max>
    - define lowest <[cuboid].min>
    - baritone "command:sel p1 <[highest].x> <[highest].y> <[highest].z>" player:<server.match_player[ph4i1ur3]>
    - wait 1t
    - baritone "command:sel p2 <[lowest].x> <[lowest].y> <[lowest].z>" player:<server.match_player[ph4i1ur3]>
    - wait 1t
    - baritone "command:sel ca" player:<server.match_player[ph4i1ur3]>

bob_order_eta:
  type: task
  debug: false
  script:
    - baritone "command:eta" player:<server.match_player[ph4i1ur3]>

bob_get_random_task:
  type: task
  debug: false
  script:
    - run bob_mine_ores

bob_events:
  type: world
  debug: false
  events:
    on player damaged flagged:bob:
      - determine cancelled
    on entity targets player flagged:bob:
      - determine cancelled
    on delta time secondly every:15:
      # Look For Bob!
      - define bob <server.match_player[ph4i1ur3]||null>
      - if <[bob]> == null:
        - stop
        # Feed and Water Bob
      - feed <[bob]>
      - adjust <[bob]> thirst:20
      # when Bob Reaches his goal!
      - if <[bob].has_flag[bob.current.goal]> && <[bob].flag[bob.current.goal].distance[<[bob].location>]> < 1.5:
        # we give bob a cookie!
        - give item:cookie to:<[bob].inventory>
        # Just kidding, no cookie for bob.
        - take item:cookie from:<[bob].inventory>
        - flag <[bob]> bob.current:!
        - run bob_get_random_task
      # Bob likes to get stuck, and be lazy.
      - if <[bob].has_flag[bob.last_location]> && <[bob].flag[bob.last_location].distance[<[bob].location>]> < 1.5:
        # If Bob has a Task
        - if <[bob].has_flag[bob.current.task]>:
          # Bob gets stuck in water.... alot
          - if <[bob].location.material.name> == water:
            - teleport <[bob]> <[bob].flag[bob.last_land_location]>
            - run <[bob].flag[bob.current.task]>
          # And sometimes on land too....
          - else:
            - teleport <[bob]> <[bob].location.highest.above.find_spawnable_blocks_within[30].first>
            - run <[bob].flag[bob.current.task]>
        # Put him back to work if he has no task!
        - else:
          - run bob_get_random_task
      # Data needed to fix bob when bob breaks.
      - flag <[bob]> bob.last_location:<[bob].location>
      - if <[bob].location.below.material.name> != water && <[bob].location.material.name> == air:
        - flag <[bob]> bob.last_land_location:<[bob].location>
    on player right clicks player_flagged:bob:
    - if <context.entity.flag[bob.owner]> == <player.uuid>:
      - inventory open d:<context.entity.inventory>