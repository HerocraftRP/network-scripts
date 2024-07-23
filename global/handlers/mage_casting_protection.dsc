mage_cancel_spell:
  type: world
  debug: false
  events:
    on player casts spell:
      - if !<player.has_flag[character.capabilities.spell_creation]>:
        - narrate "<&c>You lack the magical prowess to harness this power."
        - determine cancelled