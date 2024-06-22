goto_command:
  type: command
  name: goto
  debug: false
  tab completions:
    1: <bungee.list_servers>
  permission: herocraft.goto
  script:
    - if <context.args.size> == 2:
      - define target <server.match_player[<context.args.get[2]>]>
      - adjust <queue> linked_player:<[target]>
    - else:
      - define target <player>
    - if <bungee.list_servers.contains[<context.args.get[1]>]>:
      - run tab_list_remove_single def:<[target]>
      - ~run sql_set_inventory def:<[target]>
      - ~run sql_set_character_data def:<[target]>
      - ~run sql_set_player_data def:<[target]>
      - wait 1s
      - adjust <[target]> send_to:<context.args.get[1]>
    - else:
      - narrate "<&c>Unknown Server"