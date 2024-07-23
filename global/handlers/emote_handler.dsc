emote_handler:
  type: world
  debug: false
  data:
    cancel_on_move:
      Hands up: false
      Salute: true
      Lay on back: true
  events:
    on player plays emote:
      - if <player.gamemode.equals[spectator]> || <context.name.exists.not> || <player.has_flag[temp.emote.name]>:
        - wait 1t
        - run cancel_emotes
        - stop
      - ratelimit <player> 1t
      - define name <context.name.replace[<&dq>].with[]>
      - if <script.data_key[data.cancel_on_move.<[name]>]||false>:
        - run add_framework_flag def:on_move|cancel_emote
        - flag player temp.emote.location:<player.location.simple>
      - flag player temp.emote.name:<[name]>
    on player stops emote:
      - ratelimit <player> 1t
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