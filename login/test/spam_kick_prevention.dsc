spam_kick_fix:
  type: world
  debug: false
  events:
    on player kicked:
      - if <context.reason> == "Kicked for spamming":
        - determine cancelled