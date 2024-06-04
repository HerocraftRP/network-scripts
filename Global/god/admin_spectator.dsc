divine_mode_spectator:
  type: command
  debug: false
  name: dmsp
  usage: /dmsp
  description: spectator mode, with particles!
  permission: herocraft.divine.form
  script:
    - if !<player.has_flag[data.preferences.color1]>:
      - narrate "<&c>You must set your [data.preferences.color1] flag, first!"
      - stop
    - if !<player.has_flag[data.preferences.colorBase]>:
      - narrate "<&c>You must set your [data.preferences.colorBase] flag, first!"
      - stop
    - if !<player.has_flag[character.god]>:
      - narrate "<&c>You lack a divine form, mortal."
      - stop
    - define god_script <script[god_<player.flag[character.god]>]>
    - define power_level <context.args.get[1]> if:<context.args.size.is_more_than[0]||false>
    - if <player.gamemode> != SPECTATOR:
      - flag player dmsp.gamemode:<player.gamemode>
      - adjust <player> gamemode:spectator
      - inject admin_mode_spectator_loop
    - else:
      - ~run divine_mode_spectator_landing
      - adjust <player> gamemode:<player.flag[dmsp.gamemode]>
      - flag player dmsp.gamemode:!

admin_mode_spectator_loop:
  type: task
  debug: false
  definitions: power_level
  data:
    size_settings:
      1:
        size1: 1
        size2: 0.25
        offset1: 0.1,0.1,0.1
        offset2: 0.125,0.125,0.125
        quantity1: 5
        quantity2: 10
      2:
        size1: 1.5
        size2: 0.4
        offset1: 0.15,0.15,0.15
        offset2: 0.175,0.175,0.175
        quantity1: 5
        quantity2: 10
      3:
        size1: 1.5
        size2: 0.4
        offset1: 0.2,0.2,0.2
        offset2: 0.25,0.25,0.25
        quantity1: 10
        quantity2: 15
      4:
        size1: 1.5
        size2: 0.4
        offset1: 0.25,0.25,0.25
        offset2: 0.3,0.3,0.3
        quantity1: 15
        quantity2: 20
      5:
        size1: 1.75
        size2: 0.5
        offset1: 0.3,0.3,0.3
        offset2: 0.35,0.35,0.35
        quantity1: 15
        quantity2: 20
      6:
        size1: 1.75
        size2: 0.5
        offset1: 0.4,0.4,0.4
        offset2: 0.45,0.45,0.45
        quantity1: 15
        quantity2: 20
      7:
        size1: 2.5
        size2: 0.5
        offset1: 0.45,0.45,0.45
        offset2: 0.6,0.6,0.6
        quantity1: 30
        quantity2: 40
      8:
        size1: 2.5
        size2: 0.5
        offset1: 0.5,0.5,0.5
        offset2: 0.6,0.6,0.6
        quantity1: 30
        quantity2: 40
      9:
        size1: 3
        size2: 0.75
        offset1: 0.6,0.6,0.6
        offset2: 0.7,0.7,0.7
        quantity1: 30
        quantity2: 40
      10:
        size1: 5
        size2: 1
        offset1: 0.7,0.7,0.7
        offset2: 0.8,0.8,0.8
        quantity1: 30
        quantity2: 40
  script:
    - define targets <player.location.find_players_within[100]>
    - define power_level <[god_script].data_key[data.power]> if:<[power_level].exists.not>
    - define data <script.data_key[data.size_settings.<[power_level]>]>
    - if <[god_script].data_key[data.color3].exists>:
      - while <player.is_online> && <player.gamemode> == SPECTATOR:
        - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
        - playeffect at:<player.location> quantity:<[data].get[quantity1]> effect:REDSTONE offset:<[data].get[offset1]> special_data:<[data].get[size1]>|<player.flag[data.preferences.colorBase]> targets:<[targets]>
        - playeffect at:<player.location> quantity:<[data].get[quantity2].div[3].round> effect:REDSTONE offset:<[data].get[offset2]> special_data:<[data].get[size2]>|<player.flag[data.preferences.color1]> targets:<[targets]>
        - playeffect at:<player.location> quantity:<[data].get[quantity2].div[3].round> effect:REDSTONE offset:<[data].get[offset2]> special_data:<[data].get[size2]>|<player.flag[data.preferences.color2]> targets:<[targets]>
        - playeffect at:<player.location> quantity:<[data].get[quantity2].div[3].round> effect:REDSTONE offset:<[data].get[offset2]> special_data:<[data].get[size2]>|<player.flag[data.preferences.color3]> targets:<[targets]>
        - wait 2t
    - else if <[god_script].data_key[data.color2].exists>:
      - while <player.is_online> && <player.gamemode> == SPECTATOR:
        - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
        - playeffect at:<player.location> quantity:<[data].get[quantity1]> effect:REDSTONE offset:<[data].get[offset1]> special_data:<[data].get[size1]>|<player.flag[data.preferences.colorBase]> targets:<[targets]>
        - playeffect at:<player.location> quantity:<[data].get[quantity2].div[2].round> effect:REDSTONE offset:<[data].get[offset2]> special_data:<[data].get[size2]>|<player.flag[data.preferences.color1]> targets:<[targets]>
        - playeffect at:<player.location> quantity:<[data].get[quantity2].div[2].round> effect:REDSTONE offset:<[data].get[offset2]> special_data:<[data].get[size2]>|<player.flag[data.preferences.color2]> targets:<[targets]>
        - wait 2t
    - else:
      - while <player.is_online> && <player.gamemode> == SPECTATOR:
        - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
        - playeffect at:<player.location> quantity:<[data].get[quantity1]> effect:REDSTONE offset:<[data].get[offset1]> special_data:<[data].get[size1]>|<player.flag[data.preferences.colorBase]> targets:<[targets]>
        - playeffect at:<player.location> quantity:<[data].get[quantity2]> effect:REDSTONE offset:<[data].get[offset2]> special_data:<[data].get[size2]>|<player.flag[data.preferences.color1]> targets:<[targets]>
        - wait 2t

divine_mode_spectator_landing:
  type: task
  debug: false
  script:
    - while <player.location.below.material.name> == air:
      - adjust <player> velocity:0,-0.2,0
      - adjust <player> fly_speed:0
      - wait 2t
    - adjust <player> fly_speed:0.1
    - define targets <player.location.find_players_within[100]>
    - define god_script <script[god_<player.flag[character.god]>]>
    - repeat 2:
      - playeffect at:<player.location.above[0.5]> quantity:20 effect:REDSTONE offset:0.4,0.6,0.4 special_data:4|<player.flag[data.preferences.colorBase]> targets:<[targets]>
      - playeffect at:<player.location.above[0.5]> quantity:10 effect:REDSTONE offset:0.45,0.65,0.45 special_data:1|<player.flag[data.preferences.color1]> targets:<[targets]>
      - playeffect at:<player.location.above[0.5]> quantity:10 effect:REDSTONE offset:0.45,0.65,0.45 special_data:1|<player.flag[data.preferences.color2]> targets:<[targets]> if:<[god_script].data_key[data.color2].exists>
      - playeffect at:<player.location.above[0.5]> quantity:10 effect:REDSTONE offset:0.45,0.65,0.45 special_data:1|<player.flag[data.preferences.color3]> targets:<[targets]> if:<[god_script].data_key[data.color3].exists>
      - wait 2t