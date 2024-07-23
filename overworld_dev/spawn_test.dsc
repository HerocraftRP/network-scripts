find_suitable_spawn_location:
  type: task
  debug: false
  script:
    - define locations <player.location.find_spawnable_blocks_within[15].filter[distance[<player.location>].is_more_than[10]]>
    - define players <player.location.find_players_within[15]>
    - wait 1t
    - foreach <[locations]> as:loc:
      - if <[loop_index].mod[10].equals[0]>:
        - wait 1t
      - foreach <[players]> as:targ:
        - narrate <[loc].above.with_yaw[<[loc].direction[<[targ].location>].yaw>].with_pitch[-10].ray_trace[nonsolids=true;range=<[loc].distance[<[targ].location>]>].material.name||air>
        - if <[loc].above.with_yaw[<[loc].direction[<[targ].location>].yaw>].with_pitch[-10].ray_trace[nonsolids=true;range=<[loc].distance[<[targ].location>]>].material.name||air> != air:
          - repeat <[players].size.mul[2]>:
            - narrate "Spawn Location Found"
            - narrate "<[loc].distance[<player.location>]>"
            - spawn plains_wolf <[loc]> save:as
            - attack <entry[as].spawned_entity> target:<[players].random>
          - stop

plains_wolf:
  type: entity
  debug: false
  entity_type: wolf
  mechanisms:
    speed: 0.5