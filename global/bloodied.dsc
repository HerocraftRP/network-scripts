bloodied_system:
  type: world
  debug: false
  enabled: false
  events:
    on player damages entity bukkit_priority:HIGHEST:
      - stop if:<context.entity.is_spawned.not>
      - if <context.entity.location.distance[<context.damager.location>]> > 4:
        - stop
      - stop if:<context.entity.entity_type.equals[DUMMMMMMY_TARGET_DUMMY]>
      - stop if:<player.item_in_hand.has_flag[weapon_type].not>
      - foreach <list[<player.held_item_slot>].include[37|38|39|40|41]>:
        - if <player.inventory.slot[<[value]>].material.name> != air:
          - define name <player.inventory.slot[<[value]>].flag[display]||null>
          - if <[name]> == null:
            - define flag_for_name true
            - define name <player.inventory.slot[<[value]>].display.to_titlecase||null>
          - if <[name]> == null:
            - define name <&r><player.inventory.slot[<[value]>].material.name.replace[_].with[<&sp>].to_titlecase>
          - inventory flag slot:<[value]> display:<[name]>
          - inventory adjust slot:<[value]> "display:<&c>Bloodied <[name]>" if:<player.inventory.slot[<[value]>].has_flag[bloodied].not>
          - inventory set slot:<[value]> d:<player.inventory> o:<player.inventory.slot[<[value]>].with_flag[bloodied:<util.time_now>]>
          - run interactions_add_to_item def:<[value]>|bloodied_inspect|<&e>Inspect
          - run interactions_add_to_item def:<[value]>|bloodied_wash|<&e>Wash

bloodied_wash:
  type: task
  debug: false
  script:
    - if <player.eye_location.forward[2].find_blocks[water].within[1.5].size> >= 1 || <player.cursor_on[2.5].flag[on_right_click]||null> == cooking_get_water:
      - run start_timed_action "def:Washing <player.item_in_hand.display||<player.item_in_hand.material.name.replace[_].with[<&sp>].to_titlecase>>|10s|bloodied_finish|null|false|false" def.animation_task:bloodied_wash_animation

bloodied_inspect:
  type: task
  debug: false
  script:
    - narrate "<&e>Upon inspection this seem to be bloodied about <player.item_in_hand.flag[bloodied].from_now.formatted> ago."

bloodied_wash_animation:
  type: task
  debug: false
  script:
    - animate animation:ARM_SWING <player>
    - playsound sound:BLOCK_WATER_AMBIENT <player.location> volume:10

bloodied_use:
  type: task
  debug: false
  script:
    - stop if:<player.is_sneaking.not>
    - determine passively cancelled
    - if <player.eye_location.forward[2].material.name> == water:
      - run start_timed_action "def:Washing <player.item_in_hand.display||<player.item_in_hand.material.name.replace[_].with[<&sp>].to_titlecase>>|10s|bloodied_finish|null|false|false"
    - else:
      - narrate "<&e>Upon inspection this seem to be bloodied about <player.item_in_hand.flag[bloodied].from_now.formatted> ago."

bloodied_finish:
  type: task
  debug: false
  script:
    - define name <player.item_in_hand.flag[display]||null>
    - if <[name]> == null:
      - define name <&r><player.item_in_hand.material.name.replace[_].with[<&sp>].to_titlecase>
    - inventory adjust slot:<player.held_item_slot> "display:<[name]>"
    - inventory flag slot:<player.held_item_slot> bloodied:!
    - playsound sound:entity_experience_orb_pickup <player> volume:3
    - run interaction_remove_from_item def:<player.held_item_slot>|2
    - run interaction_remove_from_item def:<player.held_item_slot>|1
    - narrate "<&e>You washed the blood off of your item"