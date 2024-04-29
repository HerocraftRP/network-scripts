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
    - if <context.item.material.name> == air || <context.item.material.name.starts_with[calemieconomy_]>:
      - if <context.click> != NUMBER_KEY:
        - stop
    - determine cancelled

bank_inventory_save:
  type: task
  debug: false
  script:
    - flag <player> bank.contents:<player.open_inventory.map_slots>

bank_interact:
  type: task
  debug: false
  script:
    - run start_timed_action "def:<&e>Accessing Bank|1s|bank_inventory_open" def.distance_from_origin:2

bank_inventory_open:
  type: task
  debug: false
  script:
    - if <player.has_flag[bank.contents]>:
      - define inventory <inventory[bank_inventory]>
      - foreach <player.flag[bank.contents]>:
        - inventory set slot:<[key]> d:<[inventory]> o:<[value]>
      - inventory open d:<[inventory]>
      - stop
    - define inventory <inventory[bank_inventory]>
    - inventory open d:<[inventory]>

bank_inventory_open_command:
  type: command
  name: open_bank
  debug: false
  usage: NO
  description: for bank NPC Usage
  permissions: not.a.perm
  script:
    - run bank_inventory_open player:<server.match_player[<context.args.get[1]>]>

bank_safety_box_inventory:
  type: inventory
  debug: false
  inventory: chest
  title: <&6>Bank
  size: 9
  data:
    on_close: bank_safety_box_save

bank_safety_box_open_command:
  type: command
  name: open_safe_box
  debug: false
  usage: NO
  description: for bank NPC Usage
  permissions: not.a.perm
  script:
    - run bank_safety_box_open player:<server.match_player[<context.args.get[1]>]>

bank_safety_box_open:
  type: task
  debug: false
  script:
    - if <player.has_flag[bank.safe_box]>:
      - define inventory <inventory[bank_safety_box_inventory]>
      - foreach <player.flag[bank.safe_box]>:
        - inventory set slot:<[key]> d:<[inventory]> o:<[value]>
      - inventory open d:<[inventory]>
      - stop
    - define inventory <inventory[bank_safety_box_inventory]>
    - inventory open d:<[inventory]>

bank_safety_box_save:
  type: task
  debug: false
  script:
    - flag <player> bank.safe_box:<player.open_inventory.map_slots>