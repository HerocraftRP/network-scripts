EFM_test:
  type: world
  debug: false
  events:
    on efm server action:
      - announce "EFM ACTION - <context.name>"
    on player consumed skill:
      - if <player.has_flag[temp.emote.name]>:
        - run cancel_emotes