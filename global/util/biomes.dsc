biome_remap:
  type: data
  biomes:
    framers_way: Farmer<&sq>s Way
    fish_view: Fisherman<&sq> View
    iron_belly: The Iron Belly
    bank: Avalon National Bank
    circus_test: Circus Tent
    paupers_marker: Pauper<&sq>s Market

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
    - flag <[as]> distance:<[distance]>
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

output_biome_list:
  type: task
  debug: false
  definitions: titles_only
  data:
    datapack:
      temperature: 0.8
      has_precipitation: true
      downfall: 0.4
      effects:
        sky_color: 7907327
        fog_color: 12638463
        water_color: 4159204
        water_fog_color: 329011
      spawners: {}
      spawn_costs: {}
      features: []
      carvers: {}
    titles:
      - <&sp><&sp><&dq>biome.herocraft.<[biome_name]><&dq>: <&dq><[biome_display]><&dq>,
      - <&sp><&sp><&dq>biome.herocraft.<[biome_name]>.color<&dq>: <&dq>FCBF0F<&dq>,
  script:
    - define list <list>
    - foreach <server.flag[biome_markers].keys>:
      - define biome <server.flag[biome_markers.<[value]>].flag[biome]||null>
      - define list <[list].include[<[biome]>].deduplicate> if:<[biome].equals[null].not>
    - foreach <[list]>:
      - narrate <[value]>
      - define biome_name <[value]>
      - if <script[biome_remap].parsed_key[biomes.<[biome_name]>].exists>:
        - define biome_display <script[biome_remap].data_key[biomes.<[biome_name]>]>
      - else:
        - define biome_display <[biome_name].replace[_].with[<&sp>].to_titlecase>
      - log type:none <script.data_key[data.datapack].to_json[native_types=true]> file:world/datapacks/Herocraft/data/herocraft/worldgen/biome/<[value]>.json if:<[titles_only].not||true>
      - foreach <script.parsed_key[data.titles]>:
        - log type:none <[value]> file:travellers_titles.json

biome_markers_apply:
  type: task
  debug: false
  script:
    - foreach <server.flag[biome_markers].keys>:
      - define biome <server.flag[biome_markers.<[value]>].flag[biome]||null>
      - narrate "<&e>Applying Biome <&b><[biome]>"
      - if !<server.flag[biome_markers.<[value]>].is_spawned> || <[biome]> == null:
        - foreach next
      - define distance <server.flag[biome_markers.<[value]>].flag[distance]||10>
      - adjust <server.flag[biome_markers.<[value]>].location.find_blocks.within[<[distance]>]> biome:herocraft:<[biome]>
      - wait 1t

change_biome:
  type: task
  debug: false
  definitions: biome
  script:
    - define as <player.target>
    - flag <[as]> biome:<[biome]>
    - adjust <[as]> custom_name:Biome_Marker_<[biome]>

biome_markers_save:
  type: task
  debug: false
  script:
    - foreach <server.flag[biome_markers].keys>:
      - define biome <server.flag[biome_markers.<[value]>].flag[biome]||null>
      - define distance <server.flag[biome_markers.<[value]>].flag[distance]||10>
      - if !<server.flag[biome_markers.<[value]>].is_spawned> || <[biome]> == null:
        - foreach next
      - flag server biome_markers_saved.<[value]>.location:<server.flag[biome_markers.<[value]>].location>
      - flag server biome_markers_saved.<[value]>.distance:<[distance]>
      - flag server biome_markers_saved.<[value]>.biome:<[biome]>
      - remove <server.flag[biome_markers.<[value]>]>
    - flag server biome_markers:!