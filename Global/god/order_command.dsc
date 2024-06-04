order_invite:
  type: command
  name: order
  debug: false
  usage: /order (invite|list|set_rank)
  data:
    tab:
      invite: <server.flag[name_map].keys.exclude[<player.flag[data.name]>]>
      list: none
      set_rank: <server.flag[name_map].keys>
      kick: <server.flag[groups.order.<player.flag[character.order.name]||null>.names].keys||<list>>
  tab completions:
    1: invite|kick|list|set_rank
    2: <script.parsed_key[data.tab.<context.args.get[1]>]>
  script:
    - if <context.args.is_empty>:
      - narrate "<&c>No Arguments Provided."
      - stop
    - if !<player.has_flag[character.order.name]> && <context.args.get[1]> != accept:
      - narrate "<&c>You are not in an order."
      - stop
    - if !<script.data_key[data.tab.<context.args.get[1]>].exists> && <context.args.get[1]> != accept:
      - narrate "<&c>Unknown Argument: <&b><context.args.get[1]>"
      - stop
    - define order <player.flag[character.order.name]||null>
    - choose <context.args.get[1]>:
      - case invite:
        - define target <server.flag[name_map.<context.args.get[2]>]||null>
        - if <[target]> == null:
          - stop
        - define uuid <util.random_uuid>
        - flag <[target]> temp.order_invite.<[uuid]>:<player.flag[character.order.name]>
        - narrate "<&e>You have invited <context.args.get[2]> to your order."
        - narrate "<&e>You have been invited to the order of <player.flag[character.order.name]>." targets:<[target]>
        - narrate "<&e><element[<&a><&n>Accept].on_click[/order accept <[uuid]>]>" targets:<[target]>
      - case accept:
        - if <context.args.size> < 2:
          - narrate "<&c>Not meant for manual usage."
          - stop
        - define uuid <context.args.get[2]>
        - define order <player.flag[temp.order_invite.<[uuid]>]>
        - narrate "<&e>You have joined the order of <[order]>."
        - narrate "<&e><player.flag[character.name.full_display]> has joined the order of <[order]>." targets:<server.online_players.filter[flag[character.order.name].equals[<[order]>]]>
        - flag <player> character.order.name:<[order]>
        - run group_manager_set_member def:order|<[order]>|<player>|initiate
      - case kick:
        - if <context.args.size> < 2:
          - narrate "<&c>Must specify a member to kick."
          - stop
        - define order <player.flag[character.order.name]>
        - define target_uuid <server.flag[groups.order.<[order]>.names.<context.args.get[2]>]>
        - narrate "<&e>You have kicked <context.args.get[2]> from the order of <[order]>."
        - narrate "<&e><context.args.get[2].replace[_].with[<&sp>].to_titlecase> has been kicked from the order of <[order]>." targets:<server.online_players.filter[flag[character.order.name].equals[<[order]>]]>
        - run group_manager_remove_member def:order|<[order]>|<[target_uuid]>
        - flag <player[<[target_uuid]>]> character.order:!
      - case list:
        - define order <player.flag[character.order.name]>
        - narrate <server.flag[groups.order.<[order]>.names].keys.parse[replace[_].with[<&sp>].to_titlecase].separated_by[<&nl>]>
      - case set_rank:
        - narrate "<&e>Not Yet Implemented"