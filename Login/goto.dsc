send_to_server:
  type: task
  debug: false
  definitions: server
  script:
    - title "title:<&a>Entering Avalon" fade_in:0t stay:10s
    - if <bungee.list_servers.contains[<[server]>]>:
      - ~run sql_set_player_data
      - wait 1s
      - adjust <player> send_to:<[server]>
    - else:
      - narrate "<&c>Unknown Server"