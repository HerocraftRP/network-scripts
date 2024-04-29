apartment_inventory:
  type: inventory
  debug: false
  inventory: chest
  title: <&6>Personal Stash
  size: 18
  data:
    on_close: apartment_inventory_save

apartment_inventory_save:
  type: task
  debug: false
  script:
    - flag <player> apartment.contents:<player.open_inventory.map_slots>

apartment_inventory_open:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - if <player.has_flag[apartment.contents]>:
      - define inventory <inventory[apartment_inventory]>
      - foreach <player.flag[apartment.contents]>:
        - inventory set slot:<[key]> d:<[inventory]> o:<[value]>
      - inventory open d:<[inventory]>
      - stop
    - define inventory <inventory[apartment_inventory]>
    - inventory open d:<[inventory]>

apartment_teleport_in:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - adjust <player> hide_from_players
    - teleport <player> <server.flag[apartment.entrance]>

apartment_teleport_out:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - adjust <player> show_to_players
    - teleport <player> <server.flag[apartment.exit]>