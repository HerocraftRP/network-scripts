start_timed_action:
 type: task
 debug: false
 definitions: action|duration|callback|callback_data|can_move|can_swap_items|must_stay_sneak|distance_from_origin|must_stare_at_target|must_stare_at_block|must_stare|target|animation_task|cancel_script
 script:
    - stop if:<player.has_flag[timed_action]>
    - if !<[can_move]||true>:
      - flag <player> on_move:cancel_timed_action_move
    - if <[must_stare]||false>:
      - flag <player> timed_action.yaw:<player.location.yaw>
      - flag <player> timed_action.pitch:<player.location.pitch>
    - flag <player> timed_action.location:<player.location.with_pose[0,0]>
    - if !<[can_swap_items]||true>:
      - define held_item <player.item_in_hand>
    - flag <player> timed_action.queue:<queue>
    - bossbar timed_action_<player.uuid> players:<player> "title:<[action]>" color:BLUE progress:0
    - define totalDuration <duration[<[duration]>].in_seconds.mul[4].round_up>
    - repeat <[totalDuration]>:
      - if !<player.is_online> || !<player.has_flag[timed_action]>:
        - stop
      - if !<[can_swap_items]||true>:
        - if <player.item_in_hand> != <[held_item]>:
          - run cancel_timed_action def:<[cancel_script]||null>
          - stop
      - if <[must_stare]||false>:
        - if <player.flag[timed_action.pitch].sub[<player.location.pitch>].abs> > 40 || <player.flag[timed_action.yaw].sub[<player.location.yaw>].abs> > 50:
          - narrate <player.flag[timed_action.pitch].sub[<player.location.pitch>].abs>[----]<player.flag[timed_action.yaw].sub[<player.location.yaw>].abs>
          - run cancel_timed_action def:<[cancel_script]||null>
          - stop
      - if <[must_stay_sneak]||false>:
        - if !<player.is_sneaking>:
          - run cancel_timed_action def:<[cancel_script]||null>
          - stop
      - if <[distance_from_origin].exists> && <player.location.distance[<player.flag[timed_action.location]>]> > <[distance_from_origin]>:
        - run cancel_timed_action def:<[cancel_script]||null>
        - stop
      - if <[must_stare_at_target].exists> && <player.target> != <[target]>:
        - run cancel_timed_action def:<[cancel_script]||null>
        - stop
      - if <[must_stare_at_block].exists> && <player.cursor_on[6]> != <[target]>:
        - run cancel_timed_action def:<[cancel_script]||null>
        - stop
      - if !<player.has_flag[timed_action]>:
        - stop
      - bossbar update timed_action_<player.uuid> progress:<[value].div[<[totalDuration]>]> color:BLUE
      - if <[animation_task]||null> != null && <[value].mod[4]> == 0:
        - run <[animation_task]>
      - wait 5t
    - wait 5t
    - if <[animation_task]||null> != null:
      - flag <player> animation_stage:!
    - bossbar update timed_action_<player.uuid> title:<&a>Complete! progress:1 color:GREEN
    - if !<[can_move]||false>:
      - flag <player> on_move:!
    - run <[callback]> def:<[callback_data]||null>
    - flag <player> timed_action:!
    - flag <player> temp.timed_action:!
    - wait 3s
    - if !<player.has_flag[timed_action]> && <player.bossbar_ids.contains[timed_action_<player.uuid>]>:
      - bossbar remove timed_action_<player.uuid>

cancel_timed_action_move:
  type: task
  debug: false
  definitions: cancel_script
  script:
    - stop if:<player.location.with_pose[0,0].equals[<player.flag[timed_action.location]>]>
    - if <[cancel_script]||null> != null:
      - run <[cancel_script]>
    - flag <player> temp.timed_action:!
    - flag <player> on_move:!
    - if <player.flag[timed_action.queue].is_valid>:
      - bossbar update timed_action_<player.uuid> title:<&c>Interrupted color:RED progress:1
    - flag <player> timed_action:!
    - wait 3s
    - if !<player.has_flag[timed_action]> && <player.bossbar_ids.contains[timed_action_<player.uuid>]>:
      - bossbar remove timed_action_<player.uuid>

cancel_timed_action:
  type: task
  debug: false
  definitions: cancel_script
  script:
    - if <[cancel_script]||null> != null:
      - run <[cancel_script]>
    - flag <player> temp.timed_action:!
    - flag <player> on_move:!
    - if <player.flag[timed_action.queue].is_valid>:
      - bossbar update timed_action_<player.uuid> title:<&c>Interrupted color:RED progress:1
    - flag <player> timed_action:!
    - wait 3s
    - if !<player.has_flag[timed_action]> && <player.bossbar_ids.contains[timed_action_<player.uuid>]>:
      - bossbar remove timed_action_<player.uuid>

announce_test:
  type: task
  debug: false
  script:
    - announce test