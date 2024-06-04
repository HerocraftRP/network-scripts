offer_command:
  type: command
  name: offer_item
  debug: false
  description: Offer an item to the gods
  tab completions:
    1: <server.flag[god_list]>
  script:
    - if <context.args.size> != 1:
      - narrate "<&c>Which god do you want to offer this to?"
      - stop
    - if !<server.flag[god_list].contains[<context.args.get[1]>]>:
      - narrate "<&c>Unknown God<&co> <context.args.get[1]>"
      - stop
    - define item <player.item_in_hand>
    - take iteminhand
    - flag server god.<context.args.get[1]>.offerings:->:<[item]>
    - narrate "<&e>You have offered the item to <context.args.get[1].replace[_].with[<&sp>].to_titlecase>."
    - define the_god <server.online_players.filter[flag[character.god].equals[<context.args.get[1].to_lowercase>]]||null>
    - if <[the_god]> != null:
      - narrate "<&e>You have received an offering." targets:<[the_god]>

offering_inventory:
  type: inventory
  debug: false
  inventory: chest
  title: <&d>Offerings
  size: 54
  data:
    on_close: offering_inventory_close

offering_inventory_close:
  type: task
  debug: false
  script:
    - define god <player.flag[character.god]>
    - if <context.inventory.list_contents.is_empty>:
      - stop
    - flag server god.<[god]>.offerings:<server.flag[god.<[god]>.offerings].insert[<context.inventory.list_contents>].at[1]>

god_offer_inventory:
  type: command
  name: offer_inventory
  debug: false
  usage: /offer_inventory
  description: View your divine offerings
  permission: herocraft.divine.inventory
  script:
    - if !<player.has_flag[character.god]>:
      - stop
    - define god <player.flag[character.god]>
    - if <server.has_flag[god.<[god]>.offerings]>:
      - define inv <inventory[offering_inventory]>
      - foreach <server.flag[god.<[god]>.offerings].get[1].to[54]>:
        - give <[value]> to:<[inv]>
      - if <server.flag[god.<[god]>.offerings].size> > 54:
        - flag server god.<[god]>.offerings:<server.flag[god.<[god]>.offerings].get[55].to[last]>
      - else:
        - flag server god.<[god]>.offerings:<list[]>
      - inventory open d:<[inv]>
    - else:
      - narrate "<&c>You have no offerings..."