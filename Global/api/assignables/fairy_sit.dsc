fairy_armor_stand:
  type: entity
  debug: false
  entity_type: armor_stand
  mechanisms:
    visible: false
    is_small: true
    marker: true
    gravity: false
  flags:
    on_entity_added: remove_context_entity
    on_dismounted: remove_context.entity

fairy_sit:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - if <player.flag[character.race]> != fae:
      - narrate "<&c>You are way too big!"
      - stop
    - mount <player>|fairy_armor_stand <context.entity.location.above[2]>