tablist_update:
  type: task
  debug: false
  definitions: list
  script:
    - flag server tablist:<[list]>
    - foreach <server.online_players>:
      - adjust <[value]> tab_list_info:<[list].separated_by[<&nl>]>

tablist_on_join:
  type: world
  debug: false
  events:
    on player joins:
      - adjust <player> tab_list_info:<server.flag[tablist].separated_by[<&nl>]>