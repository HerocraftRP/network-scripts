parkour_book_fast_run:
  type: item
  debug: false
  material: paper
  display name: <&a>Ranger Skill<&co> <&e>Fast Run
  lore:
    - <&7>Allows you to sprint faster, while holding it down
    - <empty>
    - <&6>Guild<&co> <script[capabilities_data].parsed_key[capability.parkour.color]>Parkour
    - <&6>Reputation Needed<&co> <&e><script[capabilities_data].parsed_key[capability.parkour.checks.FastRun]>
  flags:
    capability: parkour
    skill: FastRun
    right_click_script: <list[guild_learn_check|ranger_add_parkour_skill]>

parkour_book_dodge:
  type: item
  debug: false
  material: paper
  display name: <&a>Ranger Skill<&co> <&e>Dodge
  lore:
    - <&7>Allows you to dodge rapidly
    - <empty>
    - <&6>Guild<&co> <script[capabilities_data].parsed_key[capability.parkour.color]>Parkour
    - <&6>Reputation Needed<&co> <&e><script[capabilities_data].parsed_key[capability.parkour.checks.Dodge]>
  flags:
    capability: parkour
    skill: Dodge
    right_click_script: <list[guild_learn_check|ranger_add_parkour_skill]>

parkour_book_break_fall:
  type: item
  debug: false
  material: paper
  display name: <&a>Ranger Skill<&co> <&e>Break Fall
  lore:
    - <&7>Allows you to roll when you fall, lowering damage
    - <empty>
    - <&6>Guild<&co> <script[capabilities_data].parsed_key[capability.parkour.color]>Parkour
    - <&6>Reputation Needed<&co> <&e><script[capabilities_data].parsed_key[capability.parkour.checks.Breakfall]>
  flags:
    capability: parkour
    skill: Breakfall
    right_click_script: <list[guild_learn_check|ranger_add_parkour_skill]>

parkour_book_slide:
  type: item
  debug: false
  material: paper
  display name: <&a>Ranger Skill<&co> <&e>Slide
  lore:
    - <&7>Allows you to slide on the ground, while running
    - <empty>
    - <&6>Guild<&co> <script[capabilities_data].parsed_key[capability.parkour.color]>Parkour
    - <&6>Reputation Needed<&co> <&e><script[capabilities_data].parsed_key[capability.parkour.checks.Slide]>
  flags:
    capability: parkour
    skill: Slide
    right_click_script: <list[guild_learn_check|ranger_add_parkour_skill]>

parkour_book_leap:
  type: item
  debug: false
  material: paper
  display name: <&a>Ranger Skill<&co> <&e>Leap
  lore:
    - <&7>Allows you to leap very far horizontally.
    - <empty>
    - <&6>Guild<&co> <script[capabilities_data].parsed_key[capability.parkour.color]>Parkour
    - <&6>Reputation Needed<&co> <&e><script[capabilities_data].parsed_key[capability.parkour.checks.CatLeap]>
  flags:
    capability: parkour
    skill: CatLeap
    right_click_script: <list[guild_learn_check|ranger_add_parkour_skill]>

ranger_add_parkour_skill:
  type: task
  debug: false
  script:
    - define skill <player.item_in_hand.flag[skill]>
    - execute as_server "parcool limitation set individual of <player.name> possibility <[skill]> true"
    - narrate "<&e>You feel more capable than you did before."
    - take iteminhand quantity:1

ranger_bow:
  type: item
  debug: false
  material: bow
  display name: <&7>Basic Bow
  flags:
    display: <&7>Basic Bow
    on_item_shot: ranger_shoot_bow
    interaction:
      1:
        script: ranger_stealth_toggle
        display: <&a>Ranger<&co> <&7>Stealth
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co> <&a>Ranger<&co> <&7>Sneak
    - "<&7>___________________"

ranger_stealth_toggle:
  type: task
  debug: false
  script:
    - if <player.has_flag[temp.stealth]>:
      - run ranger_stop_stealth
    - else:
      - run ranger_start_stealth

ranger_stop_stealth:
  type: task
  debug: false
  script:
    - run remove_framework_flag def:on_basic_attack|ranger_stop_stealth
    - execute as_server "setskin https://herocraft.world/images/player_default_<player.uuid>.png <player.name>"
    - flag player temp.stealth:!

ranger_start_stealth:
  type: task
  debug: false
  script:
    - run add_framework_flag def:on_basic_attack|ranger_stop_stealth
    - execute as_server "setskin https://herocraft.world/images/stealth_skin3.png <player.name>"
    - flag player temp.stealth

ranger_shoot_bow:
  type: task
  debug: false
  script:
    - if <player.has_flag[temp.stealth]>:
      - run ranger_stop_stealth
    - if <context.force> == 3:
      - run job_get_rep def:ranger|0.01
    - wait 1t
    - adjust <context.projectile> pickup_status:DISALLOWED