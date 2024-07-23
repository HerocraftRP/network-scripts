stray_dog:
  type: task
  debug: false
  script:
    - if <player.is_sneaking>:
      - run start_timed_action "def:<&6>Petting <&b>Stray Dog|5s|stray_dog_result|<context.entity>" def.must_stay_sneak:true def.must_stare_at_target:true def.target:<context.entity> def.animation_task:stray_dog_animate

stray_dog_result:
  type: task
  debug: false
  definitions: dog
  script:
    - if <util.random_boolean>:
      - animate animation:WOLF_HEARTS <[dog]>
    - else:
      - animate animation:WOLF_SHAKE <[dog]>

stray_dog_animate:
  type: task
  debug: false
  script:
    - animate animation:ARM_SWING <player>