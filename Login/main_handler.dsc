lobby_login:
  type: world
  debug: false
  events:
    on server start:
      - ~sql id:players connect:localhost:3306/players?autoReconnect=true username:denizen password:denizen
    on player joins:
      - execute as_server "clearskin <player.name>"
      - ~run sql_get_player_data
      - flag player data.name:!

lobby_send_to_server:
  type: command
  name: join_avalon
  debug: false
  usage: no
  description: Join the main s3rver
  tab completions:
    1: eat
    2: a
    3: fat
    4: dick
    5: Syn
  script:
    #- adjust <queue> linked_player:<server.match_player[<context.args.get[1]>]>
    - if !<player.has_flag[data.name]>:
      - narrate "<&c>You need to choose or create a character first"
      - narrate "<&b>/character select (name)"
      - narrate "<&b>/character new"
      - stop
    - ~run sql_set_player_data
    - adjust <player> send_to:herocraft
