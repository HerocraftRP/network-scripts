guild_learn_check:
  type: task
  debug: false
  script:
    - define guild <player.item_in_hand.flag[guild]>
    - define skill <player.item_in_hand.flag[skill]>
    - if <player.flag[character.reputation.<[guild]>]||0> < <script[guild_data].data_key[data.<[guild]>.skill_checks.<[skill]>]>:
        - narrate "<&c>This skill is beyond your capabilities."
        - inventory close
        - determine cancelled


#epicfight_skillbook[raw_nbt=map@[skill=string:epicfight:guard]]
#epicfight_skillbook[raw_nbt=map@[skill=string:epicfight:parrying]]
#epicfight_skillbook[raw_nbt=map@[skill=string:wom:arrow_tenacity]]
#epicfight_skillbook[raw_nbt=map@[skill=string:epicfight:stamina_pillager]]
#epicfight_skillbook[raw_nbt=map@[skill=string:wom:dodge_master]]