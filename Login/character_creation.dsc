create_server_infogram:
  type: task
  debug: false
  definitions: location
  script:
    - define location <player.flag[info_location]> if:<[location].exists.not>
    - spawn "armor_stand_display[custom_name=<&6>Go to Avalon]" <[location].above[0.2]> save:display_stand1
    - spawn "armor_stand_display[custom_name=<&b>/join_avalon]" <[location]> save:display_stand2
    - spawn "armor_stand_display[custom_name=<&e>Make sure to <&b>/character select<&e> or <&b>/character new]" <[location].below[0.6]> save:display_stand2

create_new_character_start_buttons:
  type: task
  debug: false
  definitions: location
  script:
    - define location <player.flag[character_location]> if:<[location].exists.not>
    - spawn "armor_stand_display[custom_name=<&6>Create New Character]" <[location]> save:display_stand1
    - spawn "armor_stand_display[custom_name=<&b>/character new]" <[location].below[0.2]> save:display_stand2
    - flag <player> temp.character_creation.entities:<list[<entry[display_stand1].spawned_entity>|<entry[display_stand2].spawned_entity>]>

create_new_character_start:
  type: task
  debug: false
  script:
    - ratelimit <player> 1t
    - define location <player.flag[character_location]>
    - remove <player.flag[temp.character_creation.entities]>
    - spawn "armor_stand_display[custom_name=<&b>Grey Entries are Optional]" <[location].add[0,1.5,0]> save:display_stand1
    - spawn "armor_stand_display[custom_name=<&6>Character First Name]" <[location].add[4.5,1,0]> save:display_stand2
    - spawn "armor_stand_display[custom_name=<&7>Character Last Name]" <[location].add[0,1,0]> save:display_stand3
    - spawn "armor_stand_display[custom_name=<&6>Character Skin]" <[location].add[-4.5,1,0]> save:display_stand4
    - spawn "armor_stand_display[custom_name=<&6><&b>/character first_name <&e>to set me]" <[location].add[4.5,0.5,0]> save:display_stand5
    - spawn "armor_stand_display[custom_name=<&6><&b>/character last_name <&e>to set me]" <[location].add[0,0.5,0]> save:display_stand6
    - spawn "armor_stand_display[custom_name=<&6><&b>/character skin <&e>to set me]" <[location].add[-4.5,0.5,0]> save:display_stand7
    - flag <player> temp.character_creation.entities:->:<entry[display_stand2].spawned_entity>
    - flag <player> temp.character_creation.entities:->:<entry[display_stand3].spawned_entity>
    - flag <player> temp.character_creation.entities:->:<entry[display_stand4].spawned_entity>
    - flag <player> temp.character_creation.entities:->:<entry[display_stand5].spawned_entity>
    - flag <player> temp.character_creation.entities:->:<entry[display_stand6].spawned_entity>
    - flag <player> temp.character_creation.entities:->:<entry[display_stand7].spawned_entity>
    - flag <player> temp.character_creation.top_most_stand:->:<entry[display_stand1].spawned_entity>
    - flag <player> temp.character_creation.first_name_stand:->:<entry[display_stand5].spawned_entity>
    - flag <player> temp.character_creation.last_name_stand:->:<entry[display_stand6].spawned_entity>
    - flag <player> temp.character_creation.skin_stand:->:<entry[display_stand7].spawned_entity>



armor_stand_display:
  type: entity
  debug: false
  entity_type: armor_stand
  mechanisms:
    marker: true
    visible: false
    gravity: false
    custom_name_visible: true


armor_stand_interactable:
  type: entity
  debug: false
  entity_type: armor_stand
  mechanisms:
    visible: true
    gravity: false
    is_small: true