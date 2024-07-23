tablist_update:
  type: task
  debug: true
  script:
    - define player_list <list>
    - if <server.flag[network_player_map].keys.size> == 0:
      - stop
    - foreach <server.flag[network_player_map].keys>:
      - define player_list <[player_list].include[<server.flag[network_player_map.<[value]>.display]>]>
    - flag server tablist:<[player_list]>
    - run tablist_propogate

tablist_propogate:
  type: task
  debug: true
  script:
    - foreach <bungee.list_servers.exclude[controller|login]>:
      - bungeerun <[value]> tablist_update def:<list_single[<server.flag[tablist]>]>

tablist_update_player:
  type: task
  debug: true
  definitions: uuid|display
  script:
    - flag server network_player_map.<[uuid]>.display:<[display]>
    - run tablist_update

tablist_events:
  type: world
  debug: true
  events:
    on bungee player leaves network:
      - flag server network_player_map.<context.uuid>:!
      - run tablist_update
    on bungee player switches to server:
      - if <server.has_flag[network_player_map.<context.uuid>]>:
        - flag server network_player_map.<context.uuid>.server:<context.server>