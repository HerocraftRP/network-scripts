divine_create:
  type: command
  debug: false
  name: dm_create
  usage: /dm_create (item)
  description: create an item, with flair!
  permission: herocraft.divine.create
  tab completions:
    1: <server.material_types.parse[name].filter[starts_with[<context.args.get[1]||null>]]>
    2: (quantity)
    3: (speed)
  script:
    - define targets <player.location.find_players_within[100]>
    - define target_location <player.location.forward_flat[5]>
    - ~run divine_particles def.location:<player.location.above[0.66].right[0.33]> def.count:30 def.size:1
    - define locations <proc[define_curve1].context[<player.location.above[0.66].right[0.33]>|<[target_location]>|2|90|0.5]>
    - animate <player> animation:ARM_SWING
    - ~run divine_particles def.location_list:<[locations]> def.size:1
    - define location <[locations].last.above[0.2]>
    - ~run divine_particles def.location:<[location]> def.count:30 def.size:2
    - if <context.args.size> > 1 && <context.args.get[2].is_integer>:
      - if <context.args.size> > 2 && <context.args.get[3].is_decimal> && <context.args.get[3]> < 3.1:
        - define speed <context.args.get[3]>
      - else:
        - define speed 1
      - run divine_particles def.location:<[location]> def.count:<context.args.get[2]> def.size:2
      - repeat <context.args.get[2]>:
        - drop <context.args.get[1].parsed> <[location]> speed:2 save:item
        - adjust <entry[item].dropped_entities> velocity:<entry[item].dropped_entities.first.velocity.add[0,<[speed]>,0]>
        - wait 2t
    - else:
      - drop <context.args.get[1].parsed> <[location]> speed:1
      - run divine_particles def.location:<[location]> def.count:10 def.size:2
      - wait 2t

dm_revive:
  type: command
  debug: false
  name: dm_revive
  usage: /dm_revive
  description: resurrect a player
  permission: herocraft.divine.revive
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
      - playeffect at:<[location]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[data.preferences.color1]> targets:<[targets]>
      - wait 2t
    - define target_location <[target].location>
    - define locations <proc[define_curve1].context[<player.location.above[0.66].right[0.33]>|<[target_location]>|2|90|0.5]>
    - animate <player> animation:ARM_SWING
    - define targets <player.location.find_players_within[100]>
    - foreach <[locations]>:
      - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
      - playeffect at:<[value]> quantity:5 effect:REDSTONE offset:0.1 special_data:1|black targets:<[targets]>
      - playeffect at:<[value]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[data.preferences.color1]> targets:<[targets]>
      - wait 2t
    - define targets <player.location.find_players_within[100]>
    - define location <[locations].last.above[0.2]>
    - repeat 30:
      - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
      - playeffect at:<[location]> quantity:20 effect:REDSTONE offset:1 special_data:5|black targets:<[targets]>
      - playeffect at:<[location]> quantity:30 effect:REDSTONE offset:1.25 special_data:1|<player.flag[data.preferences.color1]> targets:<[targets]>
      - wait 2t
    - run corpse_resurrect def:<[target]>

dm_heal:
  type: command
  debug: false
  name: dm_heal
  usage: /dm_heal (target)
  description: heal and feed a player, target is optional.
  permission: herocraft.divine.heal
  tab completions:
    1: <list[self].include[<server.online_players.parsed[flag[data.name]]>]>
  script:
    - if <context.args.size> > 0:
      - if <context.args.get[1]> == self:
        - define target self
      - else:
        - define target <server.match_player[<context.args.get[1]>]||null>
    - else:
      - define target <player.target||null>
    - define targets <player.location.find_players_within[100]>
    # Targets Self
    - if <[target]> == self || <[target]> == null:
      - define target <player>
      - repeat 30:
        - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
        - define location <player.location.above[0.66]>
        - playeffect at:<[location]> quantity:5 effect:REDSTONE offset:0.25,0.75,0.25 special_data:5|black targets:<[targets]>
        - playeffect at:<[location]> quantity:10 effect:REDSTONE offset:0.25,0.75,0.25 special_data:1|<player.flag[data.preferences.color1]> targets:<[targets]>
        - heal <[target]> 1
        - feed <[target]> amount:1
        - adjust <[target]> thirst:<[target].thirst.add[1]>
        - wait 2t
      - stop
    # Targets Others
    - repeat 30:
      - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
      - define location <player.location.above[0.66].right[0.33]>
      - playeffect at:<[location]> quantity:5 effect:REDSTONE offset:0.1 special_data:1|black targets:<[targets]>
      - playeffect at:<[location]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[data.preferences.color1]> targets:<[targets]>
      - wait 2t
    - define target_location <[target].location>
    - define locations <proc[define_curve1].context[<player.location.above[0.66].right[0.33]>|<[target_location]>|2|90|0.5]>
    - animate <player> animation:ARM_SWING
    - define targets <player.location.find_players_within[100]>
    - foreach <[locations]>:
      - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
      - playeffect at:<[value]> quantity:5 effect:REDSTONE offset:0.1 special_data:1|black targets:<[targets]>
      - playeffect at:<[value]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[data.preferences.color1]> targets:<[targets]>
      - define current_location <[value]>
      - foreach stop if:<[loop_index].is_more_than_or_equal_to[<[locations].size.div[2]>]>
      - wait 2t
    - repeat 9999:
      - define current_location <[current_location].points_between[<[target].eye_location>].distance[0.5].get[2]>
      - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
      - playeffect at:<[current_location]> quantity:5 effect:REDSTONE offset:0.1 special_data:1|black targets:<[targets]>
      - playeffect at:<[current_location]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[data.preferences.color1]> targets:<[targets]>
      - repeat stop if:<[current_location].distance[<[target].eye_location>].is_less_than[1.25]>
      - wait 2t
    - define targets <player.location.find_players_within[100]>
    - repeat 20:
      - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
      - playeffect at:<[target].location.above[0.75]> quantity:20 effect:REDSTONE offset:0.25,0.75,0.25 special_data:5|black targets:<[targets]>
      - playeffect at:<[target].location.above[0.75]> quantity:30 effect:REDSTONE offset:0.3,1.05,0.3 special_data:1|<player.flag[data.preferences.color1]> targets:<[targets]>
      - heal <[target]> 1
      - feed <[target]> amount:1
      - adjust <[target]> thirst:<[target].thirst.add[1]>
      - wait 2t

dm_kill:
  type: command
  debug: false
  name: dm_kill
  usage: /dm_kill
  description: kill target
  permission: herocraft.divine.kill
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
      - playeffect at:<[location]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[data.preferences.color1]> targets:<[targets]>
      - wait 2t
    - define target_location <[target].location>
    - define locations <proc[define_curve1].context[<player.location.above[0.66].right[0.33]>|<[target_location]>|2|90|0.5]>
    - animate <player> animation:ARM_SWING
    - define targets <player.location.find_players_within[100]>
    - foreach <[locations]>:
      - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
      - playeffect at:<[value]> quantity:5 effect:REDSTONE offset:0.1 special_data:1|black targets:<[targets]>
      - playeffect at:<[value]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[data.preferences.color1]> targets:<[targets]>
      - define current_location <[value]>
      - foreach stop if:<[loop_index].is_more_than_or_equal_to[<[locations].size.div[2]>]>
      - wait 2t
    - repeat 9999:
      - define current_location <[current_location].points_between[<[target].eye_location>].distance[0.5].get[2]>
      - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
      - playeffect at:<[current_location]> quantity:5 effect:REDSTONE offset:0.1 special_data:1|black targets:<[targets]>
      - playeffect at:<[current_location]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[data.preferences.color1]> targets:<[targets]>
      - repeat stop if:<[current_location].distance[<[target].eye_location>].is_less_than[1.25]>
      - stop if:<[target].is_spawned.not>
      - wait 1t
    - define targets <player.location.find_players_within[100]>
    - repeat 20:
      - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
      - playeffect at:<[target].location.above[0.75]> quantity:20 effect:REDSTONE offset:0.25,0.75,0.25 special_data:5|black targets:<[targets]>
      - playeffect at:<[target].location.above[0.75]> quantity:30 effect:REDSTONE offset:0.3,1.05,0.3 special_data:1|<player.flag[data.preferences.color1]> targets:<[targets]>
      - wait 2t
    - kill <[target]>

dm_events:
  type: world
  debug: false
  events:
    on player starts flying permission:herocraft.divine.flying:
      - stop if:<player.has_flag[character.god].not>
      - wait 1t
      - define targets <player.location.find_players_within[100].exclude[<player>]>
      - if <player.has_flag[data.preferences.color2]>:
        - repeat 999999:
          - if !<player.is_online> || !<player.is_flying>:
            - stop
          - define targets <player.location.find_players_within[100].exclude[<player>]> if:<[value].mod[10].equals[0]>
          - playeffect at:<player.location.above[0.75]> quantity:20 effect:REDSTONE offset:0.15,0.5,0.15 special_data:5|black targets:<[targets]>
          - playeffect at:<player.location.above[0.75]> quantity:20 effect:REDSTONE offset:0.2,0.6,0.2 special_data:1|<player.flag[data.preferences.color1]> targets:<[targets]>
          - playeffect at:<player.location.above[0.75]> quantity:20 effect:REDSTONE offset:0.2,0.6,0.2 special_data:1|<player.flag[data.preferences.color2]> targets:<[targets]>
          - wait 2t
      - else if <player.has_flag[data.preferences.color1]>:
        - repeat 999999:
          - if !<player.is_online> || !<player.is_flying>:
            - stop
          - define targets <player.location.find_players_within[100].exclude[<player>]> if:<[value].mod[10].equals[0]>
          - playeffect at:<player.location.above[0.75]> quantity:20 effect:REDSTONE offset:0.15,0.5,0.15 special_data:5|black targets:<[targets]>
          - playeffect at:<player.location.above[0.75]> quantity:40 effect:REDSTONE offset:0.2,0.6,0.2 special_data:1|<player.flag[data.preferences.color1]> targets:<[targets]>
          - wait 2t
    on player changes gamemode to adventure|survival permission:herocraft.divine.flying:
      - repeat 20:
        - feed <player> amount:1
        - adjust <player> thirst:<player.thirst.add[1]>
        - heal <player> 1
        - wait 3t

dm_arrow_kill:
  type: task
  debug: false
  script:
    - define targets <player.location.find_players_within[100]>
    - if <player.has_flag[data.preferences.color2]>:
      - repeat 30:
        - define location <player.location.above[0.66].right[0.33]>
        - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
        - playeffect at:<[location]> quantity:5 effect:REDSTONE offset:0.1 special_data:1|black targets:<[targets]>
        - playeffect at:<[location]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[data.preferences.color1]> targets:<[targets]>
        - playeffect at:<[location]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[data.preferences.color2]> targets:<[targets]>
        - wait 2t
    - else if <player.has_flag[data.preferences.color1]>:
      - repeat 30:
        - define location <player.location.above[0.66].right[0.33]>
        - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
        - playeffect at:<[location]> quantity:5 effect:REDSTONE offset:0.1 special_data:1|black targets:<[targets]>
        - playeffect at:<[location]> quantity:10 effect:REDSTONE offset:0.1 special_data:0.25|<player.flag[data.preferences.color1]> targets:<[targets]>
        - wait 2t
    - define attack_location <player.location.forward_flat[4].above[20]>
    - define locations <[location].points_between[<[attack_location]>].distance[0.2]>
    - animate <player> animation:ARM_SWING
    - define targets <player.location.find_players_within[100]>
    ## Animate Rising
    - if <player.has_flag[data.preferences.color2]>:
      - foreach <[locations]>:
        - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
        - playeffect at:<[value]> quantity:20 effect:REDSTONE offset:0.15,0.5,0.15 special_data:5|black targets:<[targets]>
        - playeffect at:<[value]> quantity:20 effect:REDSTONE offset:0.2,0.6,0.2 special_data:1|<player.flag[data.preferences.color1]> targets:<[targets]>
        - playeffect at:<[value]> quantity:20 effect:REDSTONE offset:0.2,0.6,0.2 special_data:0.25|<player.flag[data.preferences.color2]> targets:<[targets]>
        - wait 1t
    - else if <player.has_flag[data.preferences.color1]>:
      - foreach <[locations]>:
        - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
        - playeffect at:<[value]> quantity:20 effect:REDSTONE offset:0.15,0.5,0.15 special_data:1|black targets:<[targets]>
        - playeffect at:<[value]> quantity:40 effect:REDSTONE offset:0.2,0.6,0.2 special_data:0.25|<player.flag[data.preferences.color1]> targets:<[targets]>
        - wait 1t
  
    ## Pause
    - define targets <[attack_location].find_players_within[100]>
    - define locations <[attack_location].find_entities[!player].within[50]>
    - if <player.has_flag[data.preferences.color2]>:
      - foreach <[locations]>:
        - define targets <[attack_location].find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
        - playeffect at:<[attack_location]> quantity:20 effect:REDSTONE offset:0.15,0.5,0.15 special_data:2|black targets:<[targets]>
        - playeffect at:<[attack_location]> quantity:20 effect:REDSTONE offset:0.2,0.6,0.2 special_data:1|<player.flag[data.preferences.color1]> targets:<[targets]>
        - playeffect at:<[attack_location]> quantity:20 effect:REDSTONE offset:0.2,0.6,0.2 special_data:1|<player.flag[data.preferences.color2]> targets:<[targets]>
        - wait 2t
    - else if <player.has_flag[data.preferences.color1]>:
      - foreach <[locations]>:
        - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
        - playeffect at:<[attack_location]> quantity:20 effect:REDSTONE offset:0.15,0.5,0.15 special_data:2|black targets:<[targets]>
        - playeffect at:<[attack_location]> quantity:40 effect:REDSTONE offset:0.2,0.6,0.2 special_data:1|<player.flag[data.preferences.color1]> targets:<[targets]>
        - wait 2t
  
    ## Animate Attack
    - define targets <[attack_location].find_players_within[100]>
    - define locations <[attack_location].find_entities[!player].within[50]>
    - if <player.has_flag[data.preferences.color2]>:
      - foreach <[locations]>:
        - define targets <[attack_location].find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
        - playeffect at:<[attack_location].above[0.75]> quantity:20 effect:REDSTONE offset:0.15,0.5,0.15 special_data:2|black targets:<[targets]>
        - playeffect at:<[attack_location].above[0.75]> quantity:20 effect:REDSTONE offset:0.2,0.6,0.2 special_data:1|<player.flag[data.preferences.color1]> targets:<[targets]>
        - playeffect at:<[attack_location].above[0.75]> quantity:20 effect:REDSTONE offset:0.2,0.6,0.2 special_data:1|<player.flag[data.preferences.color2]> targets:<[targets]>
        - spawn arrow <[attack_location]> save:arrow
        - adjust <entry[arrow].spawned_entity> velocity:<[value].eye_location.sub[<[attack_location]>]>
        - wait 2t
    - else if <player.has_flag[data.preferences.color1]>:
      - foreach <[locations]>:
        - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
        - playeffect at:<[attack_location].above[0.75]> quantity:20 effect:REDSTONE offset:0.15,0.5,0.15 special_data:2|black targets:<[targets]>
        - playeffect at:<[attack_location].above[0.75]> quantity:40 effect:REDSTONE offset:0.2,0.6,0.2 special_data:1|<player.flag[data.preferences.color1]> targets:<[targets]>
        - spawn arrow <[attack_location]> save:arrow
        - adjust <entry[arrow].spawned_entity> velocity:<[value].eye_location.sub[<[attack_location]>]>
        - wait 2t

dm_raincloud_command:
  type: command
  debug: false
  name: dm_raincloud
  description: have a raincloud follow you
  permission: herocraft.divine.raincloud
  usage: dm_raincloud
  script:
    - stop if:<player.has_flag[character.god].not>
    - if <player.has_flag[temp.dm.raincloud]>:
      - flag <player> temp.dm.raincloud:!
    - else:
      - flag <player> temp.dm.raincloud
      - run dm_raincloud def:<player>

dm_raincloud:
  type: task
  debug: false
  definitions: target
  script:
    - while <[target].is_online> && <[target].has_flag[temp.dm.raincloud]>:
      - playeffect effect:cloud at:<[target].location.above[3]> quantity:20 offset:0.5,0,0.5 targets:<server.online_players>
      - playeffect effect:water_drop at:<[target].location.above[2.8]> quantity:7 offset:0.5,0,0.5 targets:<server.online_players>
      - wait 2t

dm_wings:
  type: command
  debug: false
  name: dm_wings
  usage: /dm_wings
  description: summon the wings!
  permission: herocraft.divine.wings
  script:
    - stop if:<player.has_flag[character.god].not>
    - define god_script <script[god_<player.flag[character.god]>]>
    - define targets <player.location.find_players_within[100]>
    - ~run divine_particles def.location:<player.location.above[0.7].backward_flat[0.7]> def.count:10 def.size:7
    - if <player.curios_item[back].advanced_matches[*wings]>:
      - adjust <player> curios_item:<list[back|<item[air]>]>
    - else:
      - adjust <player> curios_item:<list[back|<item[<[god_script].data_key[data.wings]>].with_flag[run_script:cancel]>]>

dm_storage_inventory:
  type: inventory
  debug: false
  inventory: chest
  title: <&d>DM Storage
  size: 54
  data:
    on_close: dm_storage_save

dm_storage_save:
  type: task
  debug: false
  script:
    - flag <player> data.inventories.dm_storage:<context.inventory.map_slots>

dm_storage_open:
  type: task
  debug: false
  script:
    - if <context.entity.flag[owner]> != <player.uuid>:
      - stop
    - define inv <inventory[dm_storage_inventory]>
    - if <player.has_flag[data.inventories.dm_storage]>:
      - foreach <player.flag[data.inventories.dm_storage]> key:slot as:item:
        - inventory set slot:<[slot]> o:<[item]> d:<[inv]>
    - inventory open d:<[inv]>

dm_storage_armor_stand:
  type: entity
  debug: false
  entity_type: armor_stand
  mechanisms:
    is_small: true
    gravity: false
    visible: false
  flags:
    on_entity_added: cancel
    right_click_script: dm_storage_open
    on_damaged: cancel

dm_storage:
  type: command
  debug: false
  name: dm_storage
  usage: /dm_storage
  description: Store yer shit
  permission: herocraft.divine.storage
  script:
    - if <player.has_flag[temp.dm_storage]>:
      - flag <player> temp.dm_storage:!
      - stop
    - define location <player.location.forward_flat[3].above[1.5]>
    - define targets <player.location.find_players_within[100]>
    - spawn dm_storage_armor_stand <[location].below[0.4]> save:as
    - flag <entry[as].spawned_entity> owner:<player.uuid>
    - flag player temp.dm_storage
    - if <player.has_flag[data.preferences.color2]>:
      - repeat 999999:
        - repeat stop if:<player.is_online.not>
        - repeat stop if:<player.has_flag[temp.dm_storage].not>
        - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
        - playeffect at:<[location]> quantity:10 effect:REDSTONE offset:0.1,0.1,0.1 special_data:2|black targets:<[targets]>
        - playeffect at:<[location]> quantity:10 effect:REDSTONE offset:0.2,0.2,0.2 special_data:0.5|<player.flag[data.preferences.color1]> targets:<[targets]>
        - playeffect at:<[location]> quantity:10 effect:REDSTONE offset:0.2,0.2,0.2 special_data:0.5|<player.flag[data.preferences.color2]> targets:<[targets]>
        - wait 2t
    - else if <player.has_flag[data.preferences.color1]>:
      - repeat 999999:
        - repeat stop if:<player.is_online.not>
        - repeat stop if:<player.has_flag[temp.dm_storage].not>
        - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
        - playeffect at:<[location]> quantity:10 effect:REDSTONE offset:0.1,0.1,0.1 special_data:2|black targets:<[targets]>
        - playeffect at:<[location]> quantity:10 effect:REDSTONE offset:0.2,0.2,0.2 special_data:0.5|<player.flag[data.preferences.color1]> targets:<[targets]>
        - wait 2t
    - flag player temp.dm_storage:!
    - if <entry[as].spawned_entity.is_spawned>:
      - remove <entry[as].spawned_entity>

divine_particles:
  type: task
  debug: false
  data:
    size_settings:
      1:
        size1: 0.5
        size2: 0.1
        offset1: 0.1,0.1,0.1
        offset2: 0.15,0.15,0.15
        quantity1: 5
        quantity2: 10
      2:
        size1: 1
        size2: 0.2
        offset1: 0.2,0.2,0.2
        offset2: 0.3,0.3,0.3
        quantity1: 10
        quantity2: 20
      3:
        size1: 1.5
        size2: 0.3
        offset1: 0.3,0.3,0.3
        offset2: 0.4,0.4,0.4
        quantity1: 20
        quantity2: 30
      4:
        size1: 2
        size2: 0.4
        offset1: 0.4,0.4,0.4
        offset2: 0.5,0.5,0.5
        quantity1: 20
        quantity2: 30
      5:
        size1: 2.5
        size2: 0.5
        offset1: 0.5,0.5,0.5
        offset2: 0.6,0.6,0.6
        quantity1: 30
        quantity2: 40
      6:
        size1: 2.5
        size2: 0.5
        offset1: 0.5,0.5,0.5
        offset2: 0.6,0.6,0.6
        quantity1: 30
        quantity2: 40
      7:
        size1: 2.5
        size2: 0.5
        offset1: 0.5,0.5,0.5
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
        size1: 2.5
        size2: 0.5
        offset1: 0.5,0.5,0.5
        offset2: 0.6,0.6,0.6
        quantity1: 30
        quantity2: 40
      10:
        size1: 2.5
        size2: 0.5
        offset1: 0.5,0.5,0.5
        offset2: 0.6,0.6,0.6
        quantity1: 30
        quantity2: 40
  definitions: location|count|location_list|size
  script:
    - stop if:<player.has_flag[character.god].not>
    - define god_script <script[god_<player.flag[character.god]>]>
    - if <[size].exists>:
      - define data_map <script.data_key[data.size_settings.<[size]>]>
    - else:
      - define data_map <script.data_key[data.size_settings.<[god_script].data_key[data.power]>]>
    - if !<[location].exists>:
      - define targets <[location_list].first.find_players_within[100]>
    - else:
      - define targets <[location].find_players_within[100]>
    - if !<[location_list].exists>:
      - if <player.has_flag[data.preferences.color3]>:
        - repeat <[count]>:
          - stop if:<player.is_online.not>
          - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity1]> effect:REDSTONE offset:<[data_map].get[offset1]> special_data:<[data_map].get[size1]>|<player.flag[data.preferences.colorBase]> targets:<[targets]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity2]> effect:REDSTONE offset:<[data_map].get[offset2]> special_data:<[data_map].get[size2]>|<player.flag[data.preferences.color1]> targets:<[targets]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity2]> effect:REDSTONE offset:<[data_map].get[offset2]> special_data:<[data_map].get[size2]>|<player.flag[data.preferences.color2]> targets:<[targets]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity2]> effect:REDSTONE offset:<[data_map].get[offset2]> special_data:<[data_map].get[size2]>|<player.flag[data.preferences.color3]> targets:<[targets]>
          - wait 2t
      - else if <player.has_flag[data.preferences.color2]>:
        - repeat <[count]>:
          - stop if:<player.is_online.not>
          - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity1]> effect:REDSTONE offset:<[data_map].get[offset1]> special_data:<[data_map].get[size1]>|<player.flag[data.preferences.colorBase]> targets:<[targets]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity2]> effect:REDSTONE offset:<[data_map].get[offset2]> special_data:<[data_map].get[size2]>|<player.flag[data.preferences.color1]> targets:<[targets]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity2]> effect:REDSTONE offset:<[data_map].get[offset2]> special_data:<[data_map].get[size2]>|<player.flag[data.preferences.color2]> targets:<[targets]>
          - wait 2t
      - else if <player.has_flag[data.preferences.color1]>:
        - repeat <[count]>:
          - stop if:<player.is_online.not>
          - define targets <player.location.find_players_within[100]> if:<[value].mod[10].equals[0]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity1]> effect:REDSTONE offset:<[data_map].get[offset1]> special_data:<[data_map].get[size1]>|<player.flag[data.preferences.colorBase]> targets:<[targets]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity2]> effect:REDSTONE offset:<[data_map].get[offset2]> special_data:<[data_map].get[size2]>|<player.flag[data.preferences.color1]> targets:<[targets]>
          - wait 2t
    - else:
      - if <player.has_flag[data.preferences.color3]>:
        - foreach <[location_list]> as:location:
          - stop if:<player.is_online.not>
          - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity1]> effect:REDSTONE offset:<[data_map].get[offset1]> special_data:<[data_map].get[size1]>|<player.flag[data.preferences.colorBase]> targets:<[targets]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity2]> effect:REDSTONE offset:<[data_map].get[offset2]> special_data:<[data_map].get[size2]>|<player.flag[data.preferences.color1]> targets:<[targets]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity2]> effect:REDSTONE offset:<[data_map].get[offset2]> special_data:<[data_map].get[size2]>|<player.flag[data.preferences.color2]> targets:<[targets]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity2]> effect:REDSTONE offset:<[data_map].get[offset2]> special_data:<[data_map].get[size2]>|<player.flag[data.preferences.color3]> targets:<[targets]>
          - wait 2t
      - else if <player.has_flag[data.preferences.color2]>:
        - foreach <[location_list]> as:location:
          - stop if:<player.is_online.not>
          - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity1]> effect:REDSTONE offset:<[data_map].get[offset1]> special_data:<[data_map].get[size1]>|<player.flag[data.preferences.colorBase]> targets:<[targets]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity2]> effect:REDSTONE offset:<[data_map].get[offset2]> special_data:<[data_map].get[size2]>|<player.flag[data.preferences.color1]> targets:<[targets]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity2]> effect:REDSTONE offset:<[data_map].get[offset2]> special_data:<[data_map].get[size2]>|<player.flag[data.preferences.color2]> targets:<[targets]>
          - wait 2t
      - else if <player.has_flag[data.preferences.color1]>:
        - foreach <[location_list]> as:location:
          - stop if:<player.is_online.not>
          - define targets <player.location.find_players_within[100]> if:<[loop_index].mod[10].equals[0]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity1]> effect:REDSTONE offset:<[data_map].get[offset1]> special_data:<[data_map].get[size1]>|<player.flag[data.preferences.colorBase]> targets:<[targets]>
          - playeffect at:<[location]> quantity:<[data_map].get[quantity2]> effect:REDSTONE offset:<[data_map].get[offset2]> special_data:<[data_map].get[size2]>|<player.flag[data.preferences.color1]> targets:<[targets]>
          - wait 2t

divine_creative_mode:
  type: world
  debug: false
  events:
    on player joins:
      - stop if:<player.has_flag[character.god.creative].not>
      - wait 5s
      - adjust <player> gamemode:creative