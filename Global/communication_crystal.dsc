communication_crystal:
  type: item
  debug: false
  display name: <&6>Communication Crystal
  material: herocraft_communication_crystal
  mechanisms:
    custom_model_data: 1
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Give Contact
    - "<&7>___________________"
  flags:
    right_click_script: communication_crystal_use
    interaction:
      1:
        script: communication_give_contact

communication_crystal_clickable:
  type: item
  debug: false
  display name: <&7>ERROR - THIS IS A BUG
  material: stone
  mechanisms:
    custom_model_data: 1
  lore:
    - <&b>Left muscle to call
  flags:
    run_script: communication_crystal_choose_call_type


communication_crystal_call_inventory:
  type: inventory
  title: <&6>Who to call?
  inventory: chest
  size: 54
  data:
    any_click: cancel

communication_crystal_use:
  type: task
  debug: false
  script:
    - ratelimit <player> 2t
    - if <player.has_flag[temp.communication_crystal.call]>:
      - run communication_crystal_end_call def:<player>
    - else:
      - run communication_crystal_choose_call

communication_give_contact:
  type: task
  debug: false
  script:
    - define target <player.precise_target[4]||null>
    - if <[target]> == null:
      - narrate "<&c>You need to look at someone to give your contact info to."
      - stop
    - if <[target].entity_type> != PLAYER:
      - narrate "<&c>They don't want your contact info."
      - stop
    - if <player.target.has_flag[character.known_people.<player.flag[data.name]>_<player.uuid>]>:
      - narrate "<&c>They already have your contact info."
      - stop
    - narrate "<&e>Contact Info given."
    - narrate "<&e>You received Contact Info for <player.flag[data.name]>" targets:<player.target>
    - flag <[target]> character.known_people.<player.flag[data.name]>_<player.uuid>.player:<player>
    - flag <[target]> character.known_people.<player.flag[data.name]>_<player.uuid>.character_name:<player.flag[data.name]>
    - flag <[target]> character.known_people.<player.flag[data.name]>_<player.uuid>.name:<player.flag[character.name.display]>
    - stop

communication_crystal_choose_call_type:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - define target <server.match_player[<context.item.flag[name]>]||null>
    - if <[target].flag[data.name]> != <context.item.flag[character]>:
      - define target null
    - inject communication_crystal_start_call
    # LATER FOR MULTI-SERVER
    #- else:
      #- inject communication_crystal_start_proxy_call

communication_crystal_choose_call:
  type: task
  debug: false
  script:
    - define inv <inventory[communication_crystal_call_inventory]>
    - if !<player.has_flag[character.known_people]>:
      - narrate "<&e>You have no contacts."
      - stop
    - foreach <player.flag[character.known_people].keys> as:uuid:
      - define display_name <player.flag[character.known_people.<[uuid]>.name]>
      - define name <player.flag[character.known_people.<[uuid]>.player].name>
      - define character <player.flag[character.known_people.<[uuid]>.character_name]>
      - give item:<item[communication_crystal_clickable].with[display=<[display_name]>].with_flag[name:<[name]>].with_flag[character:<[character]>]> to:<[inv]>
    - inventory open d:<[inv]>

communication_crystal_start_call:
  type: task
  debug: false
  script:
    - ratelimit <player> 2t
    - determine passively cancelled
    - inventory close
    - if !<[target]> == null || <[target].has_flag[temp.communication_crystal.call]||true>:
      - repeat 2:
        - playsound sound:herocraft:call.busy volume:0.5 <player.location> custom
        - wait 3s
      - stop
    - flag <player> cmd_bypass
    - execute as_op "groups create <player.uuid>" silent
    - flag <player> cmd_bypass:!
    - flag <player> temp.communication_crystal.call.pending.owner:<player>
    - flag <player> temp.communication_crystal.call.pending.target:<[target]>
    - flag <[target]> temp.communication_crystal.call.pending.target:<player>
    - flag <[target]> temp.communication_crystal.call.pending.owner:<player>
    - wait 1t
    - flag <player> cmd_bypass
    - execute as_op "groups invite <[target].name.to_lowercase>" silent
    - flag <player> cmd_bypass:!
    - repeat 20:
      - if !<player.has_flag[temp.communication_crystal.call.pending]>:
        - stop
      - playsound sound:herocraft:call.ring volume:0.5 <player.location> custom
      - playsound sound:herocraft:call.ring volume:0.5 <[target].location> custom
      - wait 3s
    - flag <player> cmd_bypass
    - execute as_op "groups delete" silent
    - flag <player> cmd_bypass:!

communication_crystal_end_call:
  type: task
  debug: false
  definitions: target
  script:
    - if <player.has_flag[temp.communication_crystal.call.active]>:
      - define target <player.flag[temp.communication_crystal.call.active.target]>
    - else:
      - define target <player.flag[temp.communication_crystal.call.pending.target]>
    # Player is on the same server
    - if <[target]> != null:
      - flag <player> cmd_bypass
      - execute as_op "groups delete" silent
      - flag <player> cmd_bypass:!
      - playsound sound:herocraft:call.end <[target].location> volume:.8 custom
      - playsound sound:herocraft:call.end <player.location> volume:.8 custom
      - flag <[target]> temp.communication_crystal.call:!
      - flag <player> temp.communication_crystal.call:!

communication_crystal_catch:
  type: world
  debug: false
  events:
    on groups command:
      - ratelimit <player> 1t
      - if <context.args.get[1]> == join:
        - if <player.has_flag[temp.communication_crystal.call.pending]>:
          - define target <player.flag[temp.communication_crystal.call.pending.owner]>
          - flag <player> temp.communication_crystal.call.active:<player.flag[temp.communication_crystal.call.pending]>
          - flag <[target]> temp.communication_crystal.call.active:<[target].flag[temp.communication_crystal.call.pending]>
          - flag <player> temp.communication_crystal.call.pending:!
          - flag <[target]> temp.communication_crystal.call.pending:!
          - playsound sound:herocraft:call.connect <player.location> volume:.8 custom
          - playsound sound:herocraft:call.connect <[target].location> volume:.8 custom
      - else if !<player.has_flag[cmd_bypass]>:
        - determine fulfilled



# LATER
sql_init_contacts:
  type: task
  debug: false
  script:
    - flag <player> sql_init.inventory
    - ~sql id:players "update:IF NOT EXISTS (SELECT * FROM player_contacts WHERE uuid = '<player.uuid>') BEGIN INSERT INTO player_contacts (uuid, contacts) VALUES ('<player.uuid>', '<player.flag[comm_crytal_contacts]>') END;"


sql_set_contacts:
  type: task
  debug: false
  script:
    - define length <player.curios.items.as[element].length>
    - ~sql id:players "update:UPDATE player_contacts SET uuid = '<player.uuid>', contacts = '<player.flag[comm_crytal_contacts]>' WHERE uuid = '<player.uuid>';"

sql_get_contacts:
  type: task
  debug: false
  script:
    - ~sql id:players "query:SELECT contacts FROM player_contacts WHERE uuid = '<player.uuid>';" save:inv
    - foreach <entry[inv].result_list.first.first>:
      - narrate <&e><[key]><&6><[value]>



communication_crystal_multiserver_data:
  type: command
  name: communication_crystal_multiserver_data
  usage: NO
  description: NO
  permissions: not.a.perm
  data_definitions: (server name) (target name) (data type) (data type arguments)
  debug: false
  script:
    - if <context.args.get[1]> == <server.flag[server.name]>:
      - stop
    - choose <context.args.get[3]>:
      - case CALL_INITIATE:
        - if <context.args.get[1]> == <server.flag[server.name]>:
          - stop
        - define origin_server <context.args.get[1]>
        - define target <server.match_player[<context.args.get[2]>]||null>
        - if <[target]> == null:
          - stop
        - else:
          - define called_by <context.args.get[4]>
          - if <[target].has_flag[temp.communication_crystal.call]>:
            - execute as_op "sync console all communication_crystal_multiserver_data <server.flag[server.name]> <[called_by]> CALL_BUSY"
            - stop
          - if <[target].inventory.slot[9].script.name> == communication_crystal:
            - execute as_op "sync console all communication_crystal_multiserver_data <server.flag[server.name]> <[called_by]> CALL_RECIEVE <[target].name>"
            - flag <[target]> temp.communication_crystal.call.pending.owner:<[called_by]>
            - flag <[target]> temp.communication_crystal.call.pending.target:<[called_by]>
            - repeat 20:
              - if !<player.has_flag[temp.communication_crystal.call.pending]>:
                - stop
              - playsound sound:herocraft:call.ring volume:0.5 <player.location> custom
              - playsound sound:herocraft:call.ring volume:0.5 <[target].location> custom
              - wait 3s
            - execute as_op "sync player <player.name.to_lowercase> groups delete" silent
      - case CALL_BUSY:
        - if <context.args.get[1]> == <server.flag[server.name]>:
          - stop
        - define origin_server <context.args.get[1]>
        - define target <server.match_player[<context.args.get[2]>]||null>
        - if <[target]> == null:
          - stop
        - else:
          - flag <[target]> temp.communication_crystal.call.pending:BUSY
      - case CALL_RECIEVE:
        - if <context.args.get[1]> == <server.flag[server.name]>:
          - stop
        - define origin_server <context.args.get[1]>
        - define callingPlayer <server.match_player[<context.args.get[2]>]||null>
        - define targetName <context.args.get[4]>
        - if <[target]> == null:
          - stop
        - else:
          - execute as_op "sync player <player.name.to_lowercase> groups invite <[targetName]>" silent player:<[callingPlayer]>
      - case CALL_START:
        - if <context.args.get[1]> == <server.flag[server.name]>:
          - stop
        - define origin_server <context.args.get[1]>
        - define callingPlayer <server.match_player[<context.args.get[2]>]||null>
        - define targetName <context.args.get[4]>
        - if <[target]> == null:
          - stop
        - else:
          - execute as_op "sync player <player.name.to_lowercase> groups invite <[targetName].to_lowercase>" silent player:<[callingPlayer]>
      - case CALL_END:
        - define origin_server <context.args.get[1]>
        - define target <server.match_player[<context.args.get[2]>]||null>
        - if <[target]> == null:
          - stop
        - else if <[target].has_flag[temp.communication_crystal]>:
          - playsound sound:herocraft:call.end <[target].location> volume:.8 custom
          - flag <[target]> temp.communication_crystal:!
      - case CALL_ANSWERED:
        - define target <server.match_player[<context.args.get[2]>]||null>
        - playsound sound:herocraft:call.connect <[target].location> volume:.8 custom
        - flag <[target]> temp.communication_crystal.call.active:<[target].flag[temp.communication_crystal.call.pending]>
        - flag <[target]> temp.communication_crystal.call.pending:!