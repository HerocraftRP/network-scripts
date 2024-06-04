goto_command:
  type: command
  name: goto
  debug: false
  tab completions:
    1: <bungee.list_servers>
    permission: herocraft.admin
  script:
    - if <bungee.list_servers.contains[<context.args.get[1]>]>:
      - run tab_list_remove_single
      - ~run sql_set_inventory
      - ~run sql_set_character_data
      - ~run sql_set_player_data
      - adjust <player> send_to:<context.args.get[1]>
    - else:
      - narrate "<&c>Unknown Server"