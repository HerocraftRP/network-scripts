send_to_discord:
  type: task
  debug: false
  definitions: content
  script:
    - ~webget https://discord.com/api/webhooks/1228459858488070294/tDoUggsZ1j7VJYw_epmN_UXZoPeH0l6kRguMvCT_q4ZH8eZGJm3kZnKrcyC8VFgIr5QA headers:<map.with[Content-Type].as[application/json]> 'data:{"content":"<[content]>"}'