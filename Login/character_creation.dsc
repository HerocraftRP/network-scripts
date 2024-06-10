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


## NEW SYSTEM BELOW

cc_remove_as:
  type: task
  debug: false
  script:
    - wait 1t
    - remove <context.entity>

camera_stand:
  type: entity
  entity_type: armor_stand
  debug: false
  mechanisms:
    visible: false
    marker: true
  flags:
    on entity_added: cc_remove_as

cc_text_display:
  type: entity
  debug: false
  entity_type: text_display
  flags:
    on_entity_added: cc_remove_as

new_character_creation_system_start:
  type: task
  debug: false
  data:
    explanation_text: <&e>Use your <&b>Arrow Keys<&e> to Navigate Character Creation<&nl>Hit <&b>Right CTRL<&e> to Select an Option
    top_options:
      Name: <[center].left[-3]>
      Race: <[center].left[-1]>
      Clothing: <[center].left[1]>
      Finalize: <[center].left[3]>
  script:
    - spawn camera_stand <player.flag[character_location].forward_flat[5.5].left[0.5].with_yaw[180]> save:as1
    - adjust <player> spectate:<entry[as1].spawned_entity>
    - teleport <player> <player.flag[character_location].left[0.5].below[2]>
    - spawn cc_text_display[text=<script.parsed_key[data.Explanation_Text]>] <player.flag[character_location].left[0.5].above[3]> save:td1
    - define string_list <list>
    - define divider <script.data_key[data.Top_Options].size.div[2]>
    - define center <player.flag[character_location].left[0.5].above[2]>
    - foreach <script.data_key[data.Top_Options]>:
      - define offset <[loop_index].sub[<[divider]>]>
      - if <[loop_index]> == 1:
        - spawn cc_text_display[text=<&b>--<&sp><[key]><&sp>--] <[value].parsed> save:tm<[loop_index]>
      - else:
        - spawn cc_text_display[text=<&7><[key]>] <[value].parsed> save:tm<[loop_index]>
    - run cc_open_sub_menu def:name
    - flag player temp.cc.top_menu_value:1
    - flag player temp.cc.menu:top
    - flag player temp.cc.entities:->:<entry[as1].spawned_entity>
    - flag player temp.cc.entities:->:<entry[td1].spawned_entity>
    - flag player temp.cc.entities:->:<entry[tm1].spawned_entity>
    - flag player temp.cc.entities:->:<entry[tm2].spawned_entity>
    - flag player temp.cc.entities:->:<entry[tm3].spawned_entity>
    - flag player temp.cc.entities:->:<entry[tm4].spawned_entity>

cc_update_top_menu:
  type: task
  debug: true
  script:
    - run cc_remove_entities def:false
    - spawn cc_text_display[text=<script[new_character_creation_system_start].parsed_key[data.Explanation_Text]>] <player.flag[character_location].left[0.5].above[3]> save:td1
    - flag player temp.cc.entities:->:<entry[td1].spawned_entity>
    - define divider <script[new_character_creation_system_start].data_key[data.Top_Options].size.div[2]>
    - define center <player.flag[character_location].left[0.5].above[2]>
    - foreach <script[new_character_creation_system_start].data_key[data.Top_Options]>:
      - define offset <[loop_index].sub[<[divider]>]>
      - if <player.flag[temp.cc.top_menu_value]> == <[loop_index]>:
        - spawn cc_text_display[text=<&b>--<&sp><[key]><&sp>--] <[value].parsed> save:tm<[loop_index]>
      - else:
        - spawn cc_text_display[text=<&7><[key]>] <[value].parsed> save:tm<[loop_index]>
      - flag <player> temp.cc.entities:->:<entry[tm<[loop_index]>].spawned_entity>

cc_open_sub_menu:
  type: task
  debug: false
  definitions: submenu|selected
  data:
    name:
      can_scroll_down: false
      entries:
        First Name:
          location: <[top_spot].below[0.7]>
          prefix: <&e>(Use <&b>/firstname <&e>to set)
        Last Name (Optional):
          location: <[top_spot].below[1.6]>
          prefix: <&e>(Use <&b>/lastname <&e>to set)
    race:
      can_scroll_down: true
      entries:
        Race:
          location: <[top_spot].below[0.7]>
          prefix: <empty>
        Tone:
          location: <[top_spot].below[1.4]>
          prefix: <empty>
        Eyes:
          location: <[top_spot].below[2.1]>
          prefix: <empty>
        Hair:
          location: <[top_spot].below[2.8]>
          prefix: <empty>
  script:
    - define top_spot <player.flag[character_location].left[-1.5].above[1.25]>
    - foreach <script.data_key[data.<[submenu]>.entries]>:
      - if <[selected]||0> == <[loop_index]>:
        - spawn cc_text_display[text=<[value].get[prefix].parsed><&nl><&a><&lb><&sp><[key]><&sp><&rb><&nl><&r>None] <[value].get[location].parsed> save:sm<[loop_index]>
      - else:
        - spawn cc_text_display[text=<[value].get[prefix].parsed><&nl><&7><&n><[key]><&nl><&r>None] <[value].get[location].parsed> save:sm<[loop_index]>
      - flag player temp.cc.entities:->:<entry[sm<[loop_index]>].spawned_entity>
      - flag player temp.cc.submenu_entities:->:<entry[sm<[loop_index]>].spawned_entity>
    - flag player temp.cc.submenu:<[submenu]>

cc_open_mini_menu:
  type: task
  debug: true
  definitions: top_menu|submenu|selection
  data:
    race:
      Race:
        location: <[mini_spot].below[0.7]>
        select_script: cc_race_select
        accept_script: cc_race_select
        entries:
          - Human
          - Orc
          - Elytrian
          - Fae
      Tone:
        location: <[mini_spot].below[0.7]>
        select_script: cc_tone_select
        accept_script: cc_race_select
        entries:
          - White
          - Less White
          - Even Less White
          - Opposite of White
      Eyes:
        location: <[mini_spot].below[0.7]>
        select_script: cc_eyes_select
        accept_script: cc_race_select
        entries:
          - Red
          - Purple
          - Missing
          - Orange
      Hair:
        location: <[mini_spot].below[0.7]>
        select_script: cc_hair_select
        accept_script: cc_race_select
        entries:
          - Red1
          - Purple1
          - Missing1
          - Orange1
    something:
      entries:
        Race:
          location: <[mini_spot].below[0.7]>
          prefix: <empty>
        Skin Tone:
          location: <[mini_spot].below[1.4]>
          prefix: <empty>
        Eyes:
          location: <[mini_spot].below[2.1]>
          prefix: <empty>
        Hair:
          location: <[mini_spot].below[2.8]>
          prefix: <empty>
  script:
    - define mini_spot <player.flag[character_location].left[-0.25].above[1.25]>
    - define selection <player.flag[temp.cc.mini_menu_value]||1>
    - define menu_data <script.data_key[data.<[top_menu]>.<[submenu]>]>
    - spawn cc_text_display[text=<&nl><&7><&n><[submenu]><&nl><&r><[menu_data].get[entries].get[<[selection]>]>] <[menu_data].get[location].parsed> save:mm1
    - flag player temp.cc.minimenu_entities:->:<entry[mm1].spawned_entity>
    - flag player temp.cc.entities:->:<entry[mm1].spawned_entity>
    - if <[menu_data].get[select_script].exists>:
      - run <[menu_data].get[select_script]> def:<[top_menu]>|<[submenu]>|<[selection]>

cc_remove_entities:
  type: task
  debug: false
  definitions: end
  script:
    - foreach <player.flag[temp.cc.entities]>:
      - if <[value].is_spawned>:
        - remove <[value]>
    - flag <player> temp.cc.entities:!
    - if <[end]||false>:
      - adjust <player> spectate:<player>
      - flag player temp.cc:!

cc_remove_submenu_entities:
  type: task
  debug: false
  script:
    - foreach <player.flag[temp.cc.submenu_entities]>:
      - if <[value].is_spawned>:
        - remove <[value]>
      - flag <player> temp.cc.entities:<-:<[value]>
    - flag <player> temp.cc.submenu_entities:!

cc_remove_minimenu_entities:
  type: task
  debug: false
  script:
    - foreach <player.flag[temp.cc.minimenu_entities]>:
      - if <[value].is_spawned>:
        - remove <[value]>
      - flag <player> temp.cc.entities:<-:<[value]>
    - flag <player> temp.cc.minimenu_entities:!

input_keys:
  type: command
  name: input_key
  debug: false
  usage: noop
  description: noop
  aliases:
    - up_arrow
    - down_arrow
    - left_arrow
    - right_arrow
    - right_ctrl
  script:
    - stop if:<player.has_flag[temp.cc].not>
    - narrate <context.alias>
    - choose <context.alias>:
      ## Right Arrow Key
      - case right_arrow:
        # MINI MENU
        - if <player.flag[temp.cc.menu]> == mini:
          - define top_menu <script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<player.flag[temp.cc.top_menu_value]>]>
          - define submenu <script[cc_open_sub_menu].data_key[data.<[top_menu]>.entries].keys.get[<player.flag[temp.cc.sub_menu_value]>]>
          - define current_mini_size <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>.entries].size>
          - flag player temp.cc.mini_menu_value:<player.flag[temp.cc.mini_menu_value].add[1].min[<[current_mini_size]>]>
          - run cc_remove_minimenu_entities
          - run cc_open_mini_menu def:<[top_menu]>|<[submenu]>|<player.flag[temp.cc.mini_menu_value]>
          - stop
        # SUB MENU
        - define current_menu <player.flag[temp.cc.menu]>
        - if <[current_menu]> == top:
          - define current <player.flag[temp.cc.top_menu_value]>
          - flag <player> temp.cc.top_menu_value:<[current].add[1].min[4]>
          - run cc_update_top_menu
          - run cc_open_sub_menu def:<script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<[current].add[1].min[4]>]>
      - case left_arrow:
        # MINI MENU
        - if <player.flag[temp.cc.menu]> == mini:
          - define top_menu <script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<player.flag[temp.cc.top_menu_value]>]>
          - define submenu <script[cc_open_sub_menu].data_key[data.<[top_menu]>.entries].keys.get[<player.flag[temp.cc.sub_menu_value]>]>
          - define current_mini_size <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>.entries].size>
          - flag player temp.cc.mini_menu_value:<player.flag[temp.cc.mini_menu_value].sub[1].min[<[current_mini_size]>]>
          - run cc_remove_minimenu_entities
          - run cc_open_mini_menu def:<[top_menu]>|<[submenu]>|<player.flag[temp.cc.mini_menu_value]>
        # SUB MENU
        - define current_menu <player.flag[temp.cc.menu]>
        - if <[current_menu]> == top:
          - define current <player.flag[temp.cc.top_menu_value]>
          - flag <player> temp.cc.top_menu_value:<[current].sub[1].max[1]>
          - run cc_update_top_menu
          - run cc_open_sub_menu def:<script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<[current].sub[1].max[1]>]>
      - case down_arrow:
        - stop if:<player.flag[temp.cc.menu].equals[mini]>
        - define current_menu <player.flag[temp.cc.menu]>
        - define current <player.flag[temp.cc.top_menu_value]>
        - define current_top_menu <script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<[current]>]>
        - stop if:<script[cc_open_sub_menu].data_key[data.<[current_top_menu]>.can_scroll_down].not>
        - define current_sub_size <script[cc_open_sub_menu].data_key[data.<[current_top_menu]>.entries].size>
        - define current_sub <player.flag[temp.cc.sub_menu_value]||0>
        - flag player temp.cc.sub_menu_value:<[current_sub].add[1].min[<[current_sub_size]>]>
        - if <player.flag[temp.cc.sub_menu_value]> == 0:
          - flag player temp.cc.menu:top
        - else:
          - flag player temp.cc.menu:sub
        - run cc_remove_submenu_entities
        - run cc_open_sub_menu def:<script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<[current]>]>|<[current_sub].add[1].min[<[current_sub_size]>]>
      - case up_arrow:
        - stop if:<player.flag[temp.cc.menu].equals[mini]>
        - define current_menu <player.flag[temp.cc.menu]>
        - define current <player.flag[temp.cc.top_menu_value]>
        - define current_top_menu <script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<[current]>]>
        - define current_sub_size <script[cc_open_sub_menu].data_key[data.<[current_top_menu]>.entries].size>
        - define current_sub <player.flag[temp.cc.sub_menu_value]||0>
        - flag player temp.cc.sub_menu_value:<[current_sub].sub[1].max[0]>
        - if <player.flag[temp.cc.sub_menu_value]> == 0:
          - flag player temp.cc.menu:top
        - else:
          - flag player temp.cc.menu:sub
        - run cc_remove_submenu_entities
        - run cc_open_sub_menu def:<script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<[current]>]>|<[current_sub].sub[1].max[0]>
      - case right_ctrl:
        - choose <player.flag[temp.cc.menu]>:
          - case top:
            - run cc_remove_entities def:true
          - case sub:
            - define top_menu <script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<player.flag[temp.cc.top_menu_value]>]>
            - define submenu <script[cc_open_sub_menu].data_key[data.<[top_menu]>.entries].keys.get[<player.flag[temp.cc.sub_menu_value]>]>
            - flag player temp.cc.menu:mini
            - flag player temp.cc.mini_menu_value:1
            - run cc_open_mini_menu def:<[top_menu]>|<[submenu]>|1
          - case mini:
            - define top_menu <script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<player.flag[temp.cc.top_menu_value]>]>
            - define submenu <script[cc_open_sub_menu].data_key[data.<[top_menu]>.entries].keys.get[<player.flag[temp.cc.sub_menu_value]>]>
            - run cc_remove_minimenu_entities
            - flag player temp.cc.mini_menu_value:0
            - flag player temp.cc.menu:sub

cc_race_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  data:
   races:
     Human:
       base_scale: 1
       base_skin: skin.png
     Orc:
       base_scale: 1.1
       base_skin: skin.png
     Elytrian:
       base_scale: 0.8
       base_skin: skin.png
     Fae:
       base_scale: 0.3
       base_skin: skin.png
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define race <[menu_data].get[entries].get[<[selection]>]>
    - execute as_server "scale set pehkui:base <script.data_key[data.races.<[race]>.base_scale]> <player.name>"
    - narrate "<&C>TEMP - changed race to <[race]>"

cc_tone_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define tone <[menu_data].get[entries].get[<[selection]>]>
    - narrate "<&C>TEMP - changed tone to <[tone]>"

cc_eyes_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define eyes <[menu_data].get[entries].get[<[selection]>]>
    - narrate "<&C>TEMP - changed eyes to <[eyes]>"

cc_hair_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define eyes <[menu_data].get[entries].get[<[selection]>]>
    - narrate "<&C>TEMP - changed hair to <[eyes]>"