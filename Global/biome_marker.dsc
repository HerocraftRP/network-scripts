biome_stick:
  type: item
  material: stick
  display name: <&6>Biome Stick
  lore:
  - <&a>Left Click for Point 1
  - <&a>Right Click for Point 2
  - <&e>/markarea (name)
  - <&a>/testbiomes
  - <&e>/removearea (name)
  flags:
    right_click_script: biome_mark_point2
    left_click_script: biome_mark_point1

biome_mark_point1:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - flag player biome.point1:<context.location>
    - narrate "<&e>Point 1 is <context.location.simple>"

biome_mark_point2:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - flag player biome.point2:<context.location>
    - narrate "<&e>Point 2 is <context.location.simple>"

biome_marker_command:
  type: command
  name: markarea
  description: blah
  usage: /markarea (name)
  script:
    - flag server biomes.<context.args.get[1]>:<player.flag[biome.point1].to_cuboid[<player.flag[biome.point2]>]>
    - note <player.flag[biome.point1].to_cuboid[<player.flag[biome.point2]>]> as:biome_<context.args.get[1]>
    - narrate "<&a>Area has been marked as name <context.args.get[1].to_titlecase>"

biome_marker_command_test:
  type: command
  name: testbiomes
  description: blah
  usage: /testbiomes
  script:
    - if <player.has_flag[biome_test]>:
      - flag player biome_test:!
      - narrate "<&e>No longer testing biomes"
    - else:
      - flag player biome_test
      - narrate "<&e>Now testing biomes"

biome_marker_remove:
  type: command
  name: removearea
  description: blah
  usage: /removearea
  script:
    - if <server.has_flag[biomes.<context.args.get[1]>]>:
      - flag server biomes.<context.args.get[1]>:!
      - note remove as:biome_<context.args.get[1]>
      - narrate "<&e>Area has been remove<&co> <context.args.get[1].to_titlecase>"

biome_marker_testing:
  type: world
  debug: false
  events:
    on player enters cuboid flagged:biome_test:
      - if <context.area.note_name.starts_with[biome_]>:
        - title title:<context.area.note_name.after[_].to_titlecase>

mark_biome:
  type: task
  debug: false
  definitions: name
  script:
    - flag server biomes_needed.<[name]>:<player.location>

show_biomes:
  type: task
  debug: false
  script:
    - define playeffect false
    - foreach <server.flag[biomes_needed]>:
      - if <[value].distance[<player.location>]> < 35 :
        - define locations:->:<[value]>
        - narrate "<&a>Showing nearby Biome Marked Location"
        - define playeffect true
        - fakespawn armor_stand[custom_name_visible=true;custom_name=<&a><[key]>] <[value]> duration:1m
    - if <[playeffect]>:
      - repeat 60:
        - wait 5t
        - playeffect effect:dragon_breath quantity:20 at:<server.flag[biomes_needed].values> offset:0.5,0.5,0.5 targets:<player>