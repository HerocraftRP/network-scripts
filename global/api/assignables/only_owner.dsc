only_owner:
  type: task
  debug: false
  script:
    - if <context.item.flag[owner_id]> != <player.flag[character.id]>:
      - determine cancelled