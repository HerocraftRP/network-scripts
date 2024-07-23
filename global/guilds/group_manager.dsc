group_types:
  type: data
  data:
    types:
      housing:
        max_members: 6
        switches: Build|Break|Use|Containers
        has_ranks: false
        ranks: <list>
      order:
        max_memers: 12
        switches: None
        has_ranks: true
        ranks:
          - initiate
          - follower
          - priest
          - high priest
          - chosen

group_manager_create:
  type: task
  debug: false
  definitions: group|group_type|target
  script:
    - stop if:<script[group_types].data_key[data.types.<[group_type]>].exists.not>
    - define target <player> if:<[target].exists.not>
    - flag server groups.<[group_type]>.<[group]>:!
    - flag server groups.<[group_type]>.<[group]>.owner.character:<[target].flag[data.name]>
    - flag server groups.<[group_type]>.<[group]>.owner.uuid:<[target].uuid>
    - flag server groups.<[group_type]>.<[group]>.members.<[target].uuid>.rank:Owner
    - flag server groups.<[group_type]>.<[group]>.members.<[target].uuid>.name:<player.flag[character.name.display]>
    - flag server groups.<[group_type]>.<[group]>.names.<[target].flag[data.name]>:<[target].uuid>

group_manager_set_member:
  type: task
  debug: false
  definitions: group_type|group|target|rank|switches_single
  script:
    - stop if:<server.has_flag[groups.<[group_type]>.<[group]>].not>
    - define target <player> if:<[target].exists.not>
    - if <[switches_single].exists>:
      - foreach <script[group_types].data_key[data.types.<[group_type]>.switches]>:
        - if <[switches_single].contains[<[value]>]>:
          - define map <[map].with[<[value]>].as[true]>
        - else:
          - define map <[map].with[<[value]>].as[false]>s
      - flag server groups.<[group_type]>.<[group]>.members.<[target].uuid>.switches:<[map]>
    - flag server groups.<[group_type]>.<[group]>.members.<[target].uuid>.rank:<[rank]> if:<[rank].exists>
    - flag server groups.<[group_type]>.<[group]>.members.<[target].uuid>.name:<player.flag[data.name]>
    - flag server groups.<[group_type]>.<[group]>.names.<[target].flag[data.name]>:<[target].uuid>

group_manager_remove_member:
  type: task
  debug: true
  definitions: group_type|group|target_UUID
  script:
    - stop if:<server.has_flag[groups.<[group_type]>.<[group]>].not>
    - define target <player[<[target_UUID]>]>
    - if !<server.has_flag[groups.<[group_type]>.<[group]>.members.<[target_UUID]>.name]>:
      - stop
    - define name <server.flag[groups.<[group_type]>.<[group]>.members.<[target_UUID]>.name]>
    - flag server groups.<[group_type]>.<[group]>.members.<[target_UUID]>:!
    - flag server groups.<[group_type]>.<[group]>.names.<[name]>:!

group_manager_set_switch:
  type: task
  debug: false
  definitions: group_type|group|switch|value|target
  script:
    - stop if:<script[group_types].data_key[data.types.<[group_type]>.switches].exists.not>
    - stop if:<server.has_flag[groups.<[group_type]>.<[group]>].not>
    - define target <player> if:<[target].exists.not>
    - define map <server.flag[groups.<[group_type]>.<[group]>.members.<[target].uuid>]>
    - flag server groups.<[group_type]>.<[group]>.members.<[target].uuid>:<[map].with[<[switch]>].as[<[value]>]>

group_manager_inventory:
  type: inventory
  debug: false
  inventory: chest
  size: 54
  data:
    drag: cancel
    any_click: cancel

group_manager_inventory_open:
  type: task
  debug: false
  script:
    - define inv <inventory[group_manager_inventory]>
