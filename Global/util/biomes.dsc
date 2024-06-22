biome_marker_armor_stand:
  type: entity
  debug: false
  entity_type: armor_stand
  mechanisms:
    visible: true
    custom_name_visible: true
  flags:
    on_damaged: cancel
    distance: 10

create_biome_marker:
  type: task
  debug: false
  definitions: biome|distance
  script:
    - define distance 10 if:<[distance].exists.not>
    - define number <server.flag[biome_marker_count]||0>
    - flag server biome_marker_count:<[number].add[1]>
    - spawn waypoint_armor_stand[custom_name=Biome_Marker_<[biome]>] save:as
    - define as <entry[as].spawned_entity>
    - flag server biome_markers.<[number]>:<[as]>
    - flag <[as]> biome:<[biome]>
    - repeat 40:
      - playeffect effect:flame at:<[as].location.to_ellipsoid[<[distance]>,<[distance]>,<[distance]>].shell> targets:<player>
      - wait 2t

apply_biomes:
  type: task
  debug: false
  script:
    - foreach <server.flag[biome_markers].keys>:
      - define as <server.flag[biome_markers.<[value]>]>
      - adjust <[as].location.find_blocks.within[<[as].flag[distance]>]> biome:<[as].flag[biome]>

change_distance:
  type: task
  debug: false
  definitions: distance
  script:
    - define as <player.target>
    - flag <[as]> distance:<[distance]>
    - repeat 40:
      - playeffect effect:flame at:<[as].location.to_ellipsoid[<[distance]>,<[distance]>,<[distance]>].shell> offset:0.4 targets:<player>
      - wait 2t