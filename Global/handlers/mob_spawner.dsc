spawn_group_template:
  type: data
  entities:
    - ALEXSMOBS_GRIZZLY_BEAR
    - ALEXSMOBS_GRIZZLY_BEAR
    - ALEXSMOBS_GRIZZLY_BEAR

mob_spawner:
  type: entity
  debug: false
  entity_type: armor_stand
  mechanisms:
    visible: true
    marker: false
    gravity: false
    custom_name_visible: true
    custom_name: Mob Spawner <&b>(RMB)
  flags:
    right_click_script: mob_spawner_narrate
    on_entity_added: <list[mob_spawner_check_state|mob_spawner_try_spawn]>

mob_spawner_check_state:
  type: task
  debug: false
  definitions: entity
  script:
    - wait 1t
    - define entity <context.entity> if:<[entity].exists.not>
    - if !<server.has_flag[mob_spawners.<context.entity.flag[spawner_id]>]>:
      - remove <context.entity>
      - stop
    - if <server.has_flag[show_spawners]>:
      - teleport <[entity]> <[entity].flag[original_location]>
      - adjust <[entity]> visible:true
      - adjust <[entity]> marker:false
      - adjust <[entity]> gravity:false
      - adjust <[entity]> custom_name_visible:true
    - else:
      - teleport <[entity]> <[entity].flag[original_location].below[5]>
      - adjust <[entity]> visible:false
      - adjust <[entity]> marker:true
      - adjust <[entity]> gravity:false
      - adjust <[entity]> custom_name_visible:false

mob_spawner_try_spawn:
  type: task
  debug: false
  script:
    - wait 10s
    - while <context.entity.is_spawned||false>:
      - stop if:<context.entity.if_null[null].equals[null]>
      - if <context.entity.has_flag[spawned]>:
        - foreach <context.entity.flag[spawned]>:
          - if !<[value].is_spawned||false>:
            - flag <context.entity> spawned:<-:<[value]>
            - foreach next
          - if <[value].location.distance[<[value].flag[spawner].location>]> > 15:
            - flag <context.entity> spawned:<-:<[value]>
      - if <context.entity.flag[spawned].size||0> < 2:
        - define type <server.flag[mob_spawners.<context.entity.flag[spawner_id]>.type]>
        - define script <script[spawn_group_<[type]>]>
        - stop if:<script[spawn_group_<[type]>].exists.not>
        - define key <[script].data_key[day].keys.random>
        - if <util.random_chance[<server.flag[mob_spawners.<context.entity.flag[spawner_id]>.chance]>]>:
          - foreach <script[spawn_group_<[type]>].data_key[day.<[key]>]> as:entity:
            - modspawn entity:<entity[<[entity]>]> location:<context.entity.flag[original_location]> save:spawned
            - wait 4t
            - if <context.entity.is_spawned> && <entry[spawned].entity.is_spawned>:
              - adjust <entry[spawned].entity> force_no_persist:false
              - flag <entry[spawned].entity> spawner:<context.entity>
              - flag <entry[spawned].entity> on_entity_added:mob_spawner_check_mob
              - flag <entry[spawned].entity> on_damaged:mob_spawner_check_mob_alive
              - flag <context.entity> spawned:->:<entry[spawned].entity>
      - wait 1m

mob_no_xp:
  type: world
  debug: false
  events:
    on entity dies bukkit_priority:lowest:
      - determine passively NO_XP
      - determine passively NO_DROPS
      - if <context.entity.has_flag[drops]>:
        - drop <context.entity.flag[drops]> <context.entity.location>

mob_spawner_check_mob:
  type: task
  debug: false
  script:
    - wait 1s
    - if !<context.entity.is_spawned>:
      - stop
    - if !<context.entity.has_flag[spawner]>:
      - remove <context.entity>
      - stop
    - if !<context.entity.flag[spawner].is_spawned>:
      - remove <context.entity>
      - stop
    - if !<context.entity.flag[spawner].has_flag[spawned]>:
      - remove <context.entity>
      - stop
    - if !<context.entity.flag[spawner].flag[spawned].contains[<context.entity>]>:
      - remove <context.entity>
      - stop

mob_spawner_check_mob_alive:
  type: task
  debug: false
  script:
    - define spawner <context.entity.flag[spawner]>
    - wait 2t
    - if !<context.entity.is_spawned>:
      - flag <[spawner]> spawned:<-:<context.entity>

mob_spawner_create:
  type: task
  debug: false
  script:
    - spawn mob_spawner <player.location> save:as
    - define id <server.flag[mob_spawner_count]||0>
    - flag <entry[as].spawned_entity> original_location:<player.location>
    - flag <entry[as].spawned_entity> spawner_id:<[id]>
    - flag server mob_spawners.<[id]>.type:none
    - flag server mob_spawners.<[id]>.chance:0
    - flag server mob_spawner_count:+:1
    - run mob_spawner_try_spawn

mob_spawner_narrate:
  type: task
  debug: false
  definitions: entity
  script:
    - define entity <context.entity> if:<[entity].exists.not>
    - narrate "<element[TYPE<&co> <server.flag[mob_spawners.<[entity].flag[spawner_id]>.type]>].on_click[/mob_spawner_set <[entity].flag[spawner_id]> TYPE ].type[SUGGEST_COMMAND]>"
    - narrate "<element[CHANCE<&co> <server.flag[mob_spawners.<[entity].flag[spawner_id]>.chance]>].on_click[/mob_spawner_set <[entity].flag[spawner_id]> CHANCE ].type[SUGGEST_COMMAND]>"

set_mob_spawner:
  type: command
  name: mob_spawner_set
  debug: false
  script:
    - define spawner_id <context.args.get[1]>
    - define key <context.args.get[2]>
    - define value <context.args.get[3]>
    - flag server mob_spawners.<[spawner_id]>.<[key]>:<[value]>
    - narrate "<&e>Mob Spawner has had it's <[key]> key set to <[value]>."