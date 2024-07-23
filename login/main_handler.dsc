lobby_login:
  type: world
  debug: false
  events:
    after server start:
      - wait 1s
      - ~sql id:players connect:localhost:3306/players?autoReconnect=true username:denizen password:denizen
    on player joins:
      - execute as_server "clearskin <player.name>"
      - ~run sql_get_player_data
      - flag player data.name:!
