coin_data:
  type: data
  currency_name: Ducat
  values:
    copper: 1
    silver: 10
    gold: 100
    diamond: 1000
    netherite: 10000
    platinum: 100000

wallet:
  type: item
  debug: false
  material: herocraft_wallet
  display name: <&6>Coin Pouch
  flags:
    right_click_script: wallet_GUI_open
    value: 0

coin_copper:
  type: item
  debug: false
  material: herocraft_copper_coin
  display name: <&6>Copper Coin
  lore:
    - <&e>Worth <script[coin_data].data_key[values.copper]> <script[coin_data].data_key[currency_name]>
  flags:
    money: <script[coin_data].data_key[values.copper]>

coin_silver:
  type: item
  debug: false
  material: herocraft_silver_coin
  display name: <&6>Silver Coin
  lore:
    - <&e>Worth <script[coin_data].data_key[values.silver]> <script[coin_data].data_key[currency_name]>
  flags:
    money: <script[coin_data].data_key[values.silver]>

coin_gold:
  type: item
  debug: false
  material: herocraft_gold_coin
  display name: <&6>Gold Coin
  lore:
    - <&e>Worth <script[coin_data].data_key[values.gold]> <script[coin_data].data_key[currency_name]>
  flags:
    money: <script[coin_data].data_key[values.gold]>

coin_diamond:
  type: item
  debug: false
  material: herocraft_diamond_coin
  display name: <&6>Diamond Coin
  lore:
    - <&e>Worth <script[coin_data].data_key[values.diamond]> <script[coin_data].data_key[currency_name]>
  flags:
    money: <script[coin_data].data_key[values.diamond]>

coin_netherite:
  type: item
  debug: false
  material: herocraft_netherite_coin
  display name: <&6>Netherite Coin
  lore:
    - <&e>Worth <script[coin_data].data_key[values.netherite]> <script[coin_data].data_key[currency_name]>
  flags:
    money: <script[coin_data].data_key[values.netherite]>

coin_platinum:
  type: item
  debug: false
  material: herocraft_platinum_coin
  display name: <&6>Platinum Coin
  lore:
    - <&e>Worth <script[coin_data].data_key[values.platinum]> <script[coin_data].data_key[currency_name]>
  flags:
    money: <script[coin_data].data_key[values.platinum]>

# Give Coin Buttons
wallet_give_coin_copper_button:
  type: item
  debug: false
  material: herocraft_copper_coin
  display name: <&6>Copper Coin
  lore:
    - <&e>Withdraw 1 <script.data_key[display name].parsed>
    - <&e>Worth <script[coin_data].data_key[values.copper]> <script[coin_data].data_key[currency_name]>
  flags:
    money_type: copper
    run_script: wallet_give_coin

wallet_give_coin_silver_button:
  type: item
  debug: false
  material: herocraft_silver_coin
  display name: <&6>Silver Coin
  lore:
    - <&e>Withdraw 1 <script.data_key[display name].parsed>
    - <&e>Worth <script[coin_data].data_key[values.silver]> <script[coin_data].data_key[currency_name]>
  flags:
    money_type: silver
    run_script: wallet_give_coin

wallet_give_coin_gold_button:
  type: item
  debug: false
  material: herocraft_gold_coin
  display name: <&6>Gold Coin
  lore:
    - <&e>Withdraw 1 <script.data_key[display name].parsed>
    - <&e>Worth <script[coin_data].data_key[values.gold]> <script[coin_data].data_key[currency_name]>
  flags:
    money_type: gold
    run_script: wallet_give_coin

wallet_give_coin_diamond_button:
  type: item
  debug: false
  material: herocraft_diamond_coin
  display name: <&6>Diamond Coin
  lore:
    - <&e>Withdraw 1 <script.data_key[display name].parsed>
    - <&e>Worth <script[coin_data].data_key[values.diamond]> <script[coin_data].data_key[currency_name]>
  flags:
    money_type: diamond
    run_script: wallet_give_coin

wallet_give_coin_netherite_button:
  type: item
  debug: false
  material: herocraft_netherite_coin
  display name: <&6>Netherite Coin
  lore:
    - <&e>Withdraw 1 <script.data_key[display name].parsed>
    - <&e>Worth <script[coin_data].data_key[values.netherite]> <script[coin_data].data_key[currency_name]>
  flags:
    money_type: netherite
    run_script: wallet_give_coin

wallet_give_coin_platinum_button:
  type: item
  debug: false
  material: herocraft_platinum_coin
  display name: <&6>Platinum Coin
  lore:
    - <&e>Withdraw 1 <script.data_key[display name].parsed>
    - <&e>Worth <script[coin_data].data_key[values.platinum]> <script[coin_data].data_key[currency_name]>
  flags:
    money_type: platinum
    run_script: wallet_give_coin

#Coin Icons
wallet_icon_coin_copper:
  type: item
  debug: false
  material: herocraft_copper_coin
  display name: <script[coin_copper].data_key[display name].parsed>
  lore:
    - <&e>Worth <script[coin_copper].data_key[flags.money]> <script[coin_data].data_key[currency_name]>

wallet_icon_coin_silver:
  type: item
  debug: false
  material: herocraft_silver_coin
  display name: <script[coin_silver].data_key[display name].parsed>
  lore:
    - <&e>Worth <script[coin_silver].data_key[flags.money]> <script[coin_data].data_key[currency_name]>

wallet_icon_coin_gold:
  type: item
  debug: false
  material: herocraft_gold_coin
  display name: <script[coin_gold].data_key[display name].parsed>
  lore:
    - <&e>Worth <script[coin_gold].data_key[flags.money]> <script[coin_data].data_key[currency_name]>

wallet_icon_coin_diamond:
  type: item
  debug: false
  material: herocraft_iron_coin
  display name: <script[coin_diamond].data_key[display name].parsed>
  lore:
    - <&e>Worth <script[coin_diamond].data_key[flags.money]> <script[coin_data].data_key[currency_name]>

wallet_icon_coin_netherite:
  type: item
  debug: false
  material: herocraft_netherite_coin
  display name: <script[coin_netherite].data_key[display name].parsed>
  lore:
    - <&e>Worth <script[coin_netherite].data_key[flags.money]> <script[coin_data].data_key[currency_name]>

wallet_icon_coin_platinum:
  type: item
  debug: false
  material: herocraft_platinum_coin
  display name: <script[coin_platinum].data_key[display name].parsed>
  lore:
    - <&e>Worth <script[coin_platinum].data_key[flags.money]> <script[coin_data].data_key[currency_name]>

wallet_GUI:
  type: inventory
  debug: false
  inventory: chest
  title: <&6>Wallet
  data:
    any_click: wallet_process
    drags: cancel
    on_close: wallet_update
  slots:
    - [] [] [] [wallet_give_coin_copper_button] [wallet_give_coin_silver_button] [wallet_give_coin_gold_button] [wallet_give_coin_diamond_button] [wallet_give_coin_netherite_button] [wallet_give_coin_platinum_button]

wallet_GUI_open:
  type: task
  debug: false
  script:
    - define inventory <inventory[wallet_GUI]>
    - adjust <[inventory]> title:<&6>Money<&co><&sp><player.item_in_hand.flag[value]||0>
    - inventory open d:<[inventory]>

wallet_give_coin:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - define type <context.item.flag[money_type]>
    - define amount <script[coin_data].data_key[values.<[type]>]>
    - define amountHeld <player.item_in_hand.flag[value]||0>
    - if <[amountHeld]> < <[amount]>:
      - narrate "<&c>You too broke! Get Job!"
      - stop
    - give item:coin_<[type]>
    - inventory flag slot:<player.held_item_slot> value:<[amountHeld].sub[<[amount]>]>
    - run wallet_GUI_open

wallet_update:
  type: task
  debug: false
  script:
    - wait 1t
    - inventory update

wallet_process:
  type: task
  debug: false
  script:
    - if !<context.item.has_flag[money]> && !<context.cursor_item.has_flag[money]>:
      - determine cancelled
    - if <context.cursor_item.has_flag[money]> && <context.item.material.name> != air:
      - determine cancelled
    - if <context.clicked_inventory.script.name||null> == wallet_gui && <list[1|2|3].contains[<context.slot>]>:
      - inventory flag slot:<player.held_item_slot> value:<player.item_in_hand.flag[value].add[<context.cursor_item.flag[money].mul[<context.cursor_item.quantity>]>]>
      - adjust <player> item_on_cursor:air
      - run wallet_GUI_open
    - else if <context.is_shift_click>:
      - determine cancelled if:<context.item.has_flag[money].not>
      - inventory flag slot:<player.held_item_slot> value:<player.item_in_hand.flag[value].add[<context.item.flag[money].mul[<context.item.quantity>]>]>
      - determine passively <item[air]>
      - run wallet_GUI_open