set_name:
  type: command
  name: setname
  description: Set your name
  usage: /setname (first name) (last name)
  debug: false
  script:
    - if <player.has_flag[name]>:
      - narrate "<&c>You are unable to rename yourself this way."
      - stop
    - if <context.args.size> < 2:
      - narrate "<&c>Requires More Arguments"
      - narrate "<&e>/setname (first name) (last name)"
      - stop
    - if <context.args.size> > 2:
      - narrate "<&c>Requires Less Arguments"
      - narrate "<&e>/setname (first name) (last name)"
      - stop
    - flag <player> name.first:<context.args.get[1].to_titlecase>
    - flag <player> name.last:<context.args.get[2].to_titlecase>
    - narrate "<&a>You are here-by known as <&6><context.args.get[1].to_titlecase> <context.args.get[2].to_titlecase>"