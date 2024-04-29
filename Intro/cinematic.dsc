start_tutorial:
  type: task
  debug: false
  script:
    - spawn armor_stand[visible=false;marker=true] <server.flag[cinematic.1.start]> save:as
    - define camera <entry[as].spawned_entity>
    - adjust <player> gamemode:spectator
    - wait 1t
    - adjust <player> spectate:<[camera]>
    - run delayed_bridge
    - foreach <server.flag[cinematic.1.location]>:
      - teleport <[camera]> <[value]> offthread_repeat:5 offthread_pitch offthread_yaw
      - teleport <player> <[value]>
      - wait 1t
    - adjust <player> spectate:<player>
    - adjust <player> gamemode:creative
    - remove <[camera]>
    - run toggle_bridge

delayed_bridge:
  type: task
  debug: false
  script:
    - wait 2s
    - run toggle_bridge

record_sequence:
  type: task
  debug: false
  definitions: ID
  script:
    - flag server cinematic.<[ID]>.location:!
    - flag <player> recording:<[ID]>
    - define lastLocation <player.location>
    - narrate "<&e>Recording <[ID]> started"
    - while <player.has_flag[recording]>:
      - if <player.location.distance[<[lastLocation]>]> < 0.05:
        - wait 1t
        - while next
      - flag server cinematic.<[ID]>.location:->:<player.location>
      - define lastLocation:<player.location>
      - wait 1t
    - narrate "<&e>Recording <[ID]> finished"

cinematic_horse_2:
  type: task
  debug: false
  script:
    - adjust <server.flag[cinematic.2.horse.entity]> has_ai:true
    - wait 1t
    - walk <server.flag[cinematic.2.horse.entity]> <server.flag[cinematic.2.horse.mid]>
    - wait 5s
    - walk <server.flag[cinematic.2.horse.entity]> <server.flag[cinematic.2.horse.end]>
    - wait 5s
    - walk <server.flag[cinematic.2.horse.entity]> <server.flag[cinematic.2.horse.mid]>
    - wait 5s
    - walk <server.flag[cinematic.2.horse.entity]> <server.flag[cinematic.2.horse.start]>
    - wait 5s
    - walk <server.flag[cinematic.2.horse.entity]> <server.flag[cinematic.2.horse.reset]>
    - wait 5s
    - walk <server.flag[cinematic.2.horse.entity]> <server.flag[cinematic.2.horse.start]>
    - wait 1.5s
    - adjust <server.flag[cinematic.2.horse.entity]> has_ai:false