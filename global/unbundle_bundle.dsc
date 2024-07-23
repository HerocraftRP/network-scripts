unbundle_bundle:
  type: task
  debug: false
  script:
      - define job <player.item_in_hand.script.name.before[_]>
      - define item <player.item_in_hand.script.name.before[_bundle]>
      - define amount <server.flag[google_data.<[job]>.<[item].after[_]>.bundle_size]>
      - flag player temp.timed_action.item:<[item]>
      - flag player temp.timed_action.amount:<[amount]>
      - run start_timed_action "def:<&6>Unbundling...|5s|unbundle_callback|<player.item_in_hand>" def.can_swap_items:false def.animation_task:unbundle_animation

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
    - give item:empty_bundle
    - repeat <player.flag[temp.timed_action.amount]>:
      - give item:<item[<player.flag[temp.timed_action.item]>].with_flag[UUID=<util.random_uuid>]>