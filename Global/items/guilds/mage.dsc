mage_beginner_book:
  type: item
  display name: <&d>Beginner Spell Creation Book
  material: ars_nouveau_novice_spell_book
  flags:
    spellbook: true
    interaction:
      1:
        script: mage_book_teleport
        display: <&d>Teleport<&co> <&6>Spell Creation Tower
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co> <&d>Teleport<&co> <&6>Spell Creation Tower
    - "<&7>___________________"

mage_book_teleport:
  type: task
  debug: false
  definitions: destination
  script:
    - if !<bungee.connected> || <bungee.server> != herocraft:
      - narrate "<&c>You lack the ability to travel that far with your magic."
      - stop
    - if !<player.has_flag[character.guild.name]> || <player.flag[character.guild.name]> != mage:
      - narrate "<&c>You lack the magical prowess to harness this power."
      - stop
    - foreach <player.location.cuboids.filter[has_flag[on_teleport]]>:
      - inject <[value].flag[on_teleport]>
    - define color <script[guild_data].parsed_key[data.mage.color]>
    - define destination <server.flag[mage_tower.lower]>
    - define gamemode <player.gamemode>
    - define targets <player.location.find_players_within[100]>
    - define starting_location <player.location>
    - define vector <[destination].sub[<player.location>].with_y[<player.location.y.add[51].max[<[destination].y.add[51]>]>].normalize.mul[50.1]>
    - define points <proc[define_curve1].context[<player.location>|<player.location.add[<[vector]>]>|5|90|1]>
    - define original_y <player.location.y>
    - repeat 10:
      - playeffect at:<player.location.above> offset:0.5 effect:redstone special_data:5|<[color]> quantity:30 targets:<[targets]>
      - wait 1t
    - adjust <player> gamemode:spectator
    - adjust <player> gravity:false
    - adjust <player> can_fly:false
    - repeat 30:
      - playeffect at:<player.location> offset:0.4 effect:redstone special_data:5|<[color]> quantity:30 targets:<[targets]>
      - adjust <player> velocity:<[points].get[<[value].add[1]>].sub[<[points].get[<[value]>]>]>
      - wait 2t
    - teleport <player> <[destination].with_y[<[destination].y.add[31]>]>
    - define targets <player.location.find_players_within[100]>
    - repeat 30:
      - playeffect at:<player.location> offset:0.4 effect:redstone special_data:5|<[color]> quantity:30 targets:<[targets]>
      - adjust <player> velocity:0,-0.51,0
      - wait 2t
    - adjust <player> gamemode:<[gamemode]>
    - adjust <player> fall_distance:0
    - adjust <player> gravity:true
    - teleport <player> <[destination]>
    - repeat 3:
      - playeffect at:<[destination]> offset:<element[1].mul[<[value]>]> effect:redstone special_data:5|<[color]> quantity:<element[30].mul[<[value]>]> targets:<[targets]>
      - wait 1t

mage_glyph_amplify:
  type: item
  debug: false
  material: ars_nouveau_glyph_amplify
  display name: <&d>Spell Glyph<&co> <&e>Amplify
  lore:
    - <&6>Skill<&co> <script[capabilities_data].parsed_key[capability.spell_creation.color]>Spell Creation
    - <&6>Reputation Needed<&co> <&e><script[capabilities_data].parsed_key[capability.spell_creation.checks.amplify]>
  flags:
    capability: spell_creation
    skill: amplify
    right_click_script: guild_learn_check

mage_glyph_underfoot:
  type: item
  debug: false
  material: ars_nouveau_glyph_underfoot
  display name: <&d>Spell Glyph<&co> <&e>Underfoot
  lore:
    - <&6>Guild<&co> <script[capabilities_data].parsed_key[capability.spell_creation.color]>Spell Creation
    - <&6>Reputation Needed<&co> <&e><script[capabilities_data].parsed_key[capability.spell_creation.checks.underfoot]>
  flags:
    capability: spell_creation
    skill: underfoot
    right_click_script: guild_learn_check

mage_glyph_toss:
  type: item
  debug: false
  material: ars_nouveau_glyph_toss
  display name: <&d>Spell Glyph<&co> <&e>Toss
  lore:
    - <&6>Guild<&co> <script[capabilities_data].parsed_key[capability.spell_creation.color]>Spell Creation
    - <&6>Reputation Needed<&co> <&e><script[capabilities_data].parsed_key[capability.spell_creation.checks.toss]>
  flags:
    capability: spell_creation
    skill: toss
    right_click_script: guild_learn_check

mage_glyph_bounce:
  type: item
  debug: false
  material: ars_nouveau_glyph_bounce
  display name: <&d>Spell Glyph<&co> <&e>Bounce
  lore:
    - <&6>Guild<&co> <script[capabilities_data].parsed_key[capability.spell_creation.color]>Spell Creation
    - <&6>Reputation Needed<&co> <&e><script[capabilities_data].parsed_key[capability.spell_creation.checks.bounce]>
  flags:
    capability: spell_creation
    skill: bounce
    right_click_script: guild_learn_check

mage_glyph_ignite:
  type: item
  debug: false
  material: ars_nouveau_glyph_ignite
  display name: <&d>Spell Glyph<&co> <&e>Ignite
  lore:
    - <&6>Guild<&co> <script[capabilities_data].parsed_key[capability.spell_creation.color]>Spell Creation
    - <&6>Reputation Needed<&co> <&e><script[capabilities_data].parsed_key[capability.spell_creation.checks.ignite]>
  flags:
    capability: spell_creation
    skill: ignite
    right_click_script: guild_learn_check

mage_glyph_freeze:
  type: item
  debug: false
  material: ars_nouveau_glyph_freeze
  display name: <&d>Spell Glyph<&co> <&e>Freeze
  lore:
    - <&6>Guild<&co> <script[capabilities_data].parsed_key[capability.spell_creation.color]>Spell Creation
    - <&6>Reputation Needed<&co> <&e><script[capabilities_data].parsed_key[capability.spell_creation.checks.freeze]>
  flags:
    capability: spell_creation
    skill: freeze
    right_click_script: guild_learn_check

mage_glyph_gust:
  type: item
  debug: false
  material: ars_nouveau_glyph_gust
  display name: <&d>Spell Glyph<&co> <&e>Gust
  lore:
    - <&6>Guild<&co> <script[capabilities_data].parsed_key[capability.spell_creation.color]>Spell Creation
    - <&6>Reputation Needed<&co> <&e><script[capabilities_data].parsed_key[capability.spell_creation.checks.gust]>
  flags:
    capability: spell_creation
    skill: gust
    right_click_script: guild_learn_check

mage_glyph_light:
  type: item
  debug: false
  material: ars_nouveau_glyph_light
  display name: <&d>Spell Glyph<&co> <&e>Light
  lore:
    - <&6>Guild<&co> <script[capabilities_data].parsed_key[capability.spell_creation.color]>Spell Creation
    - <&6>Reputation Needed<&co> <&e><script[capabilities_data].parsed_key[capability.spell_creation.checks.light]>
  flags:
    capability: spell_creation
    skill: light
    right_click_script: guild_learn_check

mage_glyph_rune:
  type: item
  debug: false
  material: ars_nouveau_glyph_rune
  display name: <&d>Spell Glyph<&co> <&e>Rune
  lore:
    - <&6>Guild<&co> <script[capabilities_data].parsed_key[capability.spell_creation.color]>Spell Creation
    - <&6>Reputation Needed<&co> <&e><script[capabilities_data].parsed_key[capability.spell_creation.checks.rune]>
  flags:
    capability: spell_creation
    skill: rune
    right_click_script: guild_learn_check

mage_glyph_pickup:
  type: item
  debug: false
  material: ars_nouveau_glyph_pickup
  display name: <&d>Spell Glyph<&co> <&e>Pickup
  lore:
    - <&6>Guild<&co> <script[capabilities_data].parsed_key[capability.spell_creation.color]>Spell Creation
    - <&6>Reputation Needed<&co> <&e><script[capabilities_data].parsed_key[capability.spell_creation.checks.pickup]>
  flags:
    capability: spell_creation
    skill: pickup
    right_click_script: guild_learn_check

mage_glyph_summon_steed:
  type: item
  debug: false
  material: ars_nouveau_glyph_summon_steed
  display name: <&d>Spell Glyph<&co> <&e>Summon Steed
  lore:
    - <&6>Guild<&co> <script[capabilities_data].parsed_key[capability.spell_creation.color]>Spell Creation
    - <&6>Reputation Needed<&co> <&e><script[capabilities_data].parsed_key[capability.spell_creation.checks.summon_steed]>
  flags:
    capability: spell_creation
    skill: summon_steed
    right_click_script: guild_learn_check