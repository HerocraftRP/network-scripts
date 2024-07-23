offer_corpse_command:
  type: command
  name: offer_corpse
  debug: false
  description: Offer a body to the gods
  tab completions:
    1: <server.flag[god_list]>
  script:
    - if <context.args.size> != 1:
      - narrate "<&c>Which god do you want to offer this to?"
      - stop
    - if !<server.flag[god_list].contains[<context.args.get[1]>]>:
      - narrate "<&c>Unknown God<&co> <context.args.get[1]>"
      - stop
    - if !<player.has_flag[carried_corpse]>:
      - narrate "<&c>You need to carry at a corpse to offer."
      - stop
      ## REMOVE CORPSE PROPERLY
    - flag server god.<context.args.get[1]>.power:+:1
    - narrate "<&e>You have offered the corpse to <context.args.get[1].replace[_].with[<&sp>].to_titlecase>, empowering them."
    - narrate "<&e><player.flag[character.name.full_display]> have offered the corpse, empowering you." targets:<server.online_players.filter[flag[character.god].equals[<context.args.get[1]>]]>
    - run corpse_revive def:<player.flag[dead]> def.new_life:true player:<player.flag[carried_corpse].flag[owner]>
    - run corpse_remove_carried