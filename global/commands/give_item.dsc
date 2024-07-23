give_item:
  type: command
  name: give_item
  debug: false
  usage: /give_item
  description: gives your held item to the player you're looking at
  script:
    - ratelimit <player> 1s
    - define target <player.precise_target[3]||null>
    - if <[target]> == null:
      - stop
    - if !<[target].location.facing[<player>]>:
      - narrate "<&c>They are not facing you."
      - stop
    - if <player.item_in_hand.material.name> == air:
      - narrate "<&c>You aren't holding any item."
      - stop
    - if <[target].entity_type> != PLAYER:
      - if !<[target].has_flag[on_give_item]>:
        - narrate "<&c>They don't want this."
        - stop
      - else:
        - inject <[target].flag[on_give_item]>
        - stop
    - define item <player.item_in_hand>
    - inventory set slot:<player.held_item_slot> o:air
    - give item:<[item]> to:<[target].inventory>
    - define item_name <[item].display||null>
    - if <[item_name]> == null:
      - define item_name <[item].script.name.replace[_].with[<&sp>].to_titlecase||null>
    - if <[item_name]> == null:
      - define item_name <[item].material.name.replace[_].with[<&sp>].to_titlecase||null>
    - narrate "<&e>You have given <[item_name]><&e> to them."
    - narrate "<&e>You were given <[item_name]><&e>." targets:<[target]>
