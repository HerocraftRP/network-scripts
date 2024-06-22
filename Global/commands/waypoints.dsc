waypoint_armor_stand:
  type: entity
  debug: false
  entity_type: armor_stand
  mechanisms:
    visible: true
    custom_name_visible: true
  flags:
    on_damaged: cancel
    waypoint_marker: true

create_waypoint:
  type: command
  name: create_waypoint
  debug: false
  usage: no
  description: no
  permission: herocraft.admin
  script:
    - define number <server.flag[waypoint_count]||0>
    - define armor_stands <player.location.find_entities[armor_stand].within[12].filter[has_flag[waypoint_marker]]>
    - flag server waypoint_count:<[number].add[1]>
    - spawn waypoint_armor_stand[custom_name=Waypoint_<[number]>] save:as
    - define as <entry[as].spawned_entity>
    - flag server waypoints.<[number]>:<[as]>
    - flag <[as]> waypoint:<[number]>
    - define as_list <list>
    - foreach <[armor_stands]>:
      - if !<[as].can_see[<[value]>]>:
        - foreach next
      - flag <[value]> connected_stands:->:<[number]>
      - define as_list <[as_list].include[<[value].flag[waypoint]>]>
    - flag <[as]> connected_stands:|:<[armor_stands].parse[flag[waypoint]]>
    - narrate "<&e>Waypoint connected to <[as_list].separated_by[, ]>"

remove_waypoint:
  type: command
  name: remove_waypoint
  debug: false
  usage: no
  description: no
  permission: herocraft.admin
  script:
    - define waypoint <player.location.find_entities[armor_stand].within[10].filter[has_flag[waypoint_marker]].first>
    - define number <[waypoint].flag[waypoint]>
    - foreach <[waypoint].flag[connected_stands]>:
      - define stand <server.flag[waypoints.<[value]>]>
      - flag <[stand]> connected_stands:<-:<[number]>
    - flag server waypoints.<[number]>:!
    - remove <[waypoint]>

remove_waypoint_connection:
  type: command
  name: remove_waypoint_connection
  debug: false
  usage: no
  description: no
  permission: herocraft.admin
  script:
    - define waypoint1 <context.args.get[1]>
    - define waypoint2 <context.args.get[2]>
    - define number <[waypoint].flag[waypoint]>
    - define stand1 <server.flag[waypoints.<[waypoint1]>]>
    - define stand2 <server.flag[waypoints.<[waypoint2]>]>
    - flag <[stand1]> connected_stands:<-:<[waypoint2]>
    - flag <[stand2]> connected_stands:<-:<[waypoint1]>

waypoints_output_json:
  type: task
  debug: false
  script:
    - define map <map>
    - repeat 2000:
      - define value <[value].sub[1]>
      - if !<server.has_flag[waypoints.<[value]>]>:
        - repeat next
      - define as <server.flag[waypoints.<[value]>]>
      - define submap <map.with[id].as[<[value]>]>
      - define submap <[submap].with[location].as[<[as].location.simple>]>
      - define submap <[submap].with[connected_stands].as[<[as].flag[connected_stands]>]>
      - define map <[map].with[<[value]>].as[<[submap]>]>
    - ~log <[map].to_json> file:logs/waypoints.json

waypoint_long_term_save:
  type: task
  debug: false
  script:
    - foreach <server.flag[waypoints].keys>:
      - flag server nav_map.<[value]>.connected:<server.flag[waypoints.<[value]>].flag[connected_stands]>
      - flag server nav_map.<[value]>.location:<server.flag[waypoints.<[value]>].location>