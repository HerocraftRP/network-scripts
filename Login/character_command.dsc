temporary_character_creation:
  type: command
  name: character
  debug: false
  usage: /character (bunch of shit)
  description: control of your character
  data:
    tab:
      select: <player.flag[data.characters].keys.parse[after[_]]>
      first_name: (name)
      last_name: (name)
      skin: (url_to_skin)
      save: none
      skin_code: (skin_code)
      new: none
    skin_codes:
      Gsa5gB: https://herocraft.world/images/henric.png
      aj_4real: https://herocraft.world/images/aj_skin.png
      lds1: https://herocraft.world/images/LDS1.png
      lds2: https://herocraft.world/images/lds2.png
      drew1: https://herocraft.world/images/drew1.png
      unsens1: https://herocraft.world/images/unsensical.png
      lookatthisgod: https://herocraft.world/images/drew_god.png
      tsukia1: https://herocraft.world/images/player_tsukia.png
      redmason: https://herocraft.world/images/player_red.png
      nemaito: https://herocraft.world/images/player_nemaito.png
      watta: https://herocraft.world/images/god_syn.png
  tab completions:
    1: select|first_name|last_name|skin|save|skin_code|new
    2: <script.parsed_key[data.tab.<context.args.get[1]>]||<list[]>>
  script:
    - if <context.args.is_empty>:
      - narrate "<&c>Invalid arguments, cannot be empty."
      - stop
    - if !<script.data_key[data.tab].keys.contains[<context.args.get[1]>]>:
      - narrate "<&c>Unknown argument 1<&co> <context.args.get[1]>."
      - stop
    - if <context.args.get[2]||null> == null && <context.args.get[1]> != save && <context.args.get[1]> != new:
      - narrate "<&c>You need more arguments."
      - stop
    - if <context.args.get[1]> != new && !<player.has_flag[temp.character_creation]> && <context.args.get[1]> != select:
      - narrate "<&c>You need to start character creation first."
      - narrate "<&b>/character new"
      - stop
    - choose <context.args.get[1]>:
      # Start New Character
      - case new:
        - teleport <player.flag[character_location].with_yaw[180].backward_flat[7]>
        - run create_new_character_start
        - stop
      # Change Character
      - case select:
        - if !<player.has_flag[data.characters.<player.uuid>_<context.args.get[2]>]>:
          - narrate "<&c>Unknown Character<&co> <context.args.get[2]>"
          - stop
        - run temporary_character_change def:<context.args.get[2]>
      #Set First Name
      - case first_name:
        - flag player temp.new_character.first_name:<context.args.get[2].to_titlecase>
        - narrate "<&e>New character first name prepared as <&b><context.args.get[2].to_titlecase>"
        - adjust <player.flag[temp.character_creation.first_name_stand]> custom_name:<context.args.get[2].to_titlecase>
        - stop
      #Set Last Name
      - case last_name:
        - flag player temp.new_character.last_name:<context.args.get[2].to_titlecase>
        - narrate "<&e>New character last name prepared as <&b><context.args.get[2].to_titlecase>"
        - adjust <player.flag[temp.character_creation.last_name_stand]> custom_name:<context.args.get[2].to_titlecase>
        - stop
      #Set Skin
      - case skin:
        - if !<context.args.get[2].starts_with[https]>:
          - narrate "<&c>Skin URL must start with 'HTTPS'."
          - stop
        - flag player temp.new_character.skin:<context.args.get[2]>
        - execute as_server "setskin <context.args.get[2]> <player.name>"
        - narrate "<&e>Skin set to URL from<&co> <&b><context.args.get[2].to_titlecase>"
        - adjust <player.flag[temp.character_creation.skin_stand]> "custom_name:<&a>Set to URL!"
        - narrate "<&6>Use <&b>/character save <&6>to save the character, and change in to it."
        - stop
      #Skin Codes
      - case skin_code:
        - if !<script.data_key[data.skin_codes].keys.contains[<context.args.get[2]>]>:
          - narrate "<&c>Unknown Skin Code<&co> <&b><context.args.get[2]><&c>."
          - stop
        - flag player temp.new_character.skin:<script.parsed_key[data.skin_codes.<context.args.get[2]>]>
        - execute as_server "setskin <script.parsed_key[data.skin_codes.<context.args.get[2]>]> <player.name>"
        - narrate "<&e>Skin set to Skin Code."
        - narrate "<&6>Use <&b>/character save <&6>to save the character, and change in to it."
        - stop
      #Save Character
      - case save:
        - if !<player.has_flag[temp.new_character.first_name]>:
          - narrate "<&c>Your new character needs a First Name."
          - narrate "<&6>Use <&b>/character first_name <&6>to set their first name."
          - stop
        - if !<player.has_flag[temp.new_character.skin]>:
          - narrate "<&c>Your new character needs a Skin."
          - narrate "<&6>Use <&b>/character skin <&6>to set their skin."
          - stop
        - remove <player.flag[temp.character_creation.entities]>
        - define last_as <player.flag[temp.character_creation.top_most_stand]>
        - adjust <[last_as]> "custom_name:<&e>Character <&b><player.flag[character.name.display]> <&e>has been saved."
        - flag player temp.character_creation:!
        - run temporary_character_initialize
        - run create_new_character_start_buttons
        - wait 4s
        - remove <[last_as]>

temporary_character_initialize:
  type: task
  debug: false
  script:
    - inventory clear
    - flag player character:!
    - if <player.has_flag[temp.new_character.last_name]>:
      - flag player data.name:<player.flag[temp.new_character.first_name]>_<player.flag[temp.new_character.last_name]>
    - else:
      - flag player data.name:<player.flag[temp.new_character.first_name]>
    - flag player character.name.first:<player.flag[temp.new_character.first_name]>
    - if <player.has_flag[temp.new_character.last_name]>:
      - flag player "character.name.display:<player.flag[temp.new_character.first_name]> <player.flag[temp.new_character.last_name]>"
      - flag player character.name.last:<player.flag[temp.new_character.last_name]>
    - else:
      - flag player character.name.display:<player.flag[temp.new_character.first_name]>
    - flag player character.name.color:<&7>
    - flag player character.skin:<player.flag[temp.new_character.skin]>
    - execute as_server "setskin <player.flag[character.skin]> <player.name>"
    - flag player character.name.full_display:<&7><player.flag[character.name.display]>
    - flag player character.knowledge.total:25
    - flag player character.knowledge.current:25
    - flag player character.vision_level:1
    - flag player data.characters.<player.uuid>_<player.flag[data.name]>.initialized:2
    - flag player temp:!
    - ~run sql_init_inventory
    - ~run sql_init_character_data
    - ~run sql_set_character_data
    - ~run sql_set_player_data
    - narrate "<&e>Character <&b><player.flag[character.name.display]> <&e>has been saved."

temporary_character_change:
  type: task
  debug: false
  definitions: character
  script:
    - flag player data.name:<[character]>
    - ~run sql_get_character_data
    - execute as_server "setskin <player.flag[character.skin]> <player.name>"
    - flag server name_map.<player.flag[data.name]>:<player>
    - narrate "<&e>Changed into character <&b><[character]>"