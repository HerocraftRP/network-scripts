test_event:
  type: world
  debug: false
  events:
    on time changes in world:
      - flag server test:<util.time_now>

sound_command:
  type: command
  name: sound_location
  debug: false
  usage: /sound_location (sound) (volume) (loop)
  description: dev command
  tab completions:
    1: (sounds,separate,by,comma)
    2: (volume)
    3: (loop)
  script:
    - flag server sound_locations.<player.location.simple>.sound_list:<list[<context.args.get[1]>]>
    - flag server sound_locations.<player.location.simple>.volume:<context.args.get[2]>
    - flag server sound_locations.<player.location.simple>.loop:<context.args.get[3]>
    - run send_to_discord "def:Location<&co> <player.location.simple>"
    - wait 1tn
    - run send_to_discord "def:-<&sp><&sp>sound_list<&co><context.args.get[1]>"
    - run send_to_discord "def:-<&sp><&sp>volume<&co><context.args.get[2]>"
    - run send_to_discord "def:-<&sp><&sp>loop<&co> <context.args.get[3]>"