dm_create:
  type: command
  debug: false
  name: dmcreate
  usage: /dmcreate (item)
  description: create an item, with flair!
  permissions: herocraft.dm.create
  tab completions:
    1: <server.material_types.parse[name].filter[starts_with[<context.args.get[1]||null>]]>
  script:
    - define targets <player.location.find_players_within[100]>
    - repeat 30:
      - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
      - define location <player.location.above[0.66].right[0.33]>
      - playeffect at:<[location]> quantity:5 effect:REDSTONE offset:0.1 special_data:1|black targets:<[targets]>
      - playeffect at:<[location]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[preferences.color1]> targets:<[targets]>
      - wait 2t
    - define target_location <player.location.forward_flat[5]>
    - define locations <proc[define_curve1].context[<player.location.above[0.66].right[0.33]>|<[target_location]>|2|90|0.5]>
    - animate <player> animation:ARM_SWING
    - define targets <player.location.find_players_within[100]>
    - foreach <[locations]>:
      - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
      - playeffect at:<[value]> quantity:5 effect:REDSTONE offset:0.1 special_data:1|black targets:<[targets]>
      - playeffect at:<[value]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[preferences.color1]> targets:<[targets]>
      - wait 2t
    - define targets <player.location.find_players_within[100]>
    - define location <[locations].last.above[0.2]>
    - repeat 30:
      - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
      - playeffect at:<[location]> quantity:5 effect:REDSTONE offset:0.1 special_data:2|black targets:<[targets]>
      - playeffect at:<[location]> quantity:10 effect:REDSTONE offset:0.2 special_data:0.5|<player.flag[preferences.color1]> targets:<[targets]>
      - wait 2t
    - drop <context.args.get[1]> <[location]> speed:0

dm_revive:
  type: command
  debug: false
  name: dm_revive
  usage: /dm_revive
  description: resurrect a player
  permissions: herocraft.dm.revive
  script:
    - define target <player.target||null>
    - if <[target]> == null:
      - narrate "<&c>Invalid Target"
      - stop
    - define targets <player.location.find_players_within[100]>
    - repeat 30:
      - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
      - define location <player.location.above[0.66].right[0.33]>
      - playeffect at:<[location]> quantity:5 effect:REDSTONE offset:0.1 special_data:1|black targets:<[targets]>
      - playeffect at:<[location]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[preferences.color1]> targets:<[targets]>
      - wait 2t
    - define target_location <[target].location>
    - define locations <proc[define_curve1].context[<player.location.above[0.66].right[0.33]>|<[target_location]>|2|90|0.5]>
    - animate <player> animation:ARM_SWING
    - define targets <player.location.find_players_within[100]>
    - foreach <[locations]>:
      - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
      - playeffect at:<[value]> quantity:5 effect:REDSTONE offset:0.1 special_data:1|black targets:<[targets]>
      - playeffect at:<[value]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[preferences.color1]> targets:<[targets]>
      - wait 2t
    - define targets <player.location.find_players_within[100]>
    - define location <[locations].last.above[0.2]>
    - repeat 30:
      - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
      - playeffect at:<[location]> quantity:20 effect:REDSTONE offset:1 special_data:5|black targets:<[targets]>
      - playeffect at:<[location]> quantity:30 effect:REDSTONE offset:1.25 special_data:1|<player.flag[preferences.color1]> targets:<[targets]>
      - wait 2t
    - run corpse_resurrect def:<[target]>

dm_heal:
  type: command
  debug: false
  name: dm_heal
  usage: /dm_heal
  description: heal and feed a player
  permissions: herocraft.dm.heal
  script:
    - define target <player.target||null>
    - if <[target]> == null:
      - narrate "<&c>Invalid Target"
      - stop
    - define targets <player.location.find_players_within[100]>
    - repeat 30:
      - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
      - define location <player.location.above[0.66].right[0.33]>
      - playeffect at:<[location]> quantity:5 effect:REDSTONE offset:0.1 special_data:1|black targets:<[targets]>
      - playeffect at:<[location]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[preferences.color1]> targets:<[targets]>
      - wait 2t
    - define target_location <[target].location>
    - define locations <proc[define_curve1].context[<player.location.above[0.66].right[0.33]>|<[target_location]>|2|90|0.5]>
    - animate <player> animation:ARM_SWING
    - define targets <player.location.find_players_within[100]>
    - foreach <[locations]>:
      - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
      - playeffect at:<[value]> quantity:5 effect:REDSTONE offset:0.1 special_data:1|black targets:<[targets]>
      - playeffect at:<[value]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[preferences.color1]> targets:<[targets]>
      - define current_location <[value]>
      - foreach stop if:<[loop_index].is_more_than_or_equal_to[<[locations].size.div[2]>]>
      - wait 2t
    - repeat 9999:
      - define current_location <[current_location].points_between[<[target].eye_location>].distance[0.5].get[2]>
      - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
      - playeffect at:<[current_location]> quantity:5 effect:REDSTONE offset:0.1 special_data:1|black targets:<[targets]>
      - playeffect at:<[current_location]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[preferences.color1]> targets:<[targets]>
      - repeat stop if:<[current_location].distance[<[target].eye_location>].is_less_than[1.25]>
      - wait 2t
    - define targets <player.location.find_players_within[100]>
    - repeat 20:
      - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
      - playeffect at:<[target].location.above[0.75]> quantity:20 effect:REDSTONE offset:0.25,0.75,0.25 special_data:5|black targets:<[targets]>
      - playeffect at:<[target].location.above[0.75]> quantity:30 effect:REDSTONE offset:0.3,1.05,0.3 special_data:1|<player.flag[preferences.color1]> targets:<[targets]>
      - heal <[target]> 1
      - feed <[target]> amount:1
      - wait 2t