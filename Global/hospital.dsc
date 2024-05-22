hospital_heal:
  type: command
  name: nancy_heal
  description: nope
  usage: /nancy_heal
  debug: false
  permission: not.a.perm
  script:
    - wait 1t
    - define target <server.match_player[<context.args.get[1]>]>
    - inventory close player:<[target]>
    - ratelimit <[target]> 1m
    - repeat 15:
      - playeffect effect:VILLAGER_HAPPY at:<[target].location.above[1.25]> quantity:25 offset:0.25,.5,0.25
      - heal <[target]>
      - wait 1t