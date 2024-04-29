cough_drop:
  type: command
  name: cough_drop
  description: take a cough drop, to fix your voice
  usage: /cough_drop
  script:
    - execute as_player "vrc" silent
    - narrate "You take a cough drop to soothe your voice"