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
    - define skill <context.args.get[1]>
    - if !<player.inventory.contains_item[coin_gold].quantity[1]>:
      - narrate "<&c>It costs <&b>1 gold coin<&c> to apply for the School"
      - wait 1t
      - inventory close
      - stop
    - take item:coin_gold quantity:1
    - give item:<item[<[skill]>_contract].with_flag[on_drop:<list[guild_throw_book|remove_context_entity]>].with[display=<script[<[skill]>_contract].parsed_key[title]>]>
    - narrate "<&e>You hand over a <&6>Gold Coin<&e>, and they hand you a <script[<[skill]>_contract].parsed_key[title]>"
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

spell_creation_contract:
    type: book
    debug: false
    title: <script[capabilities_data].parsed_key[capability.spell_creation.color]>Skill Contract
    author: Grand Archfuh'qer
    signed: true
    text:
    - <&l><player.flag[data.name]>,<&r><&nl>You have been invited to learn <script[capabilities_data].parsed_key[capability.spell_creation.color]>Spell Creation<&r>, this book will explain the offer.
    - If you agree to this magically binding contract you shall be forever bound to it.
    - You will gain the knowledge required to begin your journey of the Spell Creation skill.
    - Place your left finger and press down hard to accept the terms outlined in this book<&nl><&nl><&dq><&7><element[PRESS HERE].on_click[/guild_accept spell_creation]><&dq>

endurance_contract:
    type: book
    title: <script[guild_data].parsed_key[data.warrior.color]>Skill Contract
    author: Sir the Goons'how
    signed: true
    text:
    - <&l><player.flag[data.name]>,<&r><&nl>You have been invited to learn <script[capabilities_data].parsed_key[capability.endurance.color]>Endurance<&r>, this book will explain the offer.
    - If you agree to this magically binding contract you shall be forever bound to it.
    - You will gain the knowledge required to begin your journey of the Endurance skill.
    - Place your left finger and press down hard to accept the terms outlined in this book<&nl><&nl>"<&7><element[PRESS HERE].on_click[/guild_accept endurance]>"

parkour_contract:
    type: book
    title: <script[guild_data].parsed_key[data.ranger.color]>Skill Contract
    author: Leetil Deek
    signed: true
    text:
    - <&l><player.flag[data.name]>,<&r><&nl>You have been invited to learn <script[capabilities_data].parsed_key[capability.parkour.color]>Parkour<&r>, this book will explain the offer.
    - If you agree to this magically binding contract you shall be forever bound to it.
    - You will gain the knowledge required to begin your journey of the Parkour skill.
    - Place your left finger and press down hard to accept the terms outlined in this book<&nl><&nl>"<&7><element[PRESS HERE].on_click[/guild_accept parkour]>"

mercantile_contract:
    type: book
    title: <script[guild_data].parsed_key[data.merchant.color]>Skill Contract
    author: Leetil Deek
    signed: true
    text:
    - <&l><player.flag[data.name]>,<&r><&nl>You have been invited to learn <script[capabilities_data].parsed_key[capability.mercantile.color]>Mercantile<&r>, this book will explain the offer.
    - If you agree to this magically binding contract you shall be forever bound to it.
    - You will gain the knowledge required to begin your journey of the Mercantile skill.
    - Place your left finger and press down hard to accept the terms outlined in this book<&nl><&nl>"<&7><element[PRESS HERE].on_click[/guild_accept mercantile]>"

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
    - if !<player.item_in_hand.book_title.ends_with[Contract]||true>:
      - stop
    - if <context.args.size> != 1:
      - stop
    - define skill <context.args.get[1].to_lowercase>
    - if !<script[capabilities_data].data_key[capability].keys.contains[<[skill]>]>:
      - stop
    - run join_guild_animation def:<[skill]>
    - narrate "<&6>You feel a wave of energy course through you."
    - take iteminhand

join_guild_animation:
  type: task
  debug: false
  definitions: skill
  script:
    - playsound sound:soulslikeuniverse:victory_from_boss custom <player> volume:0.5
    - define color <script[capabilities_data].parsed_key[capability.<[skill]>.color]>
    - repeat 30:
      - playeffect effect:redstone special_data:5|<[color]> quantity:10 offset:0.5,0.5,0.5 at:<player.location.above[0.7]>
      - wait 2t
    - repeat 40:
      - playeffect effect:redstone special_data:5|<[color]> quantity:10 offset:0.5,0.5,0.5 at:<player.location.above[0.7]>
      - wait 2t
    - playeffect effect:explosion_huge at:<player.location.above[0.7]> quantity:5 offset:0.2,0.2,0.2
    - playsound sound:relda:wraith1 pitch:0.1 <player> custom
    - playsound sound:relda:wraith1 pitch:2 <player> custom
    - title "title:<script[capabilities_data].parsed_key[capability.spell_creation.color]>Skill Acquired" subtitle:<[skill].replace[_].with[<&sp>].to_titlecase> fade_in:2s stay:3s fade_out:10t
    - flag player character.capabilities_enabled.<[skill]>