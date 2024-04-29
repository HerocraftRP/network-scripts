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

apply_biome_mark_bad_spot:
  type: command
  debug: false
  name: report_bad_biome
  usage: /report_bad_biome
  description: reports an area needing biome work to Xeane
  script:
    - flag server bad_biomes:->:<player.location>