unbundle_bundle:
  type: task
  debug: false
  script:
    - if <player.is_sneaking>:
        - define job <context.item.script.name.before[_]>
        - define item <context.item.script.name.after[_].before[_bundle]>
        - define amount <server.flag[google_data.<[job]>.<[item]>.bundle_size]>
        - flag player temp.timed_action.item:<[item]>
        - flag player temp.timed_action.amount:<[amount]>
        - run start_timed_action "def:<&6>Unbundling...|5s|unbundle_callback|<context.item_in_hand>" def.must_stay_sneak:true def.can_swap_items:false def.animation_task:unbundle_animation

unbundle_animation:
  type: task
  debug: false
  script:
    - animate <player> animation:ARM_SWING

unbundle_callback:
  type: task
  debug: false
  script:
    - take iteminhand
    - give item:<player.flag[temp.timed_action.item]> quantity:<player.flag[temp.timed_action.amount]>