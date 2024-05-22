admin_mode_spectator:
  type: command
  debug: false
  name: dmsp
  usage: /dmsp
  description: spectator mode, with particles!
  permission: herocraft.dm.spectator
  script:
    - if !<player.has_flag[preferences.color1]>:
      - narrate "<&c>You must set your [preferences.color1] flag, first!"
      - stop
    - if <player.gamemode> != SPECTATOR:
      - flag player dmsp.gamemode:<player.gamemode>
      - adjust <player> gamemode:spectator
      - inject admin_mode_spectator_loop
    - else:
      - adjust <player> gamemode:<player.flag[dmsp.gamemode]>
      - flag player dmsp.gamemode:!

admin_mode_spectator_loop:
  type: task
  debug: false
  script:
    - define targets <player.location.find_players_within[100]>
    - if <player.has_flag[preferences.color2]>:
      - while <player.is_online> && <player.gamemode> == SPECTATOR:
        - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
        - playeffect at:<player.location> quantity:20 effect:REDSTONE offset:0.5 special_data:5|black targets:<[targets]>
        - playeffect at:<player.location> quantity:20 effect:REDSTONE offset:0.5 special_data:1|<player.flag[preferences.color1]> targets:<[targets]>
        - playeffect at:<player.location> quantity:20 effect:REDSTONE offset:0.5 special_data:1|<player.flag[preferences.color2]> targets:<[targets]>
        - wait 2t
    - else if <player.has_flag[preferences.color1]>:
      - while <player.is_online> && <player.gamemode> == SPECTATOR:
        - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
        - playeffect at:<player.location> quantity:20 effect:REDSTONE offset:0.5 special_data:5|black targets:<[targets]>
        - playeffect at:<player.location> quantity:30 effect:REDSTONE offset:0.5 special_data:1|<player.flag[preferences.color1]> targets:<[targets]>
        - wait 2t
