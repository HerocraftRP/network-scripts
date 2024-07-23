get_player_name:
  type: procedure
  debug: false
  definitions: player
  script:
    - define disguise <player.equipment_map.get[helmet].flag[disguise]||null>
    - if <[disguise]> != null:
      - determine <player.flag[data.color]><[disguise]>
    - if <player.has_flag[data.hidden]>:
      - determine <player.flag[data.color]>????
    - determine <player.flag[data.color]><player.flag[data.name]>