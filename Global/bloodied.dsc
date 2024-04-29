bloodied_system:
  type: world
  debug: false
  events:
    on player damages entity bukkit_priority:HIGHEST:
      - stop if:<context.damager.item_in_hand.material.name.equals[air]>
      - stop if:<context.entity.is_living.not>
      - if <context.entity.location.distance[<context.damager.location>]> > 4:
        - stop
      - foreach <list[<player.held_item_slot>].include[37|38|39|40|41]>:
        - if <player.inventory.slot[<[value]>].material.name> != air:
          - inventory set slot:<[value]> d:<player.inventory> o:<player.inventory.slot[<[value]>].with[lore=<&c>Bloodied].with_flag[bloodied:<util.time_now>].with_flag[right_click_script:bloodied_use]>

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
      - inventory set slot:<player.held_item_slot> d:<player.inventory> o:<player.item_in_hand.with[lore=].with_flag[bloodied:!].with_flag[right_click_script:!]>
      - narrate "<&e>You washed the blood off of your item"