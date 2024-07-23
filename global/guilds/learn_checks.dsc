guild_learn_check:
  type: task
  debug: false
  script:
    - define guild <player.item_in_hand.flag[capability]>
    - define skill <player.item_in_hand.flag[skill]>
    - if <player.flag[character.capabilities.<[guild]>]||0> < <script[capabilities_data].data_key[capability.<[guild]>.checks.<[skill]>]>:
        - narrate "<&c>This skill is beyond your capabilities."
        - inventory close
        - determine cancelled