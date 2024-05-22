shop_data:
  type: data
  data:
    lumberjack_tools:
      title: <&6>Lumberjack Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: wooden_axe
        2:
            trade_condition_tag: <player.flag[job.lumberjack.reputation].is_more_than[99]||0>
            item1: COIN_GOLD[quantity=2]
            result: stone_axe
        3:
            trade_condition_tag: <player.flag[job.lumberjack.reputation].is_more_than[199]||0>
            item1: COIN_GOLD[quantity=4]
            result: iron_axe
        4:
            trade_condition_tag: <player.flag[job.lumberjack.reputation].is_more_than[299]||0>
            item1: COIN_PLATINUM[quantity=2]
            result: golden_axe
        5:
            trade_condition_tag: <player.flag[job.lumberjack.reputation].is_more_than[399]||0>
            item1: COIN_NETHERITE[quantity=1]
            result: diamond_axe
        6:
            trade_condition_tag: <player.flag[job.lumberjack.reputation].is_more_than[499]||0>
            item1: COIN_NETHERITE[quantity=5]
            result: netherite_axe
    farming_tools:
      title: <&6>Farming Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: wooden_hoe
        2:
            trade_condition_tag: <player.flag[job.farming.reputation].is_more_than[99]||0>
            item1: COIN_GOLD[quantity=2]
            result: stone_hoe
        3:
            trade_condition_tag: <player.flag[job.farming.reputation].is_more_than[199]||0>
            item1: COIN_GOLD[quantity=4]
            result: iron_hoe
        4:
            trade_condition_tag: <player.flag[job.farming.reputation].is_more_than[299]||0>
            item1: COIN_PLATINUM[quantity=2]
            result: golden_hoe
        5:
            trade_condition_tag: <player.flag[job.farming.reputation].is_more_than[399]||0>
            item1: COIN_NETHERITE[quantity=1]
            result: diamond_hoe
        6:
            trade_condition_tag: <player.flag[job.farming.reputation].is_more_than[499]||0>
            item1: COIN_NETHERITE[quantity=5]
            result: netherite_hoe
    ranching_tools:
      title: <&6>Ranching Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: ranch_butchering_knife
    fishing_tools:
      title: <&6>Fishing Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: basic_fishing_rod
        2:
            trade_condition_tag: <player.flag[job.fishing.reputation].is_more_than[99]||0>
            item1: COIN_GOLD[quantity=2]
            result: iron_fishing_rod
        3:
            trade_condition_tag: <player.flag[job.fishing.reputation].is_more_than[199]||0>
            item1: COIN_GOLD[quantity=4]
            result: golden_fishing_rod
        4:
            trade_condition_tag: <player.flag[job.fishing.reputation].is_more_than[299]||0>
            item1: COIN_PLATINUM[quantity=2]
            result: diamond_fishing_rod
        5:
            trade_condition_tag: <player.flag[job.fishing.reputation].is_more_than[399]||0>
            item1: COIN_NETHERITE[quantity=1]
            result: neptunium_fishing_rod
    tailoring_tools:
      title: <&6>Tailoring Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: sewingkit_wood_sewing_needle
        2:
            trade_condition_tag: <player.flag[job.tailoring.reputation].is_more_than[99]||0>
            item1: COIN_GOLD[quantity=2]
            result: sewingkit_stone_sewing_needle
        3:
            trade_condition_tag: <player.flag[job.tailoring.reputation].is_more_than[199]||0>
            item1: COIN_GOLD[quantity=4]
            result: sewingkit_iron_sewing_needle
        4:
            trade_condition_tag: <player.flag[job.tailoring.reputation].is_more_than[299]||0>
            item1: COIN_PLATINUM[quantity=2]
            result: sewingkit_gold_sewing_needle
        5:
            trade_condition_tag: <player.flag[job.tailoring.reputation].is_more_than[399]||0>
            item1: COIN_NETHERITE[quantity=1]
            result: sewingkit_diamond_sewing_needle
        6:
            trade_condition_tag: <player.flag[job.tailoring.reputation].is_more_than[499]||0>
            item1: COIN_NETHERITE[quantity=5]
            result: sewingkit_netherite_sewing_needle
    mining_tools:
      title: <&6>Mining Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: wooden_pickaxe
        2:
            trade_condition_tag: <player.flag[job.mining.reputation].is_more_than[99]||0>
            item1: COIN_GOLD[quantity=2]
            result: stone_pickaxe
        3:
            trade_condition_tag: <player.flag[job.mining.reputation].is_more_than[199]||0>
            item1: COIN_GOLD[quantity=4]
            result: iron_pickaxe
        4:
            trade_condition_tag: <player.flag[job.mining.reputation].is_more_than[299]||0>
            item1: COIN_PLATINUM[quantity=2]
            result: golden_pickaxe
        5:
            trade_condition_tag: <player.flag[job.mining.reputation].is_more_than[399]||0>
            item1: COIN_NETHERITE[quantity=1]
            result: diamond_pickaxe
        6:
            trade_condition_tag: <player.flag[job.mining.reputation].is_more_than[499]||0>
            item1: COIN_NETHERITE[quantity=5]
            result: netherite_pickaxe
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
            result: farmersdelight_flint_knife
        3:
            trade_condition_tag: <player.flag[job.cooking.reputation].is_more_than[99]||0>
            item1: COIN_GOLD[quantity=2]
            result: farmersdelight_iron_knife
        4:
            trade_condition_tag: <player.flag[job.cooking.reputation].is_more_than[199]||0>
            item1: COIN_GOLD[quantity=4]
            result: farmersdelight_golden_knife
        5:
            trade_condition_tag: <player.flag[job.cooking.reputation].is_more_than[299]||0>
            item1: COIN_PLATINUM[quantity=2]
            result: farmersdelight_diamond_knife
        6:
            trade_condition_tag: <player.flag[job.cooking.reputation].is_more_than[399]||0>
            item1: COIN_NETHERITE[quantity=1]
            result: farmersdelight_netherite_knife
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
    mask_shop:
      title: <&6>Mask Shop
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[masks_hats_modification_steve_mega_mask_helmet].with[hides=all].with_flag[disguise:Steve]>
        2:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[masks_hats_modification_alex_mega_mask_helmet].with[hides=all].with_flag[disguise:Steve]>
        3:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[masks_hats_modification_mega_bee_mask_helmet].with[hides=all].with_flag[disguise:Steve]>
        4:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[masks_hats_modification_pig_mega_mask_helmet].with[hides=all].with_flag[disguise:Steve]>
        5:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[masks_hats_modification_zombie_mega_mask_helmet].with[hides=all].with_flag[disguise:Steve]>
        6:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[masks_hats_modification_pig_mega_mask_2_helmet].with[hides=all].with_flag[disguise:Steve]>
        7:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[masks_hats_modification_kwek_mega_mask_helmet].with[hides=all].with_flag[disguise:Steve]>
        8:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[masks_hats_modification_rabbit_purple_mask_helmet].with[hides=all].with_flag[disguise:Steve]>
        9:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[masks_hats_modification_cow_mega_mask_helmet].with[hides=all].with_flag[disguise:Steve]>
        10:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: <item[masks_hats_modification_anu_mega_mask_helmet].with[hides=all].with_flag[disguise:Steve]>
    blacksmith_tools:
      title: <&6>Farming Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_SILVER[quantity=2]
            result: MAGISTUARMORY_BLACKSMITH_HAMMER
    hospital_shop:
      title: <&6>Farming Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_COPPER[quantity=1]
            result: FIRSTAID_PLASTER[quantity=2]
    bartender_shop:
      title: <&6>Farming Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_COPPER[quantity=2]
            result: alcocraftplus_mug_of_digger_bitter
        2:
            trade_condition_tag: true
            item1: COIN_COPPER[quantity=2]
            result: alcocraftplus_mug_of_ice_beer
        3:
            trade_condition_tag: true
            item1: COIN_COPPER[quantity=2]
            result: alcocraftplus_mug_of_leprechaun_cider
        4:
            trade_condition_tag: true
            item1: COIN_COPPER[quantity=2]
            result: alcocraftplus_mug_of_night_rauch
    bundle_sales:
      title: <&6>Farming Tools
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_COPPER[quantity=2]
            result: empty_bundle
    newbie_shop:
      title: <&6>Tourist Shop
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_COPPER[quantity=2]
            result: communication_crystal
        2:
            trade_condition_tag: true
            item1: COIN_COPPER[quantity=2]
            result: <item[wallet].with[lore=<&6>Owner<&co> <&e><player.name>].with_flag[owner:<player.uuid>]>
    lockpick_sales:
      title: <&6>Shady Dealer
      trades:
        1:
            trade_condition_tag: true
            item1: COIN_DIAMOND
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
            trade_condition_tag: <player.flag[character.guild.name].equals[mage]||false>
            item1: COIN_GOLD
            result: mage_beginner_book
        2:
            trade_condition_tag: <player.flag[character.guild.name].equals[mage]||false>
            item1: COIN_SILVER[quantity=4]
            result: mage_glyph_underfoot
        3:
            trade_condition_tag: <player.flag[character.guild.name].equals[mage]||false>
            item1: COIN_SILVER[quantity=2]
            result: mage_glyph_toss
        4:
            trade_condition_tag: <player.flag[character.guild.name].equals[mage]||false>
            item1: COIN_SILVER[quantity=2]
            result: mage_glyph_bounce
        5:
            trade_condition_tag: <player.flag[character.guild.name].equals[mage]||false>
            item1: COIN_SILVER[quantity=2]
            result: mage_glyph_ignite
        6:
            trade_condition_tag: <player.flag[character.guild.name].equals[mage]||false>
            item1: COIN_SILVER[quantity=5]
            result: mage_glyph_amplify
    warrior_sales_1:
      title: <&c>Beginner Warrior Skills
      trades:
        1:
            trade_condition_tag: <player.flag[character.guild.name].equals[warrior]||false>
            item1: COIN_GOLD
            result: stick
        2:
            trade_condition_tag: <player.flag[character.guild.name].equals[warrior]||false>
            item1: COIN_SILVER[quantity=4]
            result: warrior_skill_book_guard
        3:
            trade_condition_tag: <player.flag[character.guild.name].equals[warrior]||false>
            item1: COIN_SILVER[quantity=2]
            result: warrior_skill_book_parrying
        4:
            trade_condition_tag: <player.flag[character.guild.name].equals[warrior]||false>
            item1: COIN_SILVER[quantity=2]
            result: warrior_skill_book_tenacity
        5:
            trade_condition_tag: <player.flag[character.guild.name].equals[warrior]||false>
            item1: COIN_SILVER[quantity=2]
            result: warrior_skill_book_stamina_pillager
        6:
            trade_condition_tag: <player.flag[character.guild.name].equals[warrior]||false>
            item1: COIN_SILVER[quantity=5]
            result: warrior_skill_book_dodge_master




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
    - if <server.has_flag[shops.<context.args.get[1]>]>:
      - define merchant <context.args.get[1].starts_with[merchant_]>
      - if <[merchant]> && <player.flag[character.guild.name]> == merchant:
        - opentrades <server.flag[shops.<context.args.get[1]>]> "title:<&6><context.args.get[1].before[_sales].replace[_].with[<&sp>].to_titlecase> Sales"
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
    - ~webget "headers:<map.with[X-goog-api-key].as[AIzaSyA061Mj-AGTbQxUTD0kflDMVRDTzMoKZds].with[Content-Type].as[application/json].with[Accept].as[application/json]>" https://sheets.googleapis.com/v4/spreadsheets/17pKdiEAfBsMi80aRYptHT1QQAYN075G-o6O3IOSoRNg/values:batchGet?ranges=Mining!B4:H8&ranges=Lumberjack!B4:H9&ranges=Farming!B4:H8&ranges=Fishing!B4:H8&valueRenderOption=UNFORMATTED_VALUE&majorDimension=ROWS save:data
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
    - foreach <server.flag[google_data].keys> as:jobName:
      - define trades <list>
      - foreach <server.flag[google_data.<[jobName]>].keys> as:material:
        - define data <server.flag[google_data.<[jobName]>.<[material]>]>
        - if <[data].get[bundles_needed]> == 2:
          - define trade trade[max_uses=99999;inputs=<list.pad_right[2].with[<[jobName]>_<[material]>_bundle]>;result=COIN_COPPER[quantity=<[data].get[value].add[4]>];has_xp=false]
        - else:
          - define trade trade[max_uses=99999;inputs=<[jobName]>_<[material]>_bundle;result=COIN_COPPER[quantity=<[data].get[value].add[4]>];has_xp=false]
        - define trades <[trades].include[<[trade]>]>
      - flag server shops.merchant_<[jobName]>_sales:<[trades]>