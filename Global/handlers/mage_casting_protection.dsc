mage_cancel_spell:
  type: world
  debug: false
  events:
    on player casts spell:
      - if !<player.has_flag[data.guild.name]> || <player.flag[data.guild.name]> != mage:
        - narrate "<&c>You lack the magical prowess to harness this power."
        - determine cancelled