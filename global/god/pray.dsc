pray_command:
  type: command
  name: pray
  debug: false
  usage: /pray (god) (message)
  description: pray to the gods, giving them a message
  data:
    lower: https<&co>//discord.com/api/webhooks/1244023705739464815/vZNYG0IMEsUD-D3rauXszEQVv3MuEFIqXl_avADQYIvdUAZjzVDUbbhGdxi2AzMlZ-9K
    middle: noop
    higher: noop
  tab completions:
    1: Progenitus|Zephyrin|Deus_Mortis
  script:
    - narrate <&e>[<&b>Prayer<&e>]<&r><player.flag[data.name]><&co><&sp><context.args.separated_by[<&sp>]> targets:<server.online_players.filter[has_permission[herocraft.god]]>
    - ~webget <script.parsed_key[data.lower]> headers:<map.with[Content-Type].as[application/json]> 'data:{"content":"<player.flag[data.name]><&co><&sp><context.args.separated_by[<&sp>]>"}'