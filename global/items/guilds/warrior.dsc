warrior_skill_book_guard:
  type: item
  debug: false
  material: epicfight_skillbook
  display name: <&6>Skill Book<&co> <&e>Guard
  lore:
    - <&6>Guild<&co> <script[guild_data].parsed_key[data.warrior.color]>Warrior
    - <&6>Reputation Needed<&co> <&e><script[guild_data].parsed_key[data.warrior.skill_checks.guard]>
  flags:
    guild: warrior
    skill: guard
    right_click_script: guild_learn_check
  mechanisms:
    raw_nbt: <map.with[skill].as[string:epicfight:guard]>

warrior_skill_book_parrying:
  type: item
  debug: false
  material: epicfight_skillbook
  display name: <&6>Skill Book<&co> <&e>Parrying
  lore:
    - <&6>Guild<&co> <script[guild_data].parsed_key[data.warrior.color]>Warrior
    - <&6>Reputation Needed<&co> <&e><script[guild_data].parsed_key[data.warrior.skill_checks.parrying]>
  flags:
    guild: warrior
    skill: parrying
    right_click_script: guild_learn_check
  mechanisms:
    raw_nbt: <map.with[skill].as[string:epicfight:parrying]>

warrior_skill_book_tenacity:
  type: item
  debug: false
  material: epicfight_skillbook
  display name: <&6>Skill Book<&co> <&e>Tenacity
  lore:
    - <&6>Guild<&co> <script[guild_data].parsed_key[data.warrior.color]>Warrior
    - <&6>Reputation Needed<&co> <&e><script[guild_data].parsed_key[data.warrior.skill_checks.arrow_tenacity]>
  flags:
    skill: arrow_tenacity
    guild: warrior
    right_click_script: guild_learn_check
  mechanisms:
    raw_nbt: <map.with[skill].as[string:wom:arrow_tenacity]>

warrior_skill_book_stamina_pillager:
  type: item
  debug: false
  material: epicfight_skillbook
  display name: <&6>Skill Book<&co> <&e>Stamina Pillager
  lore:
    - <&6>Guild<&co> <script[guild_data].parsed_key[data.warrior.color]>Warrior
    - <&6>Reputation Needed<&co> <&e><script[guild_data].parsed_key[data.warrior.skill_checks.stamina_pillager]>
  flags:
    guild: warrior
    skill: stamina_pillager
    right_click_script: guild_learn_check
  mechanisms:
    raw_nbt: <map.with[skill].as[string:epicfight:stamina_pillager]>

warrior_skill_book_dodge_master:
  type: item
  debug: false
  material: epicfight_skillbook
  display name: <&6>Skill Book<&co> <&e>Dodge Master
  lore:
    - <&6>Guild<&co> <script[guild_data].parsed_key[data.warrior.color]>Warrior
    - <&6>Reputation Needed<&co> <&e><script[guild_data].parsed_key[data.warrior.skill_checks.dodge_master]>
  flags:
    guild: warrior
    skill: dodge_master
    right_click_script: guild_learn_check
  mechanisms:
    raw_nbt: <map.with[skill].as[string:wom:dodge_master]>