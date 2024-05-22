emote_handler:
  type: world
  debug: false
  data:
    cancel_on_move:
      Hands up: false
      Salute: true
      Lay on back: true
    can_multi_emote:
      Hands up: true
      Salute: false
      Lay on back: false
  events:
    on player plays emote:
      - define name <context.name.replace[<&dq>].with[]>
      - if <script.data_key[data.cancel_on_move.<[name]>]||false>:
        - run add_framework_flag def:on_move|cancel_emote
        - flag player temp.emote.location:<player.location.simple>
      - if <player.has_flag[temp.emote.name]> && !<script.data_key[data.can_multi_emote.<player.flag[temp.emote.name]>]||false>:
        - run cancel_emotes
      - flag player temp.emote.name:<[name]>
    on player stops emote:
      - if <player.has_flag[temp.emote]>:
        - run remove_framework_flag def:on_move|cancel_emote
        - flag <player> temp.emote:!
    on player clicks block flagged:temp.emote:
      - run cancel_emotes

cancel_emote:
  type: task
  debug: false
  script:
    - stop if:<player.location.simple.equals[<player.flag[temp.emote.location]>]>
    - run cancel_emotes
    - run remove_framework_flag def:on_move|cancel_emote

cancel_emotes:
  type: command
  debug: false
  name: cancel_emotes
  usage: /cancel_emotes
  description: cancels all active emotes
  script:
    - stop if:<list[adventure|creative|survival].contains[<player.gamemode>].not>
    - flag player temp.emote:!
    - run remove_framework_flag def:on_move|cancel_emote
    - if <player.vehicle.exists>:
      - run sit_cancel
    - execute as_server "emotes stop <player.name>"