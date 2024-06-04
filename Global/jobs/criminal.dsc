criminal_shipping_manifest_small:
  type: item
  debug: false
  material: map
  display name: <&6>Shipping Manifest
  flags:
    right_click_script: cancel
    interaction:
      1:
        script: criminal_stealing_goods_start_job_small
        display: <&c>Start Job
  lore:
    - <&e>A small shipping manifest
    - <&c>You could steal some valuable goods...
    - <&7>___________________
    - <empty>
    - <&a>Interaction 1<&co><&c> Start Job
    - <&7>___________________

criminal_shipping_manifest_large:
  type: item
  debug: false
  material: map
  display name: <&6>Shipping Manifest
  flags:
    right_click_script: cancel
    interaction:
      1:
        script: criminal_stealing_goods_start_job_large
        display: <&c>Start Job
  lore:
    - <&e>A large shipping manifest
    - <&c>You could steal some valuable goods...
    - <&7>___________________
    - <empty>
    - <&a>Interaction 1<&co><&c> Start Job
    - <&7>___________________

criminal_stolen_goods:
  type: item
  debug: false
  material: herocraft_bundle
  display name: <&c>Stolen Goods
  flags:
    interaction:
      1:
        script: criminal_stealing_goods_start_job_smuggle
        display: <&c>Start Job
  lore:
    - <&e>A bag of stolen goods
    - <&c>You could smuggle these around town...
    - <&7>___________________
    - <empty>
    - <&a>Interaction 1<&co><&c> Start Job
    - <&7>___________________

criminal_loot_gold:
  type: task
  debug: false
  script:
    - if <context.location.flag[criminal_job.id]> == <player.flag[temp.criminal_job.id]>:
      - run start_timed_action "def:<&c>Stealing Coins|10s|criminal_loot_gold_callback|<context.location>" def.can_move:false def.animation_task:criminal_loot_gold_animation

criminal_loot_gold_animation:
  type: task
  debug: false
  script:
    - animate <player> animation:ARM_SWING
    - wait 7t
    - playsound sound:BLOCK_NETHER_GOLD_ORE_HIT pitch:10 <player.location>  volume:0.1

criminal_loot_gold_callback:
  type: task
  debug: false
  definitions: location
  script:
    - showfake <[location]> air players:<player> duration:5m
    - playsound sound:entity_item_pickup <player> volume:0.1
    - narrate "<&c>You stole a pile of coins"
    - give item:coin_copper quantity:10

criminal_loot_papers:
  type: task
  debug: false
  script:
    - if <context.location.flag[criminal_job.id]> == <player.flag[temp.criminal_job.id]>:
      - run start_timed_action "def:<&c>Searching Documents|20s|criminal_loot_papers_callback|<context.location>" def.can_move:false def.animation_task:criminal_loot_papers_animation

criminal_loot_papers_animation:
  type: task
  debug: false
  script:
    - animate <player> animation:ARM_SWING
    - wait 7t
    - playsound sound:BLOCK_NETHER_GOLD_ORE_HIT pitch:10 <player.location>  volume:0.1

criminal_loot_papers_callback:
  type: task
  debug: false
  definitions: location
  script:
    - showfake <[location]> air players:<player> duration:5m
    - if <util.random_chance[10]>:
      - playsound sound:entity_item_pickup <player> volume:0.1
      - narrate "<&c>You found another Shipping Manifest!"
      - give item:criminal_shipping_manifest_large
    - else:
      - narrate "<&e>You found nothing of note."

criminal_loot_small_chest:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - wait 1t
    - if <context.location.flag[criminal_job.id]> == <player.flag[temp.criminal_job.id]>:
      - run start_timed_action "def:<&c>Looting Small Chest|20s|criminal_loot_small_chest_callback|<context.location>" def.can_move:false def.animation_task:criminal_loot_small_chest_animation

criminal_loot_small_chest_animation:
  type: task
  debug: false
  script:
    - animate <player> animation:ARM_SWING
    - wait 7t
    - playsound sound:BLOCK_NETHER_GOLD_ORE_HIT pitch:10 <player.location> volume:0.1

criminal_loot_small_chest_callback:
  type: task
  debug: false
  definitions: location
  script:
    - flag <player> temp.criminal_job:!
    - playsound sound:entity_item_pickup <player> volume:0.1
    - narrate "<&c>You got the goods, and the Guards have been alerted!"
    - narrate "<&c>Get out of there!"
    - repeat <list[2|4|6].random>:
      - give criminal_stolen_goods

criminal_loot_large_chest:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - wait 1t
    - if <context.location.flag[criminal_job.id]> == <player.flag[temp.criminal_job.id]>:
      - run start_timed_action "def:<&c>Looting Large Chest|30s|criminal_loot_large_chest_callback|<context.location>" def.can_move:false def.animation_task:criminal_loot_small_chest_animation

criminal_loot_large_chest_animation:
  type: task
  debug: false
  script:
    - animate <player> animation:ARM_SWING
    - wait 7t
    - playsound sound:BLOCK_NETHER_GOLD_ORE_HIT pitch:10 <player.location> volume:0.1

criminal_loot_large_chest_callback:
  type: task
  debug: false
  definitions: location
  script:
    - flag <player> temp.criminal_job:!
    - playsound sound:entity_item_pickup <player> volume:0.1
    - narrate "<&c>You got the goods, and the Guards have been alerted!"
    - narrate "<&c>Get out of there!"
    - repeat <list[12|14|16].random>:
      - give criminal_stolen_goods

criminal_stealing_goods_start_job_small:
  type: task
  debug: false
  script:
    - define job_id <server.flag[criminal_jobs.small].keys.random>
    - flag <player> temp.criminal_job.id:<[job_id]>
    - take iteminhand
    - narrate "<&e>Head over to the docks, the <&b>small ship <&e>with <&b><server.flag[criminal_jobs.small.<[job_id]>.sail_color]><&e> sails."
    - narrate "<&c>Don't get caught."

criminal_stealing_goods_start_job_large:
  type: task
  debug: false
  script:
    - define job_id <server.flag[criminal_jobs.large].keys.random>
    - flag <player> temp.criminal_job.id:<[job_id]>
    - take iteminhand
    - narrate "<&e>Head over to the docks, the <&b>large ship <&e>with <&b><server.flag[criminal_jobs.large.<[job_id]>.sail_color]><&e> sails."
    - narrate "<&c>Don't get caught."

criminal_smuggle_job_villager:
  type: task
  debug: false
  script:
    - if <player.flag[temp.criminal_job.id]||0> == <player.target.flag[criminal.id]>:
      - if <player.item_in_hand.script.name> != criminal_stolen_goods:
        - narrate "<&c>He does not want this item."
        - stop
      - take iteminhand
      - define number <util.random_decimal.mul[100].round>
    #- narrate "RNG #<&co> <[number]>"
      - if <[number]> < 5:
        - give coin_copper quantity:20
        - narrate "<&e>He takes the goods, and hands you 20 copper coins."
      - else if <[number]> < 30:
        - give coin_copper quantity:10
        - narrate "<&e>He takes the goods, and hands you 10 copper coins."
      - else if <[number]> < 85:
        - give coin_copper quantity:5
        - narrate "<&e>He takes the goods, and hands you 5 copper coins."
      - else:
        - narrate "<&c>He called the Guards on you!"
        - narrate "<&c>Get out of there!"
      - flag player temp.criminal_job:!
    - eLse:
      - narrate "<&e>I have no business with you right now."
      - narrate "<&c>You are not on a job right now."

criminal_stealing_goods_start_job_smuggle:
  type: task
  debug: false
  script:
    - if <player.flag[smuggle_cooldown].from_now.in_minutes> < 10:
      - narrate "<&c>You feel like it's too soon to do another job."
      - stop
    - flag <player> smuggle_cooldown:<util.time_now>
    - define job_id <server.flag[criminal_jobs.smuggle].keys.random>
    - flag <player> temp.criminal_job.id:<[job_id]>
    - narrate "<&e>Head on down to the docks to the <&b>small barge <&e>with <&b>red <&e>sails."
    - narrate "<&c>Don't get caught."