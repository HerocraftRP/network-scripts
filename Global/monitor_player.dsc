monitor_player_events:
  type: world
  debug: false
  events:
    on player clicks block flagged:data:
      - ratelimit <player> 10s
      - define output "<player.name> <context.click_type> clicked <context.location.material.name> with <player.item_in_hand.material.name>"
      - ~webget https://discord.com/api/webhooks/1232329900581457931/_9xsQuhZ1VBBkTdS68xdM4R4Iyn8U9gEW-AUIwfGNbYLxplZDQbmq7BmsOcCmAUnSJ9e headers:<map.with[Content-Type].as[application/json]> 'data:{"content": "<[output]>"}'
    on command flagged:data:
      - define output "<player.name> used command <context.command> with args <context.raw_args>"
      - ~webget https://discord.com/api/webhooks/1232329816733126656/3av-59gJPXUeJ7hQQ8NtqHpt4frgT29cD9p_hd0k8LxmGbyD74-FphAm-jd5iztq-TzH headers:<map.with[Content-Type].as[application/json]> 'data:{"content": "<[output]>"}'
    on player right clicks entity flagged:data:
      - ratelimit <player> 10s
      - define output "<player.name> clicked entity <context.entity>"
      - ~webget https://discord.com/api/webhooks/1232330795335811194/VkscGNnBmLVbHG_sOG4bpXLrcB60RwgZEuYtNneVDQrUojo_1w4QRC9Bk1zKR3JYMOny headers:<map.with[Content-Type].as[application/json]> 'data:{"content": "<[output]>"}'