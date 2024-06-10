mute_sign_language:
  type: world
  debug: false
  definitions: words
  events:
    on player chats bukkit_priority:LOWEST:
      - if <player.has_flag[temp.above_head_text.list]> && <player.flag[temp.above_head_text.list].size> > 5:
        - narrate "<&c>You must slow down with Sign Language."
        - stop
      - if !<player.has_flag[temp.above_head_text]>:
        - run lines_above_head_add "def:<&e>(Sign Language)|true"
      - foreach <context.message.split_lines_by_width[200].replace[<&nl>].with[|]>:
        - run lines_above_head_add def:<[value]>|false
        - wait 1s

armor_stand_above_head:
  type: entity
  debug: false
  entity_type: armor_stand
  mechanisms:
    is_small: true
    gravity: false
    visible: false
    custom_name_visible: true
  flags:
    on_entity_added: remove_context_entity

lines_above_head_loop:
  type: task
  debug: false
  script:
    - wait 1t
    - while <player.has_flag[temp.above_head_text]> && <player.flag[temp.above_head_text.list].size> > 1:
      - foreach <player.flag[temp.above_head_text.list]>:
        - teleport <[value]> <player.location.above[<[loop_index].mul[0.3].add[0.75]>]>
      - wait 1t
    - remove <player.flag[temp.above_head_text.top]>
    - flag <player> temp.above_head_text:!

lines_above_head_add:
  type: task
  debug: false
  definitions: line|top
  script:
    - spawn armor_stand_above_head[custom_name=<[line]>] save:as1
    - if !<player.has_flag[temp.above_head_text]>:
      - run lines_above_head_loop
    - flag player temp.above_head_text.list:<player.flag[temp.above_head_text.list].insert[<entry[as1].spawned_entity>].at[1]||<list[<entry[as1].spawned_entity>]>>
    - if <[top]>:
      - flag player temp.above_head_text.top:<entry[as1].spawned_entity>
      - stop
    - wait 10s
    - remove <entry[as1].spawned_entity>
    - flag player temp.above_head_text.list:<-:<entry[as1].spawned_entity>