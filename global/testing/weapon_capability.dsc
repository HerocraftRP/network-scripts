weapon_skill:
  type: world
  debug: false
  events:
    on entity damaged by player with:item_flagged:weapon_type:
      - if <context.cause> == ENTITY_ATTACK:
        - define type <context.damager.item_in_hand.flag[weapon_type]>
        - define capability_needed <context.damager.item_in_hand.flag[capability_needed]>
        - if <player.flag[character.capabilities.<[type]>]||0> < <[capability_needed]>:
          - determine passively 0.2
          - ratelimit <player>_<[type]> 1m
          - narrate "<&c>You lack to ability to properly wield this weapon, and do virtually no damage."