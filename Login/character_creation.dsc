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
    marker: false
    gravity: false
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
      Name: <[center].left[-4]>
      Race: <[center].left[-2]>
      Build: <[center]>
      Clothing: <[center].left[2]>
      Finalize: <[center].left[4]>
  script:
    - flag <player> character_location:<player.flag[character_location].with_yaw[0]>
    - spawn camera_stand <player.flag[character_location].forward_flat[5.5].left[0.5].below[1.5].with_yaw[180]> save:as1
    - define locations <list[<player.flag[mm_location].forward_flat[4].above[2].with_yaw[90]>]>
    - define locations <[locations].include[<player.flag[character_location].forward_flat[5.5].left[0.5].with_yaw[180]>]>
    - execute as_server "cam-server create test_<player.uuid>"
    - execute as_server "cam-server get test_<player.uuid> mode default"
    - foreach <[locations]> as:loc:
      - execute as_server "cam-server get test_<player.uuid> add <[loc].x> <[loc].y.sub[0.4]> <[loc].z> <[loc].yaw> 0 0 70"
    - teleport <player> <player.flag[mm_location].forward_flat[4].with_yaw[90]>
    - execute as_server "cam-server start test_<player.uuid> <player.name> 3s"
    - wait 4.25s
    - adjust <player> can_fly:true
    - adjust <player> flying:true
    - teleport <player> <player.flag[character_location].left[0.5].below[1]>
    - modifyblock <player.flag[character_location].left[0.5].below[2]> barrier
    - modifyblock <player.flag[character_location].left[0.5].below[2].add[1,0,0]> light[level=15]
    - modifyblock <player.flag[character_location].left[0.5].below[2].add[-1,0,0]> light[level=15]
    - adjust <player> spectate:<entry[as1].spawned_entity>
    - execute as_server "cam-server remove test_<player.uuid>"
    - run cc_defaults def:Human|true
    - spawn cc_text_display[text=<script.parsed_key[data.Explanation_Text]>] <player.flag[character_location].left[0.5].above[3]> save:td1
    - define string_list <list>
    - define divider <script.data_key[data.Top_Options].size.div[2]>
    - define center <player.flag[character_location].left[0.5].above[2.25]>
    - foreach <script.data_key[data.Top_Options]>:
      - define offset <[loop_index].sub[<[divider]>]>
      - if <[loop_index]> == 1:
        - spawn cc_text_display[text=<&b>--<&sp><[key]><&sp>--] <[value].parsed> save:tm<[loop_index]>
      - else:
        - spawn cc_text_display[text=<&7><[key]>] <[value].parsed> save:tm<[loop_index]>
      - flag <player> temp.cc.entities:->:<entry[tm<[loop_index]>].spawned_entity>
    - run cc_build_sm_options def:name
    - run cc_open_sub_menu def:name
    - flag player temp.cc.top_menu_value:1
    - flag player temp.cc.menu:top
    - flag player temp.cc.entities:->:<entry[as1].spawned_entity>
    - flag player temp.cc.entities:->:<entry[td1].spawned_entity>

cc_update_top_menu:
  type: task
  debug: false
  script:
    - run cc_remove_entities def:false
    - spawn cc_text_display[text=<script[new_character_creation_system_start].parsed_key[data.Explanation_Text]>] <player.flag[character_location].left[0.5].above[3]> save:td1
    - flag player temp.cc.entities:->:<entry[td1].spawned_entity>
    - define divider <script[new_character_creation_system_start].data_key[data.Top_Options].size.div[2]>
    - define center <player.flag[character_location].left[0.5].above[2.25]>
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
      top_offset: <[top_spot].below[0.7]>
      entries:
        First Name:
          flag_check: true
          prefix: <&e>(Use <&b>/firstname <&e>to set)
        Last Name (Optional):
          flag_check: true
          prefix: <&e>(Use <&b>/lastname <&e>to set)
        Skin Code (Optional):
          flag_check: true
          prefix: <&e>(Use <&b>/ccode<&e>.)
    race:
      can_scroll_down: true
      entries:
        Race:
          flag_check: true
          prefix: <empty>
        Tone:
          flag_check: true
          prefix: <empty>
        Eyes:
          flag_check: true
          prefix: <empty>
        Hair:
          flag_check: true
          prefix: <empty>
    build:
      can_scroll_down: true
      entries:
        Model:
          flag_check: true
          prefix: <empty>
        Height:
          flag_check: true
          prefix: <empty>
        Weight:
          flag_check: true
          prefix: <empty>
        Wings:
          flag_check: <player.flag[temp.cc.character.race].equals[fae]||false>
          prefix: <empty>
        Elytra1:
          flag_check: <player.flag[temp.cc.character.race].equals[elytrian]||false>
          prefix: <empty>
        Elytra2:
          flag_check: <player.flag[temp.cc.character.race].equals[elytrian]||false>
          prefix: <empty>
    clothing:
      can_scroll_down: true
      entries:
        Underwear:
          flag_check: true
          prefix: <empty>
        Helmet:
          flag_check: true
          prefix: <empty>
        Top:
          flag_check: true
          prefix: <empty>
        Bottom:
          flag_check: true
          prefix: <empty>
        Feet:
          flag_check: true
          prefix: <empty>
    finalize:
      can_scroll_down: true
      entries:
        Exit and Save:
          flag_check: true
          prefix: <empty>
        Exit Without Save:
          flag_check: true
          prefix: <empty>
  script:
    - define top_spot <player.flag[character_location].left[-2.5].above[1]>
    - if <script.parsed_key[data.<[submenu]>.top_offset].exists>:
      - define top_spot <script.parsed_key[data.<[submenu]>.top_offset]>
    - define skipped_entries 1
    - foreach <player.flag[temp.cc.sub_menu_options]>:
      - define entry <script.parsed_key[data.<[submenu]>.entries.<[value]>]>
      - if !<[entry].get[flag_check]>:
        - define skipped_entries <[skipped_entries].add[1]>
        - foreach next
      - if <[selected]||0> == <[loop_index]>:
        - spawn cc_text_display[text=<[entry].get[prefix].parsed><&nl><&a><&lb><&sp><[value]><&sp><&rb><&nl><&r><player.flag[temp.cc.display.<[value]>]||None>] <[top_spot].add[0,-<[loop_index].sub[<[skipped_entries]>].mul[0.75]>,0]> save:sm<[loop_index]>
      - else:
        - spawn cc_text_display[text=<[entry].get[prefix].parsed><&nl><&7><&n><[value]><&nl><&r><player.flag[temp.cc.display.<[value]>]||None>] <[top_spot].add[0,-<[loop_index].sub[<[skipped_entries]>].mul[0.75]>,0]> save:sm<[loop_index]>
      - flag player temp.cc.entities:->:<entry[sm<[loop_index]>].spawned_entity>
      - flag player temp.cc.submenu_entities:->:<entry[sm<[loop_index]>].spawned_entity>
    - flag player temp.cc.submenu:<[submenu]>


cc_build_sm_options:
  type: task
  debug: false
  definitions: top_menu
  script:
    - flag player temp.cc.sub_menu_options:!
    - if <script[cc_open_sub_menu].parsed_key[data.<[top_menu]>.external_list].exists>:
      - run <script[cc_open_sub_menu].parsed_key[data.<[top_menu]>.external_list]> def:<[topmenu]>
      - stop
    - define entries <script[cc_open_sub_menu].parsed_key[data.<[top_menu]>.entries]>
    - foreach <[entries]>:
      - if <[value].get[flag_check]>:
        - flag <player> temp.cc.sub_menu_options:->:<[key]>

cc_open_mini_menu:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  data:
    race:
      Race:
        location: <[mini_spot].below[0.7]>
        select_script: cc_race_select
        accept_script: cc_race_select
        entries:
          Human:
            check_tag: true
          Orc:
            check_tag: true
          Elytrian:
            check_tag: true
          Fae:
            check_tag: true
      Tone:
        location: <[mini_spot].below[0.7]>
        select_script: cc_tone_select
        accept_script: cc_tone_select
        entries:
          1:
            check_tag: <list[Fae|Human].contains[<player.flag[temp.cc.character.race]>]>
          2:
            check_tag: <list[Fae|Human].contains[<player.flag[temp.cc.character.race]>]>
          3:
            check_tag: <list[Fae|Human].contains[<player.flag[temp.cc.character.race]>]>
          4:
            check_tag: <list[Fae|Human].contains[<player.flag[temp.cc.character.race]>]>
          5:
            check_tag: <list[Fae|Human].contains[<player.flag[temp.cc.character.race]>]>
          6:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          7:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          8:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          9:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          10:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          11:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          12:
            check_tag: <player.flag[temp.cc.character.race].equals[elytrian]>
      Eyes:
        location: <[mini_spot].below[0.7]>
        select_script: cc_eyes_select
        accept_script: cc_eyes_select
        entries:
          1:
            check_tag: <list[Fae|Human].contains[<player.flag[temp.cc.character.race]>]>
          2:
            check_tag: <list[Fae|Human].contains[<player.flag[temp.cc.character.race]>]>
          3:
            check_tag: <list[Fae|Human].contains[<player.flag[temp.cc.character.race]>]>
          4:
            check_tag: <list[Fae|Human].contains[<player.flag[temp.cc.character.race]>]>
          5:
            check_tag: <list[Fae|Human|Elytrian].contains[<player.flag[temp.cc.character.race]>]>
          6:
            check_tag: <list[Fae|Human|Elytrian].contains[<player.flag[temp.cc.character.race]>]>
          7:
            check_tag: <list[Fae|Human|Elytrian].contains[<player.flag[temp.cc.character.race]>]>
          8:
            check_tag: <list[Fae|Human|Elytrian].contains[<player.flag[temp.cc.character.race]>]>
          9:
            check_tag: <list[Fae|Human|Elytrian].contains[<player.flag[temp.cc.character.race]>]>
          10:
            check_tag: <list[Fae|Human|Elytrian].contains[<player.flag[temp.cc.character.race]>]>
          11:
            check_tag: <list[Fae|Human|Elytrian].contains[<player.flag[temp.cc.character.race]>]>
          12:
            check_tag: <list[Fae|Human|Elytrian].contains[<player.flag[temp.cc.character.race]>]>
          13:
            check_tag: <list[Fae|Human|Elytrian].contains[<player.flag[temp.cc.character.race]>]>
          14:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          15:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          16:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          17:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          18:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          19:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          20:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          21:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          22:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          23:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          24:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          25:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          26:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
      Hair:
        location: <[mini_spot].below[0.7]>
        select_script: cc_hair_select
        accept_script: cc_hair_select
        entries:
          0:
            check_tag: true
          5:
            check_tag: true
          6:
            check_tag: true
          7:
            check_tag: true
          8:
            check_tag: true
          9:
            check_tag: true
          10:
            check_tag: true
          11:
            check_tag: true
          12:
            check_tag: true
          13:
            check_tag: true
          14:
            check_tag: true
          15:
            check_tag: true
          16:
            check_tag: true
          17:
            check_tag: true
          18:
            check_tag: true
          19:
            check_tag: true
          20:
            check_tag: true
          21:
            check_tag: true
          22:
            check_tag: true
          23:
            check_tag: true
          24:
            check_tag: true
          25:
            check_tag: true
          26:
            check_tag: true
          27:
            check_tag: true
          28:
            check_tag: true
          29:
            check_tag: true
          30:
            check_tag: true
          31:
            check_tag: true
          32:
            check_tag: true
          33:
            check_tag: true
          34:
            check_tag: true
          35:
            check_tag: true
          36:
            check_tag: true
          37:
            check_tag: true
          38:
            check_tag: true
          39:
            check_tag: true
          40:
            check_tag: true
          41:
            check_tag: true
          42:
            check_tag: true
          43:
            check_tag: true
          44:
            check_tag: true
          45:
            check_tag: true
          46:
            check_tag: true
          47:
            check_tag: true
          48:
            check_tag: true
          49:
            check_tag: true
          50:
            check_tag: true
          51:
            check_tag: true
          52:
            check_tag: true
          53:
            check_tag: true
          54:
            check_tag: true
          55:
            check_tag: true
          56:
            check_tag: true
          58:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          59:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
          60:
            check_tag: <player.flag[temp.cc.character.race].equals[orc]>
    build:
      Model:
        location: <[mini_spot].below[0.7]>
        select_script: cc_model_select
        entries:
          Steve:
            check_tag: true
            value: default
          Alex:
            check_tag: true
            value: slim
      Weight:
        location: <[mini_spot].below[0.7]>
        select_script: cc_weight_select
        entries:
          Very Light:
            check_tag: true
            value: 0.9
          Light:
            check_tag: true
            value: 0.95
          Average:
            check_tag: true
            value: 1
          Heavy:
            check_tag: true
            value: 1.05
          Very Heavy:
            check_tag: true
            value: 1.1
      Height:
        location: <[mini_spot].below[0.7]>
        select_script: cc_height_select
        entries:
          Very Short:
            check_tag: true
            value: 0.9
          Short:
            check_tag: true
            value: 0.95
          Average:
            check_tag: true
            value: 1
          Tall:
            check_tag: true
            value: 1.05
          Very Tall:
            check_tag: true
            value: 1.1
      Wings:
        location: <[mini_spot].below[0.7]>
        select_script: cc_wings_select
        accept_script: cc_wings_select
        entries:
          Black Feathered Wings:
            check_tag: true
          Red Feathered Wings:
            check_tag: true
          Orange Feathered Wings:
            check_tag: true
          Green Feathered Wings:
            check_tag: true
          White Feathered Wings:
            check_tag: true
          Light Blue Feathered Wings:
            check_tag: true
          Magenta Feathered Wings:
            check_tag: true
          Yellow Feathered Wings:
            check_tag: true
          Lime Feathered Wings:
            check_tag: true
          Pink Feathered Wings:
            check_tag: true
          Gray Feathered Wings:
            check_tag: true
          Light Gray Feathered Wings:
            check_tag: true
          Cyan Feathered Wings:
            check_tag: true
          Purple Feathered Wings:
            check_tag: true
          Blue Feathered Wings:
            check_tag: true
          Brown Feathered Wings:
            check_tag: true
      Elytra1:
        location: <[mini_spot].below[0.7]>
        select_script: cc_elytra1_select
        accept_script: cc_elytra1_select
        entries:
          Red:
            check_tag: true
          Purple:
            check_tag: true
          Blue:
            check_tag: true
          Aqua:
            check_tag: true
          Green:
            check_tag: true
          Yellow:
            check_tag: true
          Orange:
            check_tag: true
          Pink:
            check_tag: true
          White:
            check_tag: true
          Black:
            check_tag: true
          Brown:
            check_tag: true
      Elytra2:
        location: <[mini_spot].below[0.7]>
        select_script: cc_elytra2_select
        accept_script: cc_elytra2_select
        entries:
          Red:
            check_tag: true
          Purple:
            check_tag: true
          Blue:
            check_tag: true
          Aqua:
            check_tag: true
          Green:
            check_tag: true
          Yellow:
            check_tag: true
          Orange:
            check_tag: true
          Pink:
            check_tag: true
          White:
            check_tag: true
          Black:
            check_tag: true
          Brown:
            check_tag: true
    clothing:
      Underwear:
        location: <[mini_spot].below[0.7]>
        select_script: cc_underwear_select
        entries:
          m1:
            check_tag: true
          m2:
            check_tag: true
          m3:
            check_tag: true
          m4:
            check_tag: true
          m5:
            check_tag: true
          m6:
            check_tag: true
          f1:
            check_tag: true
          f2:
            check_tag: true
          f3:
            check_tag: true
          f4:
            check_tag: true
          f5:
            check_tag: true
      Helmet:
        location: <[mini_spot].below[0.7]>
        select_script: cc_helmet_select
        external_list: clothing_external_list
      Top:
        location: <[mini_spot].below[0.7]>
        select_script: cc_top_select
        external_list: clothing_external_list
      Bottom:
        location: <[mini_spot].below[0.7]>
        select_script: cc_bottom_select
        external_list: clothing_external_list
      Feet:
        location: <[mini_spot].below[0.7]>
        select_script: cc_feet_select
        external_list: clothing_external_list
    finalize:
      Exit and Save:
        location: <[mini_spot].below[0.7]>
        accept_script: cc_exit_and_save_editor
        entries:
          Confirm:
            check_tag: true
          Back:
            check_tag: true
      Exit Without Save:
        location: <[mini_spot].below[0.7]>
        accept_script: cc_exit_editor
        entries:
          Confirm:
            check_tag: true
          Back:
            check_tag: true
  script:
    - define mini_spot <player.flag[character_location].left[0.5].above[2.25]>
    - define selection <player.flag[temp.cc.mini_menu_value]||1>
    - define menu_data <script.data_key[data.<[top_menu]>.<[submenu]>]>
    - define options <player.flag[temp.cc.mini_menu_options]>
    - spawn cc_text_display[text=<&nl><&7><&n><[submenu]><&nl><&r><[options].get[<[selection]>]>] <[menu_data].get[location].parsed> save:mm1
    - flag player temp.cc.minimenu_entities:->:<entry[mm1].spawned_entity>
    - flag player temp.cc.entities:->:<entry[mm1].spawned_entity>
    - if <[menu_data].get[select_script].exists>:
      - run <[menu_data].get[select_script]> def:<[top_menu]>|<[submenu]>|<[selection]>

cc_build_mm_options:
  type: task
  debug: false
  definitions: top_menu|submenu
  script:
    - flag player temp.cc.mini_menu_options:!
    - if <script[cc_open_mini_menu].parsed_key[data.<[top_menu]>.<[submenu]>.external_list].exists>:
      - run <script[cc_open_mini_menu].parsed_key[data.<[top_menu]>.<[submenu]>.external_list]> def:<[submenu]>
      - stop
    - define entries <script[cc_open_mini_menu].parsed_key[data.<[top_menu]>.<[submenu]>.entries]>
    - foreach <[entries]>:
      - if <[value].get[check_tag]>:
        - flag <player> temp.cc.mini_menu_options:->:<[key]>

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

cc_defaults:
  type: task
  debug: false
  definitions: race|first
  script:
    - if <[first]>:
      - flag <player> temp.cc.display.race:Human
      - flag <player> temp.cc.character.race:human
      - define race Human
    - flag <player> temp.cc.display.wings:0
    - flag <player> temp.cc.character.wings:0
    - flag <player> temp.cc.display.elytra:0
    - flag <player> temp.cc.character.elytra:0
    - choose <[race]>:
      - case Human:
        - flag <player> temp.cc.display.tone:1
        - flag <player> temp.cc.character.tone:1
        - flag <player> temp.cc.display.eyes:1
        - flag <player> temp.cc.character.eyes:1
        - flag <player> temp.cc.display.hair:5
        - flag <player> temp.cc.character.hair:5
        - flag <player> temp.cc.character.stats.max_health:8
        - flag <player> temp.cc.character.stats.health:8
        - flag <player> temp.cc.display.wings:!
        - flag <player> temp.cc.character.wings:!
        - flag <player> temp.cc.display.elytra1:!
        - flag <player> temp.cc.character.elytra1:!
        - flag <player> temp.cc.display.elytra2:!
        - flag <player> temp.cc.character.elytra2:!
        - flag <player> temp.cc.character.on_damaged:!
        - adjust <player> curios_item:back|air
      - case Orc:
        - flag <player> temp.cc.display.tone:6
        - flag <player> temp.cc.character.tone:6
        - flag <player> temp.cc.display.eyes:14
        - flag <player> temp.cc.character.eyes:14
        - flag <player> temp.cc.display.hair:0
        - flag <player> temp.cc.character.hair:0
        - flag <player> temp.cc.character.stats.max_health:10
        - flag <player> temp.cc.character.stats.health:10
        - flag <player> temp.cc.display.wings:!
        - flag <player> temp.cc.character.wings:!
        - flag <player> temp.cc.display.elytra1:!
        - flag <player> temp.cc.character.elytra1:!
        - flag <player> temp.cc.display.elytra2:!
        - flag <player> temp.cc.character.elytra2:!
        - flag <player> temp.cc.character.on_damaged:!
        - adjust <player> curios_item:back|air
      - case Elytrian:
        - flag <player> temp.cc.display.tone:12
        - flag <player> temp.cc.character.tone:12
        - flag <player> temp.cc.display.eyes:5
        - flag <player> temp.cc.character.eyes:5
        - flag <player> temp.cc.display.hair:5
        - flag <player> temp.cc.character.hair:5
        - flag <player> temp.cc.display.wings:!
        - flag <player> temp.cc.character.wings:!
        - flag <player> temp.cc.display.elytra1:Gray
        - flag <player> temp.cc.character.elytra1:Gray
        - flag <player> temp.cc.display.elytra2:Gray
        - flag <player> temp.cc.character.elytra2:Gray
        - adjust <player> curios_item:back|<proc[get_colored_elytra].context[gray|gray]>
        - flag <player> temp.cc.character.stats.max_health:6
        - flag <player> temp.cc.character.stats.health:6
        - flag <player> temp.cc.character.on_damaged:racial_negate_fall_damage
      - case Fae:
        - flag <player> temp.cc.display.tone:1
        - flag <player> temp.cc.character.tone:1
        - flag <player> temp.cc.display.eyes:1
        - flag <player> temp.cc.character.eyes:1
        - flag <player> temp.cc.display.hair:5
        - flag <player> temp.cc.character.hair:5
        - flag <player> "temp.cc.display.wings:White Feathered Wings"
        - flag <player> temp.cc.character.wings:icarus_white_feathered_wings
        - adjust <player> curios_item:back|icarus_white_feathered_wings
        - flag <player> temp.cc.display.elytra1:!
        - flag <player> temp.cc.character.elytra1:!
        - flag <player> temp.cc.display.elytra2:!
        - flag <player> temp.cc.character.elytra2:!
        - flag <player> temp.cc.character.stats.max_health:4
        - flag <player> temp.cc.character.stats.health:4
        - flag <player> temp.cc.character.on_damaged:racial_negate_fall_damage
    - flag <player> temp.cc.display.height:Average
    - flag <player> temp.cc.character.height:1
    - execute as_server "scale set pehkui:height 1 <player.name>"
    - flag <player> temp.cc.display.model:Steve
    - flag <player> temp.cc.character.model:default
    - flag <player> temp.cc.display.weight:Average
    - flag <player> temp.cc.character.weight:1
    - execute as_server "scale set pehkui:width 1 <player.name>"
    - flag <player> temp.cc.display.underwear:m1
    - flag <player> temp.cc.character.underwear:m1
    - flag <player> temp.cc.display.helmet:0
    - flag <player> temp.cc.character.clothing.helmet:0
    - flag <player> temp.cc.display.top:0
    - flag <player> temp.cc.character.walk_speed:0.2
    - flag <player> temp.cc.character.clothing.top:0
    - flag <player> temp.cc.display.bottom:0
    - flag <player> temp.cc.character.clothing.bottom:0
    - flag <player> temp.cc.display.feet:0
    - flag <player> temp.cc.character.clothing.feet:0
    - flag <player> temp.cc.character.thirst:20
    - flag <player> temp.cc.character.feed_level:20
    - flag <player> temp.cc.character.skin:https://herocraft.world/images/pregen_skins/b1_f1_ey1_ha0.png
    - execute as_server "setskin https://herocraft.world/images/pregen_skins/b1_f1_ey1_ha0.png <player.name>"
    - flag player "temp.cc.display.Exit and Save:<&a>Save Character"
    - flag player "temp.cc.display.Exit Without Save:<&c>Do Not Save"
    - repeat 4:
      - define slot <[value].sub[1]>
      - adjust <player> cosmetic_armor:<[slot]>|air

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
    - if !<player.has_flag[temp.cc]> && !<player.has_flag[temp.mm]> && !<player.has_flag[temp.cs]>:
      - stop
    - if <context.alias> == right_ctrl:
      - playsound sound:UI_TOAST_IN volume:1 <player> pitch:1
    - else:
      - playsound sound:UI_TOAST_OUT volume:1 <player> pitch:1
    ## CHARACTER CREATION
    - if <player.has_flag[temp.cc]>:
      - choose <context.alias>:
        ## RIGHT ARROW
        - case right_arrow:
          # MINI MENU
          - if <player.flag[temp.cc.menu]> == mini:
            - define top_menu <script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<player.flag[temp.cc.top_menu_value]>]>
            - define submenu <player.flag[temp.cc.sub_menu_options].get[<player.flag[temp.cc.sub_menu_value]>]>
            - define current_mini_size <player.flag[temp.cc.mini_menu_options].size>
            - flag player temp.cc.mini_menu_value:<player.flag[temp.cc.mini_menu_value].add[1].min[<[current_mini_size]>]>
            - run cc_remove_minimenu_entities
            - run cc_open_mini_menu def:<[top_menu]>|<[submenu]>|<player.flag[temp.cc.mini_menu_value]>
            - stop
          # SUB MENU
          - define current_menu <player.flag[temp.cc.menu]>
          - if <[current_menu]> == top:
            - define current <player.flag[temp.cc.top_menu_value]>
            - flag <player> temp.cc.top_menu_value:<[current].add[1].min[5]>
            - define top_menu <script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<[current].add[1].min[5]>]>
            - run cc_build_sm_options def:<[top_menu]>
            - run cc_update_top_menu
            - run cc_open_sub_menu def:<[top_menu]>
        ## LEFT ARROW
        - case left_arrow:
          # MINI MENU
          - if <player.flag[temp.cc.menu]> == mini:
            - define top_menu <script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<player.flag[temp.cc.top_menu_value]>]>
            - define submenu <player.flag[temp.cc.sub_menu_options].get[<player.flag[temp.cc.sub_menu_value]>]>
            - flag player temp.cc.mini_menu_value:<player.flag[temp.cc.mini_menu_value].sub[1].max[1]>
            - run cc_remove_minimenu_entities
            - run cc_open_mini_menu def:<[top_menu]>|<[submenu]>|<player.flag[temp.cc.mini_menu_value]>
          # SUB MENU
          - define current_menu <player.flag[temp.cc.menu]>
          - if <[current_menu]> == top:
            - define current <player.flag[temp.cc.top_menu_value]>
            - flag <player> temp.cc.top_menu_value:<[current].sub[1].max[1]>
            - define top_menu <script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<[current].sub[1].max[1]>]>
            - run cc_build_sm_options def:<[top_menu]>
            - run cc_update_top_menu
            - run cc_open_sub_menu def:<script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<[current].sub[1].max[1]>]>
        - case down_arrow:
          - stop if:<player.flag[temp.cc.menu].equals[mini]>
          - define current_menu <player.flag[temp.cc.menu]>
          - define current <player.flag[temp.cc.top_menu_value]>
          - define current_top_menu <script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<[current]>]>
          - stop if:<script[cc_open_sub_menu].data_key[data.<[current_top_menu]>.can_scroll_down].not>
          - define current_sub_size <player.flag[temp.cc.sub_menu_options].size>
          - define current_sub <player.flag[temp.cc.sub_menu_value]||0>
          - flag player temp.cc.sub_menu_value:<[current_sub].add[1].min[<[current_sub_size]>]>
          - if <player.flag[temp.cc.sub_menu_value]> == 0:
            - flag player temp.cc.menu:top
          - else:
            - flag player temp.cc.menu:sub
          - run cc_build_sm_options def:<[current_top_menu]>
          - run cc_remove_submenu_entities
          - run cc_open_sub_menu def:<script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<[current]>]>|<[current_sub].add[1].min[<[current_sub_size]>]>
        - case up_arrow:
          - stop if:<player.flag[temp.cc.menu].equals[mini]>
          - define current_menu <player.flag[temp.cc.menu]>
          - define current <player.flag[temp.cc.top_menu_value]>
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
              - stop
            - case sub:
              - define top_menu <script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<player.flag[temp.cc.top_menu_value]>]>
              - define submenu <player.flag[temp.cc.sub_menu_options].get[<player.flag[temp.cc.sub_menu_value]>]>
              - flag player temp.cc.menu:mini
              - flag player temp.cc.mini_menu_value:1
              - run cc_build_mm_options def:<[top_menu]>|<[submenu]>
              - run cc_open_mini_menu def:<[top_menu]>|<[submenu]>|1
            - case mini:
              - define top_menu <script[new_character_creation_system_start].data_key[data.Top_Options].keys.get[<player.flag[temp.cc.top_menu_value]>]>
              - define submenu <player.flag[temp.cc.sub_menu_options].get[<player.flag[temp.cc.sub_menu_value]>]>
              - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
              - define selection <player.flag[temp.cc.mini_menu_value]||1>
              - run cc_remove_minimenu_entities
              - flag player temp.cc.mini_menu_value:0
              - flag player temp.cc.menu:sub
              - run cc_remove_submenu_entities
              - run cc_open_sub_menu def:<[top_menu]>|<player.flag[temp.cc.sub_menu_value]>
              - if <[menu_data].get[accept_script].exists>:
                - run <[menu_data].get[accept_script]> def:<[top_menu]>|<[submenu]>|<[selection]>
    - else if <player.has_flag[temp.mm]>:
      - choose <context.alias>:
        - case right_arrow:
          - if <player.flag[temp.mm.selected]> == 0:
            - run main_menu_update def:1
        - case left_arrow:
          - if <player.flag[temp.mm.selected]> == 1:
            - run main_menu_update def:0
        - case right_ctrl:
            - if <player.flag[temp.mm.selected]> == 0:
              - if !<player.has_flag[data.characters]> || <player.flag[data.characters].size> < 1:
                - narrate "<&c>You have no existing characters."
                - narrate "<&e>Please create a new character first."
                - stop
              - adjust <player> spectate:<player>
              - run mm_remove_entities
              - flag <player> temp.mm:!
              - run character_selection_from_main
            - else:
              - if <player.flag[data.characters].size||0> > 4:
                - narrate "<&c>You can only have 5 characters max."
                - stop
              - adjust <player> spectate:<player>
              - run mm_remove_entities
              - flag <player> temp.mm:!
              - run new_character_creation_system_start
    - else if <player.has_flag[temp.cs]>:
      - choose <context.alias>:
        - case right_arrow:
          - if <player.flag[temp.mm.selected]> == 0:
            - run main_menu_update def:1
        - case left_arrow:
          - if <player.flag[temp.mm.selected]> == 1:
            - run main_menu_update def:0
        - case up_arrow:
          - define current <player.flag[temp.sc.menu_value]||0>
          - define character_count <player.flag[data.characters].size>
          - flag player temp.sc.menu_value:<[current].sub[1].max[1]>
          - run character_selection_remove
          - run character_selection_update def:<player.flag[temp.sc.menu_value]>
        - case down_arrow:
          - define current <player.flag[temp.sc.menu_value]||0>
          - define character_count <player.flag[data.characters].size>
          - flag player temp.sc.menu_value:<[current].add[1].min[<[character_count].add[1]>]>
          - run character_selection_remove
          - run character_selection_update def:<player.flag[temp.sc.menu_value]>
        - case right_ctrl:
          - define current <player.flag[temp.sc.menu_value]||0>
          - define character_count <player.flag[data.characters].size>
          - if <[current]> == <[character_count].add[1]>:
            - remove <player.flag[temp.sc.entities]>
            - adjust <player> spectate:<player>
            - flag player temp.cs:!
            - run character_selection_to_main
          - else:
            - run send_to_server def:herocraft

cc_race_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  data:
   races:
     Human:
       base_scale: 1
     Orc:
       base_scale: 1.1
     Elytrian:
       base_scale: 0.8
     Fae:
       base_scale: 0.3
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define race <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - define old_race <player.flag[temp.cc.display.race]>
    - execute as_server "scale set pehkui:base <script.data_key[data.races.<[race]>.base_scale]> <player.name>"
    - flag player temp.cc.character.race:<[race]>
    - flag player temp.cc.display.race:<[race]>
    - if <[race]> != <[old_race]>:
      - run cc_defaults def:<[race]>|false
      - run cc_build_skin

cc_model_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  data:
    models:
      Steve: default
      Alex: slim
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define model <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - define value <script.data_key[data.models.<player.flag[temp.cc.mini_menu_options].get[<[selection]>]>]>
    - flag player temp.cc.display.model:<[model]>
    - flag player temp.cc.character.model:<[value]>
    - execute as_server "setmodel <[value]> <player.name>"
    - run cc_build_skin

cc_tone_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define tone <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - flag player temp.cc.display.tone:<[tone]>
    - flag player temp.cc.character.tone:<[tone]>
    - run cc_build_skin

cc_eyes_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define eyes <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - flag player temp.cc.display.eyes:<[eyes]>
    - flag player temp.cc.character.eyes:<[eyes]>
    - run cc_build_skin

cc_hair_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define hair <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - flag player temp.cc.display.hair:<[hair]>
    - flag player temp.cc.character.hair:<[hair]>
    - run cc_build_skin

cc_underwear_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define underwear <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - flag player temp.cc.display.underwear:<[underwear]>
    - flag player temp.cc.character.underwear:<[underwear]>
    - run cc_build_skin

cc_helmet_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define helmet <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - flag player temp.cc.display.helmet:<[helmet]>
    - flag player temp.cc.character.clothing.helmet:<[helmet]>
    - run clothing_external_set def:helmet|<[helmet]>

cc_top_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define top <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - flag player temp.cc.display.top:<[top]>
    - flag player temp.cc.character.clothing.top:<[top]>
    - run clothing_external_set def:top|<[top]>

cc_bottom_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define bottom <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - flag player temp.cc.display.bottom:<[bottom]>
    - flag player temp.cc.character.clothing.bottom:<[bottom]>
    - run clothing_external_set def:bottom|<[bottom]>

cc_feet_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define feet <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - flag player temp.cc.display.feet:<[feet]>
    - flag player temp.cc.character.clothing.feet:<[feet]>
    - run clothing_external_set def:feet|<[feet]>

cc_height_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  data:
    height_map:
      Very Short: 0.90
      Short: 0.95
      Average: 1
      Tall: 1.05
      Very Tall: 1.1
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define height <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - execute as_server "scale set pehkui:height <script.data_key[data.height_map.<[height]>]> <player.name>"
    - flag player temp.cc.display.height:<[height]>
    - flag player temp.cc.character.height:<[height]>

cc_build_skin:
  type: task
  debug: false
  script:
    - define skin <player.flag[temp.cc.character.tone]>
    - define underwear <player.flag[temp.cc.character.underwear]>
    - define eyes <player.flag[temp.cc.character.eyes]>
    - define hair <player.flag[temp.cc.character.hair]>
    - flag player temp.cc.character.skin:https://herocraft.world/images/pregen_skins/b<[skin]>_<[underwear]>_ey<[eyes]>_ha<[hair]>.png
    - execute as_server "setskin https://herocraft.world/images/pregen_skins/b<[skin]>_<[underwear]>_ey<[eyes]>_ha<[hair]>.png <player.name>"

cc_weight_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  data:
    weight_map:
      Very Light: 0.90
      Light: 0.95
      Average: 1
      Heavy: 1.05
      Very Heavy: 1.1
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define weight <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - execute as_server "scale set pehkui:width <script.data_key[data.weight_map.<[weight]>]> <player.name>"
    - flag player temp.cc.display.weight:<[weight]>
    - flag player temp.cc.character.weight:<[weight]>

cc_exit_editor:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define choice <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - if <[choice]> == Confirm:
      - run cc_remove_entities def:true
      - adjust <player> curios_item:back|air
      - adjust <player> equipment:air|air|air|air
      - execute as_server "clearskin <player.name>"
      - run main_menu_from_creation
    - else:
      - stop

cc_exit_and_save_editor:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define choice <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - if <[choice]> == Confirm:
      - run cc_character_save
      - run cc_remove_entities def:true
      - adjust <player> curios_item:back|air
      - adjust <player> equipment:air|air|air|air
      - execute as_server "clearskin <player.name>"
      - run main_menu_from_creation
    - else:
      - stop

cc_wings_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define choice <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - define item icarus_<[choice].replace[<&sp>].with[_]>
    - flag player temp.cc.display.wings:<[choice]>
    - adjust <player> curios_item:back|<[item]>

cc_elytra1_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define elytra1 <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - flag player temp.cc.display.elytra1:<[elytra1]>
    - flag player temp.cc.character.elytra1:<[elytra1]>
    - adjust <player> curios_item:back|<proc[get_colored_elytra].context[<player.flag[temp.cc.display.elytra1]>|<player.flag[temp.cc.display.elytra2]>]>

cc_elytra2_select:
  type: task
  debug: false
  definitions: top_menu|submenu|selection
  script:
    - define menu_data <script[cc_open_mini_menu].data_key[data.<[top_menu]>.<[submenu]>]>
    - define elytra2 <player.flag[temp.cc.mini_menu_options].get[<[selection]>]>
    - flag player temp.cc.display.elytra2:<[elytra2]>
    - flag player temp.cc.character.elytra2:<[elytra2]>
    - adjust <player> curios_item:back|<proc[get_colored_elytra].context[<player.flag[temp.cc.display.elytra1]>|<player.flag[temp.cc.display.elytra2]>]>

cc_character_save:
  type: task
  debug: false
  script:
    - flag player character:!
    - if <player.has_flag[temp.cc.character.last_name]>:
      - flag player data.name:<player.flag[temp.cc.character.first_name]>_<player.flag[temp.cc.character.last_name]>
    - else:
      - flag player data.name:<player.flag[temp.cc.character.first_name]>
    - flag player temp.cc.character.name.first:<player.flag[temp.cc.character.first_name]>
    - if <player.has_flag[temp.cc.character.last_name]>:
      - flag player "temp.cc.character.name.display:<player.flag[temp.cc.character.first_name]> <player.flag[temp.cc.character.last_name]>"
      - flag player temp.cc.character.name.last:<player.flag[temp.cc.character.last_name]>
    - else:
      - flag player temp.cc.character.name.display:<player.flag[temp.cc.character.first_name]>
    - flag player temp.cc.character.name.color:<&7>
    - flag player temp.cc.character.name.full_display:<&7><player.flag[temp.cc.character.name.display]>
    - flag player temp.cc.character.knowledge.total:25
    - flag player temp.cc.character.knowledge.current:25
    - flag player temp.cc.character.vision_level:1
    - flag player data.characters.<player.uuid>_<player.flag[data.name]>.initialized:1
    - flag player character:<player.flag[temp.cc.character]>
    - if <player.has_flag[temp.cc.character.skin_code]>:
      - flag server used_character_codes.<player.flag[temp.cc.character.skin_code]>
    - ~run sql_init_inventory
    - ~run sql_init_character_data
    - ~run sql_set_character_data
    - ~run sql_set_player_data
    - narrate "<&e>Character <&b><player.flag[character.name.display]> <&e>has been saved."
    - repeat 4:
      - define slot <[value].sub[1]>
      - adjust <player> cosmetic_armor:<[slot]>|air

name_command:
  type: command
  name: name
  debug: false
  usage: /name
  aliases:
    - firstname
    - lastname
  description: Set yer name
  script:
    - if !<player.has_flag[temp.cc]> || <player.flag[temp.cc.top_menu_value]> != 1:
      - stop
    - choose <context.alias>:
      - case firstname:
        - flag player temp.cc.character.first_name:<context.args.get[1]>
        - flag player "temp.cc.display.First Name:<context.args.get[1]>"
        - run cc_remove_submenu_entities
        - run cc_open_sub_menu def:name
      - case lastname:
        - flag player temp.cc.character.last_name:<context.args.get[1]>
        - flag player "temp.cc.display.Last Name (Optional):<context.args.get[1]>"
        - run cc_remove_submenu_entities
        - run cc_open_sub_menu def:name

character_code_command:
  type: command
  name: ccode
  debug: false
  usage: /ccode
  description: Apply Skin Code
  data:
    itsfuckinme: https://herocraft.world/images/skin.png
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
    productions: https://herocraft.world/images/popzie.png
  script:
    - if !<player.has_flag[temp.cc]> || <player.flag[temp.cc.top_menu_value]> != 1:
      - narrate "<&c>You must be on the 'Name' category."
      - stop
    - if !<script.data_key[data.<context.args.get[1]>].exists>:
      - narrate "<&c>Unknown Character Code<&co> <&b><context.args.get[2]><&c>."
      - stop
    - if <server.has_flag[used_character_codes]> && <server.flag[used_character_codes.<context.args.get[1]>].exists>:
      - narrate "<&c>Character Code has already been redeemed<&co> <&b><context.args.get[1]><&c>."
      - stop
    - flag player temp.cc.character.skin:<script.parsed_key[data.skin_codes.<context.args.get[1]>]>
    - flag player "temp.cc.display.race:<&7>Character Code"
    - flag player "temp.cc.display.tone:<&7>Character Code"
    - flag player "temp.cc.display.eyes:<&7>Character Code"
    - flag player "temp.cc.display.hair:<&7>Character Code"
    - flag player "temp.cc.display.underwear:<&7>Character Code"
    - flag player temp.cc.character.skin:<script.parsed_key[data.<context.args.get[1]>]>
    - flag player temp.cc.character.skin_code:<context.args.get[1]>
    - flag player "temp.cc.display.Skin Code (Optional):<&a>Applied."
    - execute as_server "setskin <script.parsed_key[data.<context.args.get[1]>]> <player.name>"
    - narrate "<&e>Character Code Applied.<&nl><&b>Do Not Change Fields Marked <&7>Character Code"
    - run cc_remove_submenu_entities def:false
    - run cc_open_sub_menu def:name

delete_character_command:
  type: command
  name: delete
  debug: false
  usage: /delete
  description: Delete a Character
  tab completions:
    1: <&dq>Character Name<&dq>
  script:
    - if !<player.has_flag[temp.cs]>:
      - narrate "<&c>You can only use this command on the character selection screen."
      - stop
    - if <context.args.size> < 1:
      - narrate "<&c>You must enter a character name."
      - stop
    - define character <context.args.get[1].replace[<&sp>].with[_]>
    - if !<player.has_flag[data.characters.<player.uuid>_<[character]>]>:
      - narrate "<&c>Unknown Character<&co> <&e><context.args.get[1]>"
      - narrate "<&c>Make sure to put quotation marks around first and last names."
      - stop
    - if <context.args.get[2]||null> != confirm:
      - narrate "<&e>You are going to delete <&b><context.args.get[1].to_titlecase>"
      - narrate "<element[<&a>Click Here To Confirm Deletion].on_click[/delete <[character]> confirm]>"
    - else:
      - flag player data.characters.<player.uuid>_<[character]>:!
      - narrate "<&e>Character Has Been Deleted."
      - run character_selection_remove
      - run character_selection_update def:1