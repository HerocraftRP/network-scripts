main_menu_from_creation:
  type: task
  debug: false
  script:
    - teleport <player.flag[character_location].forward_flat[5.5].left[0.5].below[2].with_yaw[180]>
    - define locations <list[<player.flag[character_location].forward_flat[5.5].left[0.5].with_yaw[180]>]>
    - define locations <[locations].include[<player.flag[mm_location].forward_flat[4].above[2].with_yaw[90]>]>
    - execute as_server "cam-server create test_<player.uuid>"
    - execute as_server "cam-server get test_<player.uuid> mode default"
    - foreach <[locations]> as:loc:
      - execute as_server "cam-server get test_<player.uuid> add <[loc].x> <[loc].y.sub[0.4]> <[loc].z> <[loc].yaw> 0 0 70"
    - execute as_server "cam-server start test_<player.uuid> <player.name> 3s"
    - execute as_server "cam-server remove test_<player.uuid>"
    - wait 4.25s
    - run main_menu_start

main_menu_start:
  type: task
  debug: false
  data:
    Explanation_Text: <&e>Use your <&b>Arrow Keys<&e> to Navigate Character Creation<&nl>Hit <&b>Right CTRL<&e> to Select an Option
    existing_character: <&7>Existing Character
    new_character: <&7>New Character
  definitions: selected
  script:
    - perspective ENUM:1
    - if !<player.has_flag[mm_location]>:
      - flag player mm_location:<player.flag[character_location].sub[5,2,-11].with_yaw[-90]>
    - define mm_location <player.flag[mm_location]>
    - teleport <[mm_location].forward_flat[5].above[2].with_yaw[90].backward_flat[0.5]>
    - spawn camera_stand <[mm_location].forward_flat[4].below[0.1].with_yaw[90]> save:as1
    - adjust <player> spectate:<entry[as1].spawned_entity>
    - if <player.has_flag[temp.mm.entities]>:
      - run mm_remove_entities
    - define selected 0 if:<[selected].exists.not>
    - flag <player> temp.mm.selected:<[selected]>
    - repeat 4:
      - define slot <[value].sub[1]>
      - adjust <player> cosmetic_armor:<[slot]>|air
    - run main_menu_update def:<[selected]>
    - repeat 10:
      - stop if:<player.has_flag[temp.mm].not>
      - adjust <player> spectate:<entry[as1].spawned_entity>
      - wait 10t

main_menu_update:
  type: task
  debug: false
  data:
    Explanation_Text: <&e>Use your <&b>Arrow Keys<&e> to Navigate Character Selection<&nl>Hit <&b>Right CTRL<&e> to Select an Option
    existing_character: <&7>Existing Character
    new_character: <&7>New Character
  definitions: selected
  script:
    - define mm_location <player.flag[mm_location]>
    - if <player.has_flag[temp.mm.entities]>:
      - run mm_remove_entities
    - define selected 0 if:<[selected].exists.not>
    - spawn cc_text_display[text=<script.parsed_key[data.explanation_text]>] <player.flag[mm_location].above[3]> save:as1
    - teleport <entry[as1].spawned_entity> <player.flag[character_location].sub[5,-1,-11].with_yaw[-90]>
    - flag <player> temp.mm.entities:->:<entry[as1].spawned_entity>
    - if <[selected]> == 0:
      - spawn cc_text_display[text=<&a><&lb><&sp><script.parsed_key[data.existing_character]><&sp><&a><&rb>] <player.flag[mm_location].above[2].right.with_yaw[-180]> save:as2
    - else:
      - spawn cc_text_display[text=<script.parsed_key[data.existing_character]>] <player.flag[mm_location].above[2].right.with_yaw[-180]> save:as2
    - teleport <entry[as2].spawned_entity> <player.flag[mm_location].above[2].right[1.5].with_yaw[-90]>
    - flag <player> temp.mm.entities:->:<entry[as2].spawned_entity>
    - if <[selected]> == 1:
      - spawn cc_text_display[text=<&a><&lb><&sp><script.parsed_key[data.new_character]><&sp><&a><&rb>] <player.flag[mm_location].above[2].left.with_yaw[-180]> save:as3
    - else:
      - spawn cc_text_display[text=<script.parsed_key[data.new_character]>] <player.flag[mm_location].above[2].left.with_yaw[-180]> save:as3
    - teleport <entry[as3].spawned_entity> <player.flag[mm_location].above[2].left[1.5].with_yaw[-90]>
    - flag <player> temp.mm.entities:->:<entry[as3].spawned_entity>
    - flag <player> temp.mm.selected:<[selected]>

mm_remove_entities:
  type: task
  debug: false
  script:
    - foreach <player.flag[temp.mm.entities]>:
      - if <[value].is_spawned>:
        - remove <[value]>
    - flag <player> temp.mm.entities:!