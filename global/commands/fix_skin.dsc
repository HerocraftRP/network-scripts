fix_skin_command:
  type: command
  name: fix_skin
  debug: false
  usage: /fix_skin
  description: Fix your skin
  script:
    - execute as_server "setskin <player.flag[character.skin]> <player.name>"