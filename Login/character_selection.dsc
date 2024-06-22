character_selection_from_main:
  type: task
  debug: false
  script:
    - define sc_location <player.flag[mm_location].add[5,3.5,4]>
    - teleport <player.flag[mm_location].forward_flat[4].above[2].with_yaw[90].below[2]>
    - define locations <list[<player.flag[mm_location].forward_flat[4].above[2].with_yaw[90]>]>
    - define locations <[locations].include[<[sc_location].with_yaw[0]>]>
    - execute as_server "cam-server create test_<player.uuid>"
    - execute as_server "cam-server get test_<player.uuid> mode default"
    - foreach <[locations]> as:loc:
      - execute as_server "cam-server get test_<player.uuid> add <[loc].x> <[loc].y.sub[0.4]> <[loc].z> <[loc].yaw> 0 0 70"
    - execute as_server "cam-server start test_<player.uuid> <player.name> 3s"
    - execute as_server "cam-server remove test_<player.uuid>"
    - wait 4.25s
    - run character_selection_start

character_selection_to_main:
  type: task
  debug: false
  script:
    - define sc_location <player.flag[mm_location].add[5,3.5,4]>
    - teleport <[sc_location].below[2].with_yaw[0]>
    - define locations <list[<[sc_location].with_yaw[0]>]>
    - define locations <[locations].include[<player.flag[mm_location].forward_flat[4].above[2].with_yaw[90]>]>
    - execute as_server "cam-server create test_<player.uuid>"
    - execute as_server "cam-server get test_<player.uuid> mode default"
    - foreach <[locations]> as:loc:
      - execute as_server "cam-server get test_<player.uuid> add <[loc].x> <[loc].y.sub[0.4]> <[loc].z> <[loc].yaw> 0 0 70"
    - execute as_server "cam-server start test_<player.uuid> <player.name> 3s"
    - execute as_server "cam-server remove test_<player.uuid>"
    - wait 4.25s
    - execute as_server "emotes stop <player.name>"
    - run main_menu_start

character_particles:
  type: task
  debug: false
  script:
    - while <player.has_flag[temp.cs]>:
      - playeffect effect:cloud at:<player.location.below[0.5]> offset:0.5,0.1,0.5 quantity:25
      - wait 2t

character_selection_start:
  type: task
  debug: false
  data:
    Explanation_Text: <&e>Use your <&b>Arrow Keys<&e> to Navigate Character Creation<&nl>Hit <&b>Right CTRL<&e> to Select an Option
    existing_character: <&7>Existing Character
    new_character: <&7>New Character
  definitions: selected
  script:
    - define sc_location <player.flag[mm_location].add[5,3.5,4]>
    - teleport <[sc_location]>
    - spawn camera_stand <[sc_location].below[2.1].with_yaw[0]> save:as1
    - adjust <player> spectate:<entry[as1].spawned_entity>
    - adjust <player> gravity:false
    - teleport <[sc_location].below[1.4].with_yaw[0].forward_flat[4].right[0.4].with_yaw[180]>
    - modifyblock <player.location.below> barrier
    - modifyblock <player.location.add[1,0,0]> light[level=15]
    - modifyblock <player.location.add[-1,0,0]> light[level=15]
    - define sc_menu_location <[sc_location].below[1.6].with_yaw[0].forward_flat[4].left.with_yaw[180]>
    - execute as_server "emotes play '[n7+] Jesus+' <player.name>"
    - run load_character def:<player.flag[data.characters].keys.first.after[_]>
    - flag player temp.cs
    - run character_particles
    - run character_selection_update def:1

character_selection_remove:
  type: task
  debug: false
  script:
    - foreach <player.flag[temp.sc.entities]>:
      - if <[value].is_spawned>:
        - remove <[value]>
    - flag <player> temp.sc.entities:!

character_selection_update:
  type: task
  debug: false
  data:
    Explanation_Text: <&e>Use your <&b>Arrow Keys<&e> to Navigate Character Selection<&nl>Hit <&b>Right CTRL<&e> to Select an Option
    existing_character: <&7>Existing Character
    new_character: <&7>New Character
  definitions: selected
  script:
    - define sc_location <player.flag[mm_location].add[5,3.5,4]>
    - define sc_topmenu_location <[sc_location].below[1.6].with_yaw[0].forward_flat[4].above[3].with_yaw[180]>
    - define sc_menu_location <[sc_location].above[0.8].with_yaw[0].forward_flat[4].left[2].with_yaw[180]>
    - define sc_menu_spawn_location <[sc_location].above[10].with_yaw[0].left.with_yaw[180]>
    - spawn cc_text_display[text=<script.parsed_key[data.explanation_text]>] <[sc_menu_spawn_location]> save:as1
    - teleport <entry[as1].spawned_entity> <[sc_topmenu_location]>
    - flag <player> temp.sc.entities:->:<entry[as1].spawned_entity>
    - flag player temp.sc.menu_value:<[selected]>
    - define changed false
    - foreach <player.flag[data.characters]>:
      - define character <[key].after[_].replace[_].with[<&sp>].to_titlecase>
      - if <[loop_index]> == <[selected]>:
        - if <[key].after[_]> != <player.flag[temp.sc.selected_character]||noop>:
          - define changed true
          - flag player temp.sc.selected_character:<[key].after[_]>
        - spawn "cc_text_display[text=<&a>--<&sp><&7><[character]><&a><&sp>--]" <[sc_menu_spawn_location]> save:as1
      - else:
        - spawn "cc_text_display[text=<&7><[character]>]" <[sc_menu_spawn_location]> save:as1
      - teleport <entry[as1].spawned_entity> <[sc_menu_location].below[<[loop_index].sub[1].mul[0.4]>]>
      - flag <player> temp.sc.entities:->:<entry[as1].spawned_entity>
      - define li <[loop_index]>
    - if <player.flag[temp.sc.menu_value]> == <player.flag[data.characters].size.add[1]>:
      - spawn "cc_text_display[text=<&a>--<&sp><&e>Back<&a><&sp>--]" <[sc_menu_spawn_location]> save:as1
    - else:
      - spawn "cc_text_display[text=<&e>Back]" <[sc_menu_spawn_location]> save:as1
    - teleport <entry[as1].spawned_entity> <[sc_menu_location].below[<[li].mul[0.4]>]>
    - flag <player> temp.sc.entities:->:<entry[as1].spawned_entity>
    - spawn "cc_text_display[text=<&e>To Delete A Character]" <[sc_menu_spawn_location]> save:as1
    - teleport <entry[as1].spawned_entity> <[sc_menu_location].add[-5,0,0]>
    - flag <player> temp.sc.entities:->:<entry[as1].spawned_entity>
    - spawn "cc_text_display[text=<&b>/delete '(character name)']" <[sc_menu_spawn_location]> save:as1
    - teleport <entry[as1].spawned_entity> <[sc_menu_location].add[-5,-0.3,0]>
    - flag <player> temp.sc.entities:->:<entry[as1].spawned_entity>
    - if <[changed]>:
      - run load_character def:<player.flag[temp.sc.selected_character]>

load_character:
  type: task
  debug: false
  definitions: character
  data:
    armor_map:
      feet: 0
      bottom: 1
      top: 2
      helmet: 3
  script:
    - flag player data.name:<[character]>
    - ~run sql_get_character_data
    - if !<player.has_flag[character.skin]>:
      - stop
    - execute as_server "setskin <player.flag[character.skin]> <player.name>"
    - execute as_server "scale set pehkui:base <script[cc_race_select].data_key[data.races.<player.flag[character.race]>.base_scale]> <player.name>"
    - execute as_server "scale set pehkui:width <player.flag[character.weight]> <player.name>"
    - execute as_server "scale set pehkui:height <player.flag[character.height]> <player.name>"
    - execute as_server "setmodel <player.flag[character.model]> <player.name>"
    - foreach <player.flag[character.clothing]>:
      - adjust <player> cosmetic_armor:<script.data_key[data.armor_map.<[key]>]>|<script[clothing_data].data_key[clothes.<script.data_key[data.armor_map.<[key]>]>.<[value]>.material]>
    - if <player.has_flag[character.wings]> || <player.has_flag[character.elytra1]>:
      - if <player.has_flag[character.wings]>:
        - adjust <player> curios_item:back|<player.flag[character.wings]>
      - if <player.has_flag[character.elytra1]>:
        - adjust <player> curios_item:back|<proc[get_colored_elytra].context[<player.flag[character.elytra1]>|<player.flag[character.elytra2]>]>
    - else:
      - adjust <player> curios_item:back|air