apply_for_guild_command:
  type: command
  debug: false
  name: apply_for_guild
  usage: nope
  description: don't do it white boy
  permission: not.a.perm
  script:
    - define target <server.match_player[<context.args.get[2]>]||null>
    - if <[target]> == null:
      - stop
    - adjust <queue> linked_player:<[target]>
    - define guild <context.args.get[1]>
    - if <player.has_flag[character.guild.name]>:
      - narrate "<&c>You already have a guild! <&nl>You have already chosen the <&b><player.flag[character.guild.name].to_titlecase>s Guild"
      - stop
    - if !<player.inventory.contains_item[coin_gold].quantity[1]>:
      - narrate "<&c>It costs <&b>1 gold coin<&c> to apply for the Guild"
      - wait 1t
      - inventory close
      - stop
    - take item:coin_gold quantity:1
    - flag player <[guild]>_guild_invite:<util.random_uuid>
    - give item:<item[<[guild]>_contract].with_flag[on_drop:<list[guild_throw_book|remove_context_entity]>].with[display=<script[<[guild]>_contract].parsed_key[title]>]>
    - narrate "<&e>You hand over a <&6>Gold Coin<&e>, and they hand you a <script[<[guild]>_contract].parsed_key[title]>"
    - wait 1t
    - inventory close

guild_throw_book:
  type: task
  debug: false
  script:
    - wait 10t
    - playeffect effect:smoke_normal at:<context.entity.location> quantity:3 offset:0,0,0
    - narrate "<&e>The contract disappears into thin air."

give_guild_contract:
  type: task
  debug: false
  definitions: guild
  script:
    - define UUID <util.random_uuid>
    - flag <player> <[guild]>_guild_invite:<[uuid]>
    - give item:<[guild]>_contract

mage_contract:
    type: book
    title: <script[guild_data].parsed_key[data.mage.color]>Mage Contract
    author: Grand Archfuh'qer
    signed: true
    text:
    - <&l><player.flag[data.name]>,<&r><&nl>You have been invited to the <script[guild_data].parsed_key[data.mage.color]>Mage's Guild<&r>, this book will explain the offer.
    - If you agree to this magically binding contract you shall be forever bound to it.
    - If at any point you should leave our guild, you will lose all gained knowledge and benfits
    - Place your left finger and press down hard to accept the terms outlined in this book<&nl><&nl>"<&7><element[PRESS HERE].on_click[/guild_accept mage <player.flag[mage_guild_invite]>]>"

warrior_contract:
    type: book
    title: <script[guild_data].parsed_key[data.warrior.color]>Warrior Contract
    author: Sir the Goons'how
    signed: true
    text:
    - <&l><player.flag[data.name]>,<&r><&nl>You have been invited to the <script[guild_data].parsed_key[data.warrior.color]>Warrior's Guild<&r>, this book will explain the offer.
    - If you agree to this magically binding contract you shall be forever bound to it.
    - If at any point you should leave our guild, you will lose all gained knowledge and benfits
    - Place your left finger and press down hard to accept the terms outlined in this book<&nl><&nl>"<&7><element[PRESS HERE].on_click[/guild_accept warrior <player.flag[warrior_guild_invite]>]>"

ranger_contract:
    type: book
    title: <script[guild_data].parsed_key[data.ranger.color]>Ranger Contract
    author: Leetil Deek
    signed: true
    text:
    - <&l><player.flag[data.name]>,<&r><&nl>You have been invited to the <script[guild_data].parsed_key[data.ranger.color]>Ranger's Guild<&r>, this book will explain the offer.
    - If you agree to this magically binding contract you shall be forever bound to it.
    - If at any point you should leave our guild, you will lose all gained knowledge and benfits
    - Place your left finger and press down hard to accept the terms outlined in this book<&nl><&nl>"<&7><element[PRESS HERE].on_click[/guild_accept ranger <player.flag[ranger_guild_invite]>]>"

merchant_contract:
    type: book
    title: <script[guild_data].parsed_key[data.merchant.color]>Merchant Contract
    author: Leetil Deek
    signed: true
    text:
    - <&l><player.flag[data.name]>,<&r><&nl>You have been invited to the <script[guild_data].parsed_key[data.merchant.color]>Merchant's Guild<&r>, this book will explain the offer.
    - If you agree to this magically binding contract you shall be forever bound to it.
    - If at any point you should leave our guild, you will lose all gained knowledge and benfits
    - Place your left finger and press down hard to accept the terms outlined in this book<&nl><&nl>"<&7><element[PRESS HERE].on_click[/guild_accept merchant <player.flag[merchant_guild_invite]>]>"

guild_accept_command:
  type: command
  debug: false
  name: guild_accept
  usage: /guild_accept
  description: not for manual usage
  tab completions:
    1: no
    2: bad
    3: monkey
    4: stop
    5: it
  script:
    - if <player.has_flag[character.guild.name]>:
      - take iteminhand
      - narrate "<&c>You are no longer welcome here! <&nl>You have already chosen the <&b><player.flag[character.guild.name].to_titlecase>s Guild"
      - stop
    - if <context.args.size> != 2:
      - stop
    - define guild <context.args.get[1].to_lowercase>
    - if !<list[ranger|warrior|mage|merchant].contains[<[guild]>]>:
      - stop
    - if <player.flag[<[guild]>_guild_invite]> != <context.args.get[2]>:
      - narrate "<&c>The magical seal rejects you, as it was not made for you."
      - stop
    - flag player character.guild.name:<[guild]>
    - run join_guild_animation def:<[guild]>
    - narrate "<&6>You feel a wave of energy course through you."
    - take iteminhand

join_guild_animation:
  type: task
  debug: false
  definitions: guild
  script:
    - playsound sound:soulslikeuniverse:victory_from_boss custom <player> volume:0.5
    - adjust <player> gravity:false
    - adjust <player> walk_speed:0.01
    - adjust <player> velocity:0,0.05,0
    - define color2 <script[guild_data].parsed_key[data.<[guild]>.color]>
    - repeat 30:
      - playeffect effect:redstone special_data:5|black quantity:10 offset:0.5,0.5,0.5 at:<player.location.above[0.7]>
      - wait 2t
    - repeat 40:
      - playeffect effect:redstone special_data:5|black quantity:10 offset:0.5,0.5,0.5 at:<player.location.above[0.7]>
      - playeffect effect:redstone special_data:1|<[color2]> quantity:20 offset:0.6,0.6,0.6 at:<player.location.above[0.7]>
      - wait 2t
    - playeffect effect:explosion_huge at:<player.location.above[0.7]> quantity:5 offset:0.2,0.2,0.2
    - playsound sound:relda:wraith1 pitch:0.1 <player> custom
    - playsound sound:relda:wraith1 pitch:2 <player> custom
    - title "title:<[color2]><[guild].to_titlecase>s Guild" subtitle:Welcome.... fade_in:2s stay:3s fade_out:10t
    - adjust <player> gravity:true
    - adjust <player> walk_speed:0.2
    - foreach <script[guild_data].data_key[data.<[guild]>.modifiers_by_rep.1]>:
      - wait 1t
      - if <[key]> == stamina_vessels:
        - adjust <player> stamina_vessels:<[value]>
      - if <[key]> == health:
        - foreach <[value]> key:part as:health:
          - part MAX part:<[part]> amount:<[health]>