send_player_to_right_server:
  type: command
  name: send_player_to_right_server
  debug: false
  usage: NO
  description: NO
  permission: not.a.perm
  script:
    - define target <server.match_player[<context.args.get[1]>]>
    - if <server.flag[hogwarts_players].contains[<[target].uuid>]||false>:
      - adjust <[target]> send_to:hogwarts
    - else:
      - adjust <[target]> send_to:herocraft