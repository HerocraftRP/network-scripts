shop_data:
  type: data
  data:
    lumberjack_tools:
      title: <&6>Lumberjack Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: lumberjack_wooden_axe
        2:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=2]
            result: lumberjack_stone_axe
        3:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=4]
            result: lumberjack_iron_axe
        4:
            trade_condition_tag: true
            item1: COIN_PLATINUM[quantity=2]
            result: lumberjack_gold_axe
        5:
            trade_condition_tag: true
            item1: COIN_PLATINUM[quantity=5]
            result: lumberjack_diamond_axe
        6:
            trade_condition_tag: true
            item1: COIN_PLATINUM[quantity=10]
            result: lumberjack_netherite_axe
    farming_tools:
      title: <&6>Farming Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: farming_wooden_hoe
        2:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=2]
            result: farming_stone_hoe
        3:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=4]
            result: farming_iron_hoe
        4:
            trade_condition_tag: true
            item1: COIN_PLATINUM[quantity=2]
            result: farming_golden_hoe
        5:
            trade_condition_tag: true
            item1: COIN_NETHERITE[quantity=1]
            result: farming_diamond_hoe
        6:
            trade_condition_tag: true
            item1: COIN_NETHERITE[quantity=5]
            result: farming_netherite_hoe
    ranching_tools:
      title: <&6>Ranching Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: ranching_wooden_knife
        2:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: ranching_stone_knife
        3:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: ranching_iron_knife
        4:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: ranching_golden_knife
        5:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: ranching_diamond_knife
        6:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: ranching_shears
        7:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: ranching_bucket
    fishing_tools:
      title: <&6>Fishing Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: fishing_wooden_rod
        2:
            trade_condition_tag: <player.flag[job.fishing.reputation].is_more_than[99]||0>
            item1: COIN_GOLD[quantity=2]
            result: fishing_iron_rod
        3:
            trade_condition_tag: <player.flag[job.fishing.reputation].is_more_than[199]||0>
            item1: COIN_GOLD[quantity=4]
            result: fishing_golden_rod
        4:
            trade_condition_tag: <player.flag[job.fishing.reputation].is_more_than[299]||0>
            item1: COIN_PLATINUM[quantity=2]
            result: fishing_diamond_rod
        5:
            trade_condition_tag: <player.flag[job.fishing.reputation].is_more_than[399]||0>
            item1: COIN_NETHERITE[quantity=1]
            result: fishing_neptunium_rod
    tailoring_tools:
      title: <&6>Tailoring Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: tailor_wood_sewing_needle
        2:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=2]
            result: tailor_stone_sewing_needle
        3:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=4]
            result: tailor_iron_sewing_needle
        4:
            trade_condition_tag: true
            item1: COIN_PLATINUM[quantity=2]
            result: tailor_gold_sewing_needle
        5:
            trade_condition_tag: true
            item1: COIN_NETHERITE[quantity=1]
            result: tailor_diamond_sewing_needle
        6:
            trade_condition_tag: true
            item1: COIN_NETHERITE[quantity=5]
            result: tailor_netherite_sewing_needle
    mining_tools:
      title: <&6>Mining Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: mining_wooden_pickaxe
        2:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=2]
            result: mining_stone_pickaxe
        3:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=4]
            result: mining_iron_pickaxe
        4:
            trade_condition_tag: true
            item1: COIN_PLATINUM[quantity=2]
            result: mining_golden_pickaxe
        5:
            trade_condition_tag: true
            item1: COIN_NETHERITE[quantity=1]
            result: mining_diamond_pickaxe
        6:
            trade_condition_tag: true
            item1: COIN_NETHERITE[quantity=5]
            result: mining_netherite_pickaxe
        7:
            trade_condition_tag: true
            item1: COIN_COPPER[quantity=5]
            result: lantern
    cooking_tools:
      title: <&6>Cooking Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: bucket
        2:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: cooking_stone_knife
        3:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=2]
            result: cooking_iron_knife
        4:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=4]
            result: cooking_golden_knife
        5:
            trade_condition_tag: true
            item1: COIN_PLATINUM[quantity=2]
            result: cooking_diamond_knife
        6:
            trade_condition_tag: true
            item1: COIN_NETHERITE[quantity=1]
            result: cooking_netherite_knife
    instrument_shop:
      title: <&6>Instruments
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=2]
            result: immersive_melodies_bagpipe
        2:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=2]
            result: immersive_melodies_didgeridoo
        3:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=2]
            result: immersive_melodies_flute
        4:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=2]
            result: immersive_melodies_lute
        5:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=2]
            result: immersive_melodies_piano
        6:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=2]
            result: immersive_melodies_triangle
        7:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=2]
            result: immersive_melodies_trumpet
    horse_rental:
      title: <&6>Horse Rental
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: lead
        2:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: horse_rental
        3:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: animal_cart_rental
        4:
            trade_condition_tag: true
            item1: COIN_GOLD[quantity=1]
            result: work_cart_rental
    blacksmith_sales_avalon:
      title: <&6>Blacksmith Shop
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: MAGISTUARMORY_BLACKSMITH_HAMMER
        2:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=5]
            result: blacksmith_stone_sheet
        3:
            trade_condition_tag: true
            item1: COIN_GOLD
            result: blacksmith_stone_sword
        4:
            trade_condition_tag: true
            item1: COIN_GOLD
            result: blacksmith_stone_greatsword
        5:
            trade_condition_tag: true
            item1: COIN_GOLD
            result: blacksmith_stone_spear
        6:
            trade_condition_tag: true
            item1: COIN_GOLD
            result: blacksmith_stone_roundshield
        7:
            trade_condition_tag: true
            item1: COIN_GOLD
            result: blacksmith_stone_kiteshield
    woodwork_sales_avalon:
      title: <&6>Blacksmith Shop
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: woodwork_stripped_oak_wood
        2:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=5]
            result: woodwork_oak_tool_handle
        3:
            trade_condition_tag: true
            item1: COIN_GOLD
            result: woodwork_wooden_staff
    hospital_shop:
      title: <&6>Hospital Goods (Out of Stock)
      trades:
        1:
            trade_condition_tag: false
            item1: COIN_COPPER[quantity=1]
            result: air[display_name=<&6>Premium, High Quality, Air]
    bartender_shop:
      title: <&6>Farming Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_COPPER[quantity=2]
            result: brewery_beer_wheat
        2:
            trade_condition_tag: true
            item1: COIN_COPPER[quantity=2]
            result: brewery_beer_barley
        3:
            trade_condition_tag: true
            item1: COIN_COPPER[quantity=2]
            result: brewery_beer_hops
    bundle_sales:
      title: <&6>Farming Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_COPPER[quantity=2]
            result: empty_bundle
        2:
            trade_condition_tag: <player.flag[character.capability.mercantile].is_more_than[100]||false>
            item1: COIN_COPPER
            result: empty_bundle
    newbie_shop:
      title: <&6>New Arrivals Shop
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_COPPER[quantity=2]
            result: communication_crystal
        2:
            trade_condition_tag: true
            item1: COIN_COPPER[quantity=2]
            result: <item[wallet].with[lore=<&6>Owner<&co> <&e><player.name>].with_flag[owner:<player.uuid>]>
        3:
            trade_condition_tag: true
            item1: COIN_COPPER[quantity=2]
            result: <item[toughasnails_empty_canteen]>
    lockpick_sales:
      title: <&6>Shady Dealer
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_GOLD
            result: cuffed_lockpick[display=<&c>Lockpick]
    ranger_sales:
      title: <&a>Beginner Ranger Tools
      trades:
        1:
            trade_condition_tag: <player.flag[character.guild.name].equals[ranger]||false>
            item1: COIN_GOLD
            result: ranger_bow
        2:
            trade_condition_tag: <player.flag[character.guild.name].equals[ranger]||false>
            item1: COIN_SILVER
            result: arrow
        3:
            trade_condition_tag: <player.flag[character.guild.name].equals[ranger]||false>
            item1: COIN_SILVER[quantity=4]
            result: ranger_book_fast_run
        4:
            trade_condition_tag: <player.flag[character.guild.name].equals[ranger]||false>
            item1: COIN_SILVER[quantity=2]
            result: ranger_book_dodge
        5:
            trade_condition_tag: <player.flag[character.guild.name].equals[ranger]||false>
            item1: COIN_SILVER[quantity=2]
            result: ranger_book_break_fall
        6:
            trade_condition_tag: <player.flag[character.guild.name].equals[ranger]||false>
            item1: COIN_SILVER[quantity=2]
            result: ranger_book_slide
        7:
            trade_condition_tag: <player.flag[character.guild.name].equals[ranger]||false>
            item1: COIN_SILVER[quantity=5]
            result: ranger_book_leap
    mage_sales_1:
      title: <&d>Beginner Mage Supplies
      trades:
        1:
            trade_condition_tag: <player.flag[character.capabilities.spell_creation].is_more_than[0]||false>
            item1: COIN_GOLD
            result: mage_beginner_book
        2:
            trade_condition_tag: <player.flag[character.capabilities.spell_creation].is_more_than[<script[capabilities_data].data_key[capability.spell_creation.checks.underfoot]>]||false>
            item1: COIN_SILVER[quantity=4]
            result: mage_glyph_underfoot
        3:
            trade_condition_tag: <player.flag[character.capabilities.spell_creation].is_more_than[<script[capabilities_data].data_key[capability.spell_creation.checks.toss]>]||false>
            item1: COIN_SILVER[quantity=2]
            result: mage_glyph_toss
        4:
            trade_condition_tag: <player.flag[character.capabilities.spell_creation].is_more_than[<script[capabilities_data].data_key[capability.spell_creation.checks.bounce]>]||false>
            item1: COIN_SILVER[quantity=2]
            result: mage_glyph_bounce
        5:
            trade_condition_tag: <player.flag[character.capabilities.spell_creation].is_more_than[<script[capabilities_data].data_key[capability.spell_creation.checks.ignite]>]||false>
            item1: COIN_SILVER[quantity=2]
            result: mage_glyph_ignite
        6:
            trade_condition_tag: <player.flag[character.capabilities.spell_creation].is_more_than[<script[capabilities_data].data_key[capability.spell_creation.checks.amplify]>]||false>
            item1: COIN_SILVER[quantity=5]
            result: mage_glyph_amplify
        7:
            trade_condition_tag: <player.flag[character.capabilities.spell_creation].is_more_than[<script[capabilities_data].data_key[capability.spell_creation.checks.freeze]>]||false>
            item1: COIN_SILVER[quantity=7]
            result: mage_glyph_freeze
        8:
            trade_condition_tag: <player.flag[character.capabilities.spell_creation].is_more_than[<script[capabilities_data].data_key[capability.spell_creation.checks.gust]>]||false>
            item1: COIN_GOLD
            result: mage_glyph_gust
        9:
            trade_condition_tag: <player.flag[character.capabilities.spell_creation].is_more_than[<script[capabilities_data].data_key[capability.spell_creation.checks.light]>]||false>
            item1: COIN_GOLD
            item2: COIN_SILVER[quantity=5]
            result: mage_glyph_light
        10:
            trade_condition_tag: <player.flag[character.capabilities.spell_creation].is_more_than[<script[capabilities_data].data_key[capability.spell_creation.checks.rune]>]||false>
            item1: COIN_GOLD
            item2: COIN_SILVER[quantity=7]
            result: mage_glyph_rune
        11:
            trade_condition_tag: <player.flag[character.capabilities.spell_creation].is_more_than[<script[capabilities_data].data_key[capability.spell_creation.checks.pickup]>]||false>
            item1: COIN_GOLD[quantity=2]
            result: mage_glyph_pickup
        12:
            trade_condition_tag: <player.flag[character.capabilities.spell_creation].is_more_than[<script[capabilities_data].data_key[capability.spell_creation.checks.summon_steed]>]||false>
            item1: COIN_GOLD[quantity=5]
            result: mage_glyph_summon_steed
    warrior_sales_1:
      title: <&c>Beginner Warrior Skills
      trades:
        1:
            trade_condition_tag: <player.flag[character.guild.name].equals[warrior]||false>
            item1: COIN_GOLD
            result: stick[display=<&c>Not a Stick]
        2:
            trade_condition_tag: <player.flag[character.guild.name].equals[warrior]||false>
            item1: COIN_SILVER[quantity=4]
            #result: warrior_skill_book_guard
            result: stick[display=<&c>Not a Stick]
        3:
            trade_condition_tag: <player.flag[character.guild.name].equals[warrior]||false>
            item1: COIN_SILVER[quantity=2]
            #result: warrior_skill_book_parrying
            result: stick[display=<&c>Not a Stick]
        4:
            trade_condition_tag: <player.flag[character.guild.name].equals[warrior]||false>
            item1: COIN_SILVER[quantity=2]
            #result: warrior_skill_book_tenacity
            result: stick[display=<&c>Not a Stick]
        5:
            trade_condition_tag: <player.flag[character.guild.name].equals[warrior]||false>
            item1: COIN_SILVER[quantity=2]
            #result: warrior_skill_book_stamina_pillager
            result: stick[display=<&c>Not a Stick]
        6:
            trade_condition_tag: <player.flag[character.guild.name].equals[warrior]||false>
            item1: COIN_SILVER[quantity=5]
            #result: warrior_skill_book_dodge_master
            result: stick[display=<&c>Not a Stick]
    misc_shop:
      title: <&7>Street Vendor
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER
            result: writable_book
    guard_tools:
      title: <&6>Guard Requisitions
      trades:
        1:
            trade_condition_tag: <player.has_flag[temp.active_duty_guard]>
            item1: COIN_GOLD
            result: handcuffs
        2:
            trade_condition_tag: <player.has_flag[temp.active_duty_guard]>
            item1: COIN_GOLD
            result: handcuffs_key
        3:
            trade_condition_tag: <player.has_flag[temp.active_duty_guard]>
            item1: COIN_SILVER
            result: chain
    blacksmith_schematics_avalon:
      title: <&6>Stone Schematics
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[blacksmith_stone_sheet].proc[get_schematic]>
        2:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[mining_stone_pickaxe].proc[get_schematic]>
        3:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[lumberjack_stone_axe].proc[get_schematic]>
        4:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[farming_stone_hoe].proc[get_schematic]>
        5:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[ranching_stone_knife].proc[get_schematic]>
        6:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[cooking_stone_knife].proc[get_schematic]>
        7:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[tailor_stone_sewing_needle].proc[get_schematic]>
        8:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[blacksmith_stone_sword].proc[get_schematic]>
        9:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[blacksmith_stone_greatsword].proc[get_schematic]>
        10:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[blacksmith_stone_spear].proc[get_schematic]>
        11:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[blacksmith_stone_roundshield].proc[get_schematic]>
        12:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[blacksmith_stone_kiteshield].proc[get_schematic]>
    woodwork_schematics_avalon:
      title: <&6>Oak Schematics
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[woodwork_stripped_oak_wood].proc[get_schematic]>
        2:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[woodwork_oak_tool_handle].proc[get_schematic]>
        3:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[lumberjack_wooden_axe].proc[get_schematic]>
        4:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[mining_wooden_pickaxe].proc[get_schematic]>
        5:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[farming_wooden_hoe].proc[get_schematic]>
        6:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[woodwork_oak_pole].proc[get_schematic]>
        7:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[ranching_wooden_knife].proc[get_schematic]>
        8:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[fishing_wooden_rod].proc[get_schematic]>
        9:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[tailor_wood_sewing_needle].proc[get_schematic]>
        10:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[woodwork_wooden_staff].proc[get_schematic]>
    tailor_schematics_avalon:
      title: <&6>Leather Schematics
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[woodwork_stripped_oak_wood].proc[get_schematic]>

shop_open:
  type: command
  debug: false
  name: shop_open
  description: NOT FOR USAGE
  usage: DO NOT USE
  permissions: not.a.perm
  data_definitions: shop_name
  script:
    - define trades <list>
    - adjust <queue> linked_player:<server.match_player[<context.args.get[2]>]>
    - define level <player.flag[character.capabilities.mercantile].round_to_precision[100].div[100].add[1]||1>
    - if <server.has_flag[shops.<context.args.get[1]>]>:
      - define merchant <context.args.get[1].starts_with[merchant_]>
      - if <[merchant]>:
        - opentrades <server.flag[shops.<context.args.get[1]>_<[level]>]> "title:<&6><context.args.get[1].before[_sales].replace[_].with[<&sp>].to_titlecase> Sales"
      - else if !<[merchant]>:
        - opentrades <server.flag[shops.<context.args.get[1]>]> "title:<&6><context.args.get[1].before[_].to_titlecase> Sales"
      - else:
        - narrate "<&c>I have no business with you."
      - stop
    - define data <script[shop_data].parsed_key[data.<context.args.get[1]>]||null>
    - if <[data]> == null:
      - narrate "<&c>REPORT AS UNFINISHED - <&e><context.args.get[1]> SHOP"
      - stop
    - foreach <[data].get[trades].values>:
      - if <[value].get[trade_condition_tag]>:
        - if <[value].get[item2].exists>:
          - define trade trade[max_uses=99999;inputs=<[value].get[item1]>|<[value].get[item2]>;result=<[value].get[result]>;has_xp=false]
        - else:
          - define trade trade[max_uses=99999;inputs=<[value].get[item1]>;result=<[value].get[result]>;has_xp=false]
        - define trades <[trades].include[<[trade]>]>
    - opentrades <[trades]> title:<[data].get[title].parsed>

shop_data_retrieve:
  type: task
  debug: false
  data:
    structure:
      value: <[value]>
      bundle_size: <[bundle_size]>
      bundles_needed: <[bundles_needed]>
  script:
    - flag server google_data:!
    - ~webget "headers:<map.with[X-goog-api-key].as[AIzaSyA061Mj-AGTbQxUTD0kflDMVRDTzMoKZds].with[Content-Type].as[application/json].with[Accept].as[application/json]>" https://sheets.googleapis.com/v4/spreadsheets/17pKdiEAfBsMi80aRYptHT1QQAYN075G-o6O3IOSoRNg/values:batchGet?ranges=Mining!B4:H8&ranges=Lumberjack!B4:H9&ranges=Farming!B4:H13&ranges=Fishing!B4:H8&valueRenderOption=UNFORMATTED_VALUE&majorDimension=ROWS save:data
    - yaml loadtext:<entry[data].result> id:job_data
    - foreach <yaml[job_data].read[valueRanges]> as:jobMap:
      - define jobName <[jobMap].get[range].before[!]>
      - foreach <[jobMap].values.get[3]> as:rows:
        - define material <[rows].get[1]>
        - define value <[rows].get[3]>
        - define bundle_size <[rows].get[7]>
        - define bundles_needed <[rows].get[2].div[<[rows].get[7]>]>
        - flag server google_data.<[jobName]>.<[material]>:<script.parsed_key[data.structure]>
    - run shop_build_job_shops

shop_build_job_shops:
  type: task
  debug: false
  script:
    - flag server shops:!
    # Normal Job Sales
    - foreach <server.flag[google_data].keys> as:jobName:
      - define trades <list>
      - foreach <server.flag[google_data.<[jobName]>].keys> as:material:
        - define data <server.flag[google_data.<[jobName]>.<[material]>]>
        - if <[data].get[bundles_needed]> == 2:
          - define trade trade[max_uses=99999;inputs=<list.pad_right[2].with[<[jobName]>_<[material]>_bundle]>;result=COIN_COPPER[quantity=<[data].get[value]>];has_xp=false]
        - else:
          - define trade trade[max_uses=99999;inputs=<[jobName]>_<[material]>_bundle;result=COIN_COPPER[quantity=<[data].get[value]>];has_xp=false]
        - define trades <[trades].include[<[trade]>]>
      - flag server shops.<[jobName]>_sales:<[trades]>
    # Merchant Job Sales
    - repeat 6 as:level:
      - foreach <server.flag[google_data].keys> as:jobName:
        - define trades <list>
        - foreach <server.flag[google_data.<[jobName]>].keys> as:material:
          - define data <server.flag[google_data.<[jobName]>.<[material]>]>
          - if <[data].get[bundles_needed]> == 2:
            - define trade trade[max_uses=99999;inputs=<list.pad_right[2].with[<[jobName]>_<[material]>_bundle]>;result=COIN_COPPER[quantity=<[data].get[value].add[<[level]>]>];has_xp=false]
          - else:
            - define trade trade[max_uses=99999;inputs=<[jobName]>_<[material]>_bundle;result=COIN_COPPER[quantity=<[data].get[value].add[<[level]>]>];has_xp=false]
          - define trades <[trades].include[<[trade]>]>
        - flag server shops.merchant_<[jobName]>_sales_<[level]>:<[trades]>
        - flag server shops.merchant_<[jobName]>_sales