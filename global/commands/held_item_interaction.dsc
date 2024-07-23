held_item_interaction:
  type: command
  name: held_item_interaction
  debug: false
  description: Interact with the item in your hands
  usage: /held_item_interaction (#)
  script:
    - stop if:<context.args.size.equals[1].not>
    - if <context.args.get[1]> == 1:
      - if <player.item_in_hand.has_flag[interaction.1.script]>:
        - inject <player.item_in_hand.flag[interaction.1.script]>
    - else if <context.args.get[1]> == 2:
      - if <player.item_in_hand.has_flag[interaction.2.script]>:
        - inject <player.item_in_hand.flag[interaction.2.script]>

interactions_add_to_item:
  type: task
  debug: false
  definitions: slot|interaction_script|interaction_display
  script:
    - define item <player.inventory.slot[<[slot]>]>
    - if !<[item].has_flag[interaction.1]>:
      - inventory flag slot:<[slot]> interaction.1.script:<[interaction_script]>
      - inventory flag slot:<[slot]> interaction.1.display:<[interaction_display]>
      - if <[item].has_lore>:
        - inventory adjust slot:<[slot]> "lore:<[item].lore.include[<&7>___________________|<&r>|<&a>Interaction 1<&co> <[interaction_display]>|<&7>___________________]>"
      - else:
        - inventory adjust slot:<[slot]> "lore:<list[<&7>___________________|<&r>|<&a>Interaction 1<&co> <[interaction_display]>|<&7>___________________]>"
    - else if !<[item].has_flag[interaction.2]>:
      - inventory flag slot:<[slot]> interaction.2.script:<[interaction_script]>
      - inventory flag slot:<[slot]> interaction.2.display:<[interaction_display]>
      - inventory adjust slot:<[slot]> "lore:<[item].lore.insert[<&a>Interaction 2<&co> <[interaction_display]>].at[4]>"

interaction_remove_from_item:
  type: task
  debug: false
  definitions: slot|interaction_number
  script:
    - define item <player.inventory.slot[<[slot]>]>
    - if <[interaction_number]> == 1 && <[item].has_flag[interaction.1]>:
      - if <[item].has_flag[interaction.2]>:
        - inventory flag slot:<[slot]> interaction.1:<[item].flag[interaction.2]>
        - inventory flag slot:<[slot]> interaction.2:!
        - inventory adjust slot:<[slot]> "lore:<list[<&7>___________________|<&r>|<&a>Interaction 1<&co> <[item].flag[interaction.1.display]>|]>"
      - else:
        - inventory flag slot:<[slot]> interaction.1:!
        - inventory adjust slot:<[slot]> lore
    - else if <[interaction_number]> == 2 && <[item].has_flag[interaction.2]>:
      - inventory flag slot:<[slot]> interaction.2:!
      - inventory adjust slot:<[slot]> lore