fishing_cod_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Cod
  flags:
    interaction:
      1:
        script: unbundle_bundle
        display: <&e>Unbundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Unbundle
    - "<&7>___________________"


fishing_salmon_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Salmon
  flags:
    interaction:
      1:
        script: unbundle_bundle
        display: <&e>Unbundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Unbundle
    - "<&7>___________________"

fishing_ink_sac_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Ink Sacs
  flags:
    interaction:
      1:
        script: unbundle_bundle
        display: <&e>Unbundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Unbundle
    - "<&7>___________________"

fishing_bone_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Bones
  flags:
    interaction:
      1:
        script: unbundle_bundle
        display: <&e>Unbundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Unbundle
    - "<&7>___________________"

fishing_kelp_bundle:
  type: item
  material: herocraft_bundle
  display name: <&6>Bundle of Kelp
  flags:
    interaction:
      1:
        script: unbundle_bundle
        display: <&e>Unbundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Unbundle
    - "<&7>___________________"

fishing_cod:
  type: item
  material: cod
  display name: <&6>Cod
  allow in material recipes: true
  flags:
    interaction:
      1:
        script: fishing_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

fishing_salmon:
  type: item
  material: cod
  display name: <&6>Salmon
  allow in material recipes: true
  flags:
    interaction:
      1:
        script: fishing_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

fishing_ink_sac:
  type: item
  material: cod
  display name: <&6>Ink Sac
  allow in material recipes: true
  flags:
    interaction:
      1:
        script: fishing_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

fishing_bone:
  type: item
  material: cod
  display name: <&6>Bone
  allow in material recipes: true
  flags:
    interaction:
      1:
        script: fishing_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

fishing_kelp:
  type: item
  material: cod
  display name: <&6>Kelp
  allow in material recipes: true
  flags:
    interaction:
      1:
        script: fishing_packaging_interact
        display: <&e>Bundle
  lore:
    - "<&7>___________________"
    - ""
    - <&a>Interaction 1<&co><&e> Bundle
    - "<&7>___________________"

fishing_table:
  type: data
  data:
    loot_table_per_level:
      0:
        fishing_cod: 20
        leather_boots[durability=60]: 30
      1:
        fishing_cod: 20
        fishing_salmon: 20
        leather_boots[durability=60]: 30
      2:
        fishing_cod: 20
        fishing_salmon: 20
        fishing_ink_sac: 20
        leather_boots[durability=60]: 20
      3:
        fishing_cod: 20
        fishing_salmon: 20
        fishing_ink_sac: 20
        fishing_bone: 10
        leather_boots[durability=60]: 15
      4:
        fishing_cod: 20
        fishing_salmon: 20
        fishing_ink_sac: 20
        leather_boots[durability=60]: 10
        fishing_bone: 10
        fishing_kelp: 10
      5:
        fishing_cod: 20
        fishing_salmon: 20
        fishing_ink_sac: 20
        leather_boots[durability=60]: 5
        fishing_bone: 10
        fishing_kelp: 10

fishing:
  type: world
  debug: false
  enabled: false
  startup:
    - flag server fishing_loot_table:!
    - foreach <script[fishing_table].data_key[data.loot_table_per_level].keys> as:level:
      - foreach <script[fishing_table].data_key[data.loot_table_per_level.<[level]>]> key:catch as:weight:
        - define levelTotal_<[level]>.<[catch]>:<[weight].div[<script[fishing_table].data_key[data.loot_table_per_level.<[level]>].values.sum>].round_to[2]>
    - foreach <script[fishing_table].data_key[data.loot_table_per_level].keys> as:level:
      - define count 0
      - foreach <[levelTotal_<[level]>]> key:fish as:percentage_chance:
        - flag server fishing_loot_table.<[level]>.<[count].add[<[percentage_chance]>].mul[100]>:<[fish]>
        - define count:+:<[percentage_chance]>
  events:
    on script reload:
      - inject <script.name> path:startup
    on server start:
      - inject <script.name> path:startup
    on player fishes item while CAUGHT_FISH:
      - define rng <util.random_decimal.mul[100].truncate>
      - foreach <server.flag[fishing_loot_table.<player.flag[job.fishing.reputation].round_down_to_precision[100]||0>].keys>:
        - if <[rng]> < <[value]>:
          - determine passively CAUGHT:<item[<server.flag[fishing_loot_table.<player.flag[job.fishing.reputation].round_down_to_precision[100]||0>.<[value]>]>].with_flag[uuid:<util.random_uuid>]>
          - wait 1t
          - run job_get_rep def:fishing|0.05
          - foreach stop
      - inventory adjust slot:<player.held_item_slot> durability:0
      - wait 5t
      - give item:<context.entity.item>
      - run narrate_empty_inventory_slots
      - remove <context.entity>

basic_fishing_rod:
  type: item
  debug: false
  display name: <&r>Basic Fishing Rod
  material: fishing_rod
  flags:
    right_click_script: fishing_start

iron_fishing_rod:
  type: item
  debug: false
  display name: <&r>Iron Fishing Rod
  material: fishing_rod
  flags:
    right_click_script: fishing_start
  mechanisms:
    custom_model_data: 1

golden_fishing_rod:
  type: item
  debug: false
  display name: <&r>Golden Fishing Rod
  material: fishing_rod
  flags:
    right_click_script: fishing_start
  mechanisms:
    custom_model_data: 2

diamond_fishing_rod:
  type: item
  debug: false
  display name: <&r>Diamond Fishing Rod
  material: fishing_rod
  flags:
    right_click_script: fishing_start
  mechanisms:
    custom_model_data: 3

neptunium_fishing_rod:
  type: item
  debug: false
  display name: <&r>Neptunium Fishing Rod
  material: fishing_rod
  flags:
    right_click_script: fishing_start
  mechanisms:
    custom_model_data: 4

fishing_start:
  type: task
  debug: false
  script:
    - stop

fishing_packaging_command:
  type: command
  name: fishing_package
  debug: false
  description: Not for manual usage
  permissions: not.a.perm
  usage: DON'T
  script:
    - adjust <queue> linked_player:<server.match_player[<context.args.get[1]>]>
    - inventory close
    - run fishing_packaging_interact

fishing_packaging_interact:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - ratelimit <player> 1t
    - if !<player.inventory.contains_item[empty_bundle]>:
      - narrate "<&c>You need an empty bundle for this."
      - stop
    - wait 1t
    - define item <player.item_in_hand>
    - if <script[fishing_packaging].data_key[data.stack_sizes.<[item].material.name>].exists>:
      - define quantity <script[fishing_packaging].data_key[data.stack_sizes.<[item].script.name>]>
      - if <player.inventory.contains_item[<[item].script.name>].quantity[<[quantity]>]>:
        - run start_timed_action "def:<&6>Packaging <[item].display>|4s|fishing_packaging" def.can_swap_items:false def.can_move:false
      - else:
        - narrate "<&c>You need atleast <[quantity]> <[item].display>"
    - else:
      - narrate "<&c>I can work with this."

fishing_packaging:
  type: task
  debug: false
  data:
    stack_sizes:
      cod: 18
      salmon: 16
      ink_sac: 28
      bone: 20
      kelp: 19
  script:
    - if !<player.inventory.contains_item[empty_bundle]>:
      - narrate "<&c>You need an empty bundle for this."
      - stop
    - take item:empty_bundle quantity:1
    - define item <player.item_in_hand>
    - if <script[fishing_packaging].data_key[data.stack_sizes.<[item].material.name>].exists>:
      - define quantity <script[fishing_packaging].data_key[data.stack_sizes.<[item].material.name>]>
      - if <player.inventory.contains_item[<[item].script.name>].quantity[<[quantity]>]>:
        - take item:<[item].script.name> quantity:<[quantity]>
        - give item:fishing_<[item].material.name>_bundle