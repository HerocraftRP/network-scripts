locals_data:
  type: data
  data:
    day:
      minimum: 500
      maximum: 700
    dusk:
      minimum: 500
      maximum: 700
    dawn:
      minimum: 500
      maximum: 700
    night:
      minimum: 500
      maximum: 700
    minimum: 9999
    maximum: 9999
    hats_by_profession:
      RANDOM:
        - chainmail_helmet
        - iron_helmet
        - turtle_helmet
        - irons_spellbooks_pumpkin_helmet
        - epicfight_stray_hat
        - diamond_helmet
        - alexsmobs_froststalker_helmet
        - tconstruct_plate_helmet
        - air
        - air
        - air
        - air
      #ARMORER:
      #BUTCHER:
      #CARTOGRAPHER:
      #CLERIC:
      #FARMER:
      #FLETCHER:
      #LEATHERWORKER:
      #LIBRARIAN:
      #MASON:
      #NITWIT:
      #NONE:
      #SHEPHERD:
      #TOOLSMITH:
      #WEAPONSMITH:  

create_fancy_local:
  type: task
  debug: false
  definitions: LocationID
  script:
    - execute as_server "summon easy_npc:humanoid <[location].x> <[location].y> <[location].z>  {Rotation: [<[location].yaw>f, 0.0f]}"
    - define local <[location].find_entities[easy_npc_humanoid].within[0.5].first>

create_local:
  type: task
  debug: false
  definitions: locationID
  data:
    types: <list[DESERT|JUNGLE|PLAINS|SAVANNA|SNOW|SWAMP|TAIGA]>
    professions: <list[ARMORER|BUTCHER|CARTOGRAPHER|CLERIC|FARMER|FISHERMAN|FLETCHER|LEATHERWORKER|LIBRARIAN|MASON|NITWIT|NONE|SHEPHERD|TOOLSMITH|WEAPONSMITH]>
  script:
    - define local <entity[villager]>
    - define location <server.flag[local_locations.<[locationID]>.location]>
    - spawn villager <server.flag[local_locations.<[locationID]>.location].with_pitch[<util.random.decimal[-10].to[10]>]> save:local
    - define local <entry[local].spawned_entity>
    #- execute as_server "summon easy_npc:humanoid <[location].x> <[location].y> <[location].z>  {Rotation: [<[location].yaw>f, 0.0f]}"
    #- define local <[location].find_entities[easy_npc_humanoid].within[0.5].first>
    - adjust <[local]> max_health:6
    - adjust <[local]> health:6
    - adjust <[local]> has_ai:false
    - adjust <[local]> persistent:true
    #- adjust <[local]> custom_name:<&7>Local
    - define profession <server.flag[locals.<[locationID]>.profession]||RANDOM>
    - if <[profession]> == RANDOM:
      - define profession <script.parsed_key[data.professions].random>
    - define type <server.flag[locals.<[locationID]>.type]||RANDOM>
    - if <[type]> == RANDOM:
      - define type <script.parsed_key[data.types].random>
    #- define hat <server.flag[locals.<[locationID]>.hat]||RANDOM>
    #- if <[hat]> == RANDOM:
      #- define hat <script[locals_data].parsed_key[data.hats_by_profession.RANDOM].random>
    - adjust <[local]> color:<[type]>
    - adjust <[local]> profession:<[profession]>
    #- equip <[local]> head:<[hat]>
    - flag <[local]> on_damaged:local_call_for_help
    - flag <[local]> on_death:no_drops
    - flag <[local]> on_spawn:villager_spawn_check
    - flag <[local]> locationID:<[locationID]>
    - flag <[local]> right_click_script:local_interact
    - flag server local_locations.<[LocationID]>.local:<[local]>
    - flag server locals:->:<[local]>

villager_spawn_check:
  type: task
  debug: false
  script:
    - if <server.flag[local_locations.<context.entity.flag[LocationID]>.local]> != <context.entity>:
      - determine cancelled

local_autospawn:
  type: task
  debug: false
  definitions: amountTotal
  script:
    - foreach <server.flag[local_locations]> as:locationData:
      - define location <[locationData].get[location]>
      - if !<server.flag[local_locations.<[key]>.local].exists>:
        - run create_local def:<[key]>
        - define amountCurrent:++
        - stop if:<[amountCurrent].equals[<[amountTotal]>]>
      - wait 5t

no_drops:
  type: task
  debug: false
  script:
    - determine NO_DROPS

sanitize_locals:
  type: task
  debug: false
  script:
    - stop if:<server.has_flag[locals].not>
    - foreach <server.flag[locals]>:
      - if !<[value].is_spawned>:
        - flag server locals.<[key]>:!

local_manager:
  type: world
  debug: false
  events:
    on delta time minutely every:15:
      - if !<server.has_flag[locals]>:
          - run local_autospawn def:<script[locals_data].data_key[data.maximum]>
          - stop
      - if <server.flag[locals].size> < <script[locals_data].data_key[data.minimum]>:
          - run local_autospawn def:<script[locals_data].data_key[data.maximum].sub[<server.flag[locals].size>]>

remove_local:
  type: task
  debug: false
  definitions: local
  script:
    - define LocationID <[local].flag[LocationID]>
    - flag server local_locations.<[LocationID]>.local:!
    - remove <[local]>

mark_local_command:
  type: command
  name: local_mark_spawn
  debug: false
  description: mark where you stand for a spot for local spawn
  usage: /local_mark_spawn
  script:
    - define UUID <util.random_uuid>
    - flag server local_locations.<[uuid]>.location:<player.location>
    - narrate "<&e>This location has been marked for a local to spawn."
    - run create_local def:<[uuid]>

local_purge:
  type: command
  name: local_purge
  debug: false
  description: remove a local spawn spot
  usage: /local_purge
  script:
    - foreach <server.flag[local_locations].keys>:
      - run remove_local def:<server.flag[local_locations.<[value]>.local]>

remove_local_command:
  type: command
  name: local_remove_spawn
  debug: false
  description: remove a local spawn spot
  usage: /local_remove_spawn
  script:
    - foreach <server.flag[local_locations]>:
      - if <[value].get[location].distance[<player.location>]> < 1 :
        - flag server local_locations.<[key]>:!
        - narrate "<&e>Local Spawn Location has been deleted."

visualize_local_command:
  type: command
  name: local_show_spawns
  debug: false
  description: show local spawn spots nearby
  usage: /local_show_spawns
  script:
    - foreach <server.flag[local_locations]>:
      - if <[value].get[location].distance[<player.location>]> < 25 :
        - define locations:->:<[value].get[location]>
    - if <[locations].size> > 1:
      - foreach <[locations]>:
        - narrate "<&a>Showing nearby Local Spawn Locations"
        - fakespawn armor_stand[custom_name_visible=true;custom_name=<&a>LocalSpawnLocation>] <[value].above[1.5]> duration:1m
    - repeat 60:
      - wait 5t
      - playeffect effect:dragon_breath quantity:20 at:<[locations]> offset:0.5,0.5,0.5 targets:<player>


local_set_type:
  type: command
  name: local_set_type
  debug: false
  description: set local variant
  usage: /local_set_type
  tab completions:
    1: RANDOM|DESERT|JUNGLE|PLAINS|SAVANNA|SNOW|SWAMP|TAIGA
  script:
    - define target <player.target||null>
    - if <[target]> == null:
      - narrate "<&c>Look at the target local."
      - stop
    - define LocationID <[target].flag[LocationID]>
    - flag server local_locations.<[LocationID]>.type:<context.args.get[1]>
    - adjust <[target]> color:<context.args.get[1]>
    - narrate "<&e>Spawn location permanently changed to this profession"

local_set_profession:
  type: command
  name: local_set_profession
  debug: false
  description: set local variant
  usage: /local_set_profession
  tab completions:
    1: RANDOM|ARMORER|BUTCHER|CARTOGRAPHER|CLERIC|FARMER|FISHERMAN|FLETCHER|LEATHERWORKER|LIBRARIAN|MASON|NITWIT|NONE|SHEPHERD|TOOLSMITH|WEAPONSMITH
  script:
    - define target <player.target||null>
    - if <[target]> == null:
      - narrate "<&c>Look at the target local."
      - stop
    - define LocationID <[target].flag[LocationID]>
    - flag server local_locations.<[LocationID]>.profession:<context.args.get[1]>
    - adjust <[target]> profession:<context.args.get[1]>
    - narrate "<&e>Spawn location permanently changed to this type"

local_call_for_help:
  type: task
  debug: false
  script:
    - flag server locals_killed:++
    - flag server local_locations.<context.entity.flag[LocationID]>.local:!
    #- run ping_guards def:<context.entity.location>|local_assaulted

local_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - ratelimit <player> 2t
    - if <player.has_flag[temp.job]> && <player.flag[temp.job.name]> == mugging && <player.item_in_hand.material.name> != air:
      - run start_timed_action "def:<&c>Robbing Local|10s|rob_local|<context.entity>" def.can_move:false def.animation_task:rob_local_animation

rob_local_animation:
  type: task
  debug: false
  script:
    - animate <player> animation:ARM_SWING

rob_local:
  type: task
  debug: false
  definitions: local
  script:
    - if <[local].has_flag[last_robbed]>:
      - if <[local].flag[last_robbed].from_now.is_less_than[10m]>:
        - narrate "<&e>The local did not have any money."
        - stop
    - if <util.random_chance[75]>:
      - narrate "<&c>You got caught!!"
      - stop
      - bossbar update timed_action_<player.uuid> title:<&c>Failed! progress:1 color:RED
      - wait 3s
      - if !<player.has_flag[timed_action]> && <player.bossbar_ids.contains[timed_action_<player.uuid>]>:
        - bossbar remove timed_action_<player.uuid>
      - stop
    - flag <[local]> last_robbed:<util.time_now>
    - run job_get_rep def:mugging|0.1
    - narrate "<&e>Succesfully robbed Local"
    - give <item[calemieconomy_coin_copper]>