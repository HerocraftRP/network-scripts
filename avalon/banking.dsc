bank_inventory:
  type: inventory
  debug: false
  inventory: chest
  title: <&6>Bank
  size: 9
  data:
    any_click: bank_inventory_sanitize
    on_close: bank_inventory_save

bank_inventory_sanitize:
  type: task
  debug: false
  script:
    - if <context.item.material.name> == air || <context.item.has_flag[money]>:
      - if <context.click> != NUMBER_KEY:
        - stop
    - determine cancelled

bank_inventory_save:
  type: task
  debug: false
  script:
    - flag <player> character.bank.contents:<player.open_inventory.map_slots>

bank_interact:
  type: task
  debug: false
  script:
    - run start_timed_action "def:<&e>Accessing Bank|1s|bank_inventory_open" def.distance_from_origin:2

bank_inventory_sanitize:
  type: task
  debug: false
  script:
    - define valueTotal 0
    - foreach <player.flag[character.bank.contents]> as:item:
      - define valueTotal <[valueTotal].add[<[item].flag[money].mul[<[item].quantity>]>]>
    - flag <player> character.bank.value:<[valueTotal]>
    - flag <player> character.bank.contents:!

bank_inventory_open_command:
  type: command
  name: open_bank
  debug: false
  usage: NO
  description: for bank NPC Usage
  permissions: not.a.perm
  script:
    - run bank_GUI_open player:<server.match_player[<context.args.get[1]>]>

bank_safety_box_inventory:
  type: inventory
  debug: false
  inventory: chest
  title: <&6>Safety Box
  size: 9
  data:
    on_close: bank_safety_box_save

bank_safety_box_open_command:
  type: command
  name: open_safe_box
  debug: false
  usage: NO
  description: for bank NPC Usage
  permission: not.a.perm
  script:
    - run bank_safety_box_open player:<server.match_player[<context.args.get[1]>]>

bank_safety_box_open:
  type: task
  debug: false
  script:
    - if <player.has_flag[character.bank.safe_box]>:
      - define inventory <inventory[bank_safety_box_inventory]>
      - if <player.has_flag[character.bank.safe_box]>:
        - foreach <player.flag[character.bank.safe_box]>:
          - inventory set slot:<[key]> d:<[inventory]> o:<[value]>
      - inventory open d:<[inventory]>
      - stop
    - define inventory <inventory[bank_safety_box_inventory]>
    - inventory open d:<[inventory]>

bank_safety_box_save:
  type: task
  debug: false
  script:
    - flag <player> character.bank.safe_box:<player.open_inventory.map_slots>

new_bank_GUI:
  type: inventory
  debug: false
  inventory: chest
  title: <&6>Wallet
  data:
    any_click: bank_process
    drags: cancel
  slots:
    - [] [] [] [bank_give_coin_copper_button] [bank_give_coin_silver_button] [bank_give_coin_gold_button] [bank_give_coin_diamond_button] [bank_give_coin_netherite_button] [bank_give_coin_platinum_button]

bank_GUI_open:
  type: task
  debug: false
  script:
    - if <player.has_flag[character.bank.contents]>:
      - run bank_inventory_sanitize
    - define inventory <inventory[new_bank_GUI]>
    - if !<player.has_flag[character.bank.value]> || !<player.flag[character.bank.value].is_integer>:
      - flag player character.bank.value:0
    - adjust <[inventory]> "title:<&6>Banked Money<&co><&sp><player.flag[character.bank.value]>"
    - inventory open d:<[inventory]>

bank_give_coin:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - define type <context.item.flag[money_type]>
    - define amount <script[coin_data].data_key[values.<[type]>]>
    - define amountHeld <player.flag[character.bank.value]>
    - if <[amountHeld]> < <[amount]>:
      - narrate "<&c>You too broke! Get Job!"
      - stop
    - give item:coin_<[type]>
    - flag player character.bank.value:<[amountHeld].sub[<[amount]>]>
    - run bank_GUI_open

bank_process:
  type: task
  debug: false
  script:
    - if !<context.item.has_flag[money]> && !<context.cursor_item.has_flag[money]>:
      - determine cancelled
    - if <context.cursor_item.has_flag[money]> && <context.item.material.name> != air:
      - determine cancelled
    - if <context.clicked_inventory.script.name||null> == new_bank_GUI && <list[1|2|3].contains[<context.slot>]>:
      - flag player character.bank.value:+:<context.cursor_item.flag[money].mul[<context.cursor_item.quantity>]>
      - adjust <player> item_on_cursor:air
      - run bank_GUI_open
    - else if <context.is_shift_click>:
      - determine cancelled if:<context.item.has_flag[money].not>
      - flag player character.bank.value:+:<context.item.flag[money].mul[<context.item.quantity>]>
      - determine passively <item[air]>
      - run bank_GUI_open

# Give Coin Buttons
bank_give_coin_copper_button:
  type: item
  debug: false
  material: herocraft_copper_coin
  display name: <&6>Copper Coin
  lore:
    - <&e>Withdraw 1 <script.data_key[display name].parsed>
    - <&e>Worth <script[coin_data].data_key[values.copper]> <script[coin_data].data_key[currency_name]>
  flags:
    money_type: copper
    run_script: bank_give_coin

bank_give_coin_silver_button:
  type: item
  debug: false
  material: herocraft_silver_coin
  display name: <&6>Silver Coin
  lore:
    - <&e>Withdraw 1 <script.data_key[display name].parsed>
    - <&e>Worth <script[coin_data].data_key[values.silver]> <script[coin_data].data_key[currency_name]>
  flags:
    money_type: silver
    run_script:  bank_give_coin

bank_give_coin_gold_button:
  type: item
  debug: false
  material: herocraft_gold_coin
  display name: <&6>Gold Coin
  lore:
    - <&e>Withdraw 1 <script.data_key[display name].parsed>
    - <&e>Worth <script[coin_data].data_key[values.gold]> <script[coin_data].data_key[currency_name]>
  flags:
    money_type: gold
    run_script:  bank_give_coin

bank_give_coin_diamond_button:
  type: item
  debug: false
  material: herocraft_diamond_coin
  display name: <&6>Diamond Coin
  lore:
    - <&e>Withdraw 1 <script.data_key[display name].parsed>
    - <&e>Worth <script[coin_data].data_key[values.diamond]> <script[coin_data].data_key[currency_name]>
  flags:
    money_type: diamond
    run_script:  bank_give_coin

bank_give_coin_netherite_button:
  type: item
  debug: false
  material: herocraft_netherite_coin
  display name: <&6>Netherite Coin
  lore:
    - <&e>Withdraw 1 <script.data_key[display name].parsed>
    - <&e>Worth <script[coin_data].data_key[values.netherite]> <script[coin_data].data_key[currency_name]>
  flags:
    money_type: netherite
    run_script:  bank_give_coin

bank_give_coin_platinum_button:
  type: item
  debug: false
  material: herocraft_platinum_coin
  display name: <&6>Platinum Coin
  lore:
    - <&e>Withdraw 1 <script.data_key[display name].parsed>
    - <&e>Worth <script[coin_data].data_key[values.platinum]> <script[coin_data].data_key[currency_name]>
  flags:
    money_type: platinum
    run_script:  bank_give_coin