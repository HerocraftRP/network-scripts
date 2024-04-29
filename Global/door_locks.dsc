door_lock_create:
  type: task
  debug: false
  definitions: uuid
  script:
    - define uuid <util.random_uuid> if:<[uuid].exists.not>
    - define door_blocks <player.cursor_on.flood_fill[4]>
    - foreach <[door_blocks]>:
      - flag <[value]> on_right_click:door_lock_interact
      - flag <[value]> door.lock:<[uuid]>
      - flag <[value]> door.locked:true
      - flag <[value]> door.group:<[door_blocks]>

door_lock_interact:
  type: task
  debug: false
  script:
    - if !<player.is_sneaking>:
      - if !<context.location.flag[door.locked]>:
        - stop
      - else:
        - narrate "<&e>This door is locked."
    - else:
      - if <player.item_in_hand.has_flag[lock_uuid]> && <player.item_in_hand.flag[lock_uuid]>:
        - if <context.location.flag[door.locked]>:
          - run start_timed_action "def:<&e>Unlocking Door|2s|door_unlock|<context.location>" def.can_move:false
        - else:
          - run start_timed_action "def:<&e>Locking Door|2s|door_lock|<context.location>" def.can_move:false
      - else:
        - run start_timed_action "def:<&c>Lockpicking Door|10s|door_lockpick|<context.location>" def.can_move:false def.must_stay_sneak:true def.animation_task:door_lockpick_animation
    - determine cancelled

door_lock_key:
  type: item
  debug: false
  material: tripwire_hook
  display name: <&6>Key
  flags:
    right_click_script: door_lock_cancel

door_lock_cancel:
  type: task
  debug: false
  script:
    - if !<context.location.has_flag[door]>:
      - determine cancelled

door_get_key:
  type: task
  debug: false
  script:
    - define UUID <player.cursor_on.flag[door.lock]>
    - define key <item[door_lock_key]>
    - flag <[key]> lock_uuid:<[uuid]>
    - give <[key]>

door_unlock:
  type: task
  debug: false
  definitions: door
  script:
    - foreach <[door].flag[door.group]>:
      - flag <[value]> door.locked:false
    - narrate "<&e>Door Unlocked."
    - playsound sound:BLOCK_CHEST_OPEN <[door]> volume:0.75

door_lock:
  type: task
  debug: false
  definitions: door
  script:
    - foreach <[door].flag[door.group]>:
      - flag <[value]> door.locked:true
    - narrate "<&e>Door Locked."
    - playsound sound:BLOCK_CHEST_LOCKED <[door]> volume:0.75

door_lockpick:
  type: task
  debug: false
  script:
    - bossbar update timed_action_<player.uuid> title:<&c>Failed! progress:1 color:RED
    - narrate "<&c>You failed to lockpick the door."
    - wait 3s
    - if !<player.has_flag[timed_action]> && <player.bossbar_ids.contains[timed_action_<player.uuid>]>:
      - bossbar remove timed_action_<player.uuid>

door_lockpick_animation:
  type: task
  debug: false
  script:
    - animate <player> animation:ARM_SWING