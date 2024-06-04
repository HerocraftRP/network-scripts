set_prefix:
  type: command
  name: prefix
  debug: false
  usage: /prefix (Character) (Prefix)
  description: Set's a player's prefix for full name
  permission: herocraft.prefix
  tab completions:
    1: <server.flag[name_map].keys.parse_tag[<&dq><[parse_value]><&dq>]>
    2: (Prefix)|clear
  script:
    - define target <server.flag[name_map.<context.args.get[1]>]||null>
    - if <[target]> == null:
      - narrate "<&c>Unknown Player<&co> <context.args.get[1]>"
      - stop
    - if <context.args.get[2]> == clear:
      - flag <[target]> character.name.prefix:!
      - if <[target].has_flag[character.name.suffix]>:
        - flag <[target]> "character.name.full_display:<[target].flag[character.name.color]><[target].flag[character.name.display]><[target].flag[character.name.suffix]>""
      - else:
        - flag <[target]> "character.name.full_display:<[target].flag[character.name.color]><[target].flag[character.name.display]>"
    - else:
      - flag <[target]> character.name.prefix:<context.args.get[2].to[last].separated_by[<&sp>]>
      - if <[target].has_flag[character.name.suffix]>:
        - flag <[target]> "character.name.full_display:<[target].flag[character.name.color]><[target].flag[character.name.prefix]> <[target].flag[character.name.display]><[target].flag[character.name.suffix]>"
      - else:
        - flag <[target]> "character.name.full_display:<[target].flag[character.name.color]><[target].flag[character.name.prefix]> <[target].flag[character.name.display]>"
    - run tab_list_update_single def:<[target]>

set_suffix:
  type: command
  name: suffix
  debug: false
  usage: /suffix (Character) (Prefix)
  description: Set's a palyer's prefix for full name
  permission: herocraft.suffix
  tab completions:
    1: <server.flag[name_map].keys.parse_tag[<&dq><[parse_value]><&dq>]>
    2: (Suffix)|clear
  script:
    - define target <server.flag[name_map.<context.args.get[1]>]||null>
    - if <[target]> == null:
      - narrate "<&c>Unknown Player<&co> <context.args.get[1]>"
      - stop
    - if <context.args.get[2]> == clear:
      - flag <[target]> character.name.suffix:!
      - if <[target].has_flag[character.name.prefix]>:
        - flag <[target]> "character.name.full_display:<[target].flag[character.name.color]><[target].flag[character.name.prefix]> <[target].flag[character.name.display]>"
      - else:
        - flag <[target]> character.name.full_display:<[target].flag[character.name.color]><[target].flag[character.name.display]>
    - else:
      - flag <[target]> character.name.suffix:<context.args.get[2].to[last].separated_by[<&sp>]>
      - if <[target].has_flag[character.name.prefix]>:
        - flag <[target]> "character.name.full_display:<[target].flag[character.name.color]><[target].flag[character.name.prefix]> <[target].flag[character.name.display]><[target].flag[character.name.suffix]>"
      - else:
        - flag <[target]> character.name.full_display:<[target].flag[character.name.color]><[target].flag[character.name.display]><[target].flag[character.name.suffix]>
    - run tab_list_update_single def:<[target]>

set_color:
  type: command
  name: color
  debug: false
  usage: /color (Character) (color_code)
  description: Set's a player's color for name
  permission: herocraft.color
  tab completions:
    1: <server.flag[name_map].keys.parse_tag[<&dq><[parse_value]><&dq>]>
    2: (color_code/color_name)
  script:
    - define target <server.flag[name_map.<context.args.get[1]>]||null>
    - if <[target]> == null:
      - narrate "<&c>Unknown Player<&co> <context.args.get[1]>"
      - stop
    - define color <&color[<context.args.get[2]>]||null>
    - if <[color]> == null:
      - narrate "<&c>Unknown Color<&co> <context.args.get[2]>"
      - stop
    - flag <[target]> character.name.color:<[color]>
    - if <[target].has_flag[character.name.prefix]> && <[target].has_flag[character.name.suffix]>:
      - flag <[target]> "character.name.full_display:<[target].flag[character.name.color]><[target].flag[character.name.prefix]> <[target].flag[character.name.display]><[target].flag[character.name.suffix]>"
    - else if <[target].has_flag[character.name.prefix]>:
      - flag <[target]> "character.name.full_display:<[target].flag[character.name.color]><[target].flag[character.name.prefix]> <[target].flag[character.name.display]>"
    - else if <[target].has_flag[character.name.suffix]>:
      - flag <[target]> character.name.full_display:<[target].flag[character.name.color]><[target].flag[character.name.display]><[target].flag[character.name.suffix]>
    - else:
      - flag <[target]> character.name.full_display:<[target].flag[character.name.color]><[target].flag[character.name.display]>
    - run tab_list_update_single def:<[target]>