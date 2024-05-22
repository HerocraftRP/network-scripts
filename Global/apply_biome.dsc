apply_biome_toggle:
  type: task
  debug: false
  definitions: biomeName|size
  script:
    - if !<[size].exists>:
      - define size 6
    - if <player.has_flag[applying_biome]>:
      - flag <player> applying_biome:!
    - else:
      - flag <player> applying_biome:<[biomeName]>
      - define biome <biome[<[biomeName]>]>
      - narrate <[biome]>
      - wait 2t
      - while <player.has_flag[applying_biome]>:
        - if <player.eye_location.material.name> == air:
          - define location <player.eye_location>
        - else if <player.location.material.name> == air:
          - define location <player.location>
        - else:
          - wait 1t
          - while next
        - adjust <[location].flood_fill[<[size]>]> biome:<[biome]>
        - narrate "<&a>Adjusting Biome to: <[biome].name>"
        - wait 2t

apply_biome_teleport:
  type: task
  debug: false
  definitions: number
  script:
    - define target_loc <server.flag[biomes_needed.<server.flag[biomes_needed].keys.get[<[number]>]>]>
    - define name <server.flag[biomes_needed].keys.get[<[number]>]>
    - narrate "<&6>Biome Name<&co> <&e><[name]>"
    - teleport <player> <[target_loc]>

apply_biome_mark_location:
  type: command
  debug: false
  name: mark_biome
  usage: /mark_biome
  description: marks a biome to be placed here
  permission: herocraft.admin
  script:
    - flag server biome_locations.<context.args.get[1]>:->:<player.location>

apply_biomes_to_location:
  type: task
  debug: false
  script:
    - foreach <server.flag[biome_locations]> key:biome_name as:locations:
      - foreach <[location]> as:block:
        - adjust <[block].flood_fill[10]> biome:<biome[herocraft:<[biome_name]>]>
        - wait 1t