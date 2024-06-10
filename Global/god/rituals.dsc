god_ritual_animation:
  type: task
  debug: false
  definitions: location|god
  script:
    - define origin_point <[location].highest.above[80]>
    - define points <[location].points_between[<[origin_point]>].distance[0.5]>
    ## Initialization Beam
    - foreach <[points]>:
      - playeffect at:<[value]> effect:redstone special_data:5|black quantity:20 offset:0.25,0.25,0.25 targets:<server.online_players>
      - playeffect at:<[value]> effect:redstone special_data:1|purple quantity:30 offset:0.5,0.5,0.5 targets:<server.online_players>
      - wait 1t
    ## Start Ritual Officially - 10 Minutes
    - run god_ritual_animation_beacon def:<[origin_point]>
    ## Battle Field Animation
    - repeat 3000:
    #- repeat 240:
      - playeffect at:<[location].above[2]> effect:redstone special_data:<[value].mul[0.0003].add[0.5]>|black quantity:20 offset:5,2,5 targets:<server.online_players>
      - playeffect at:<[location].above[2]> effect:redstone special_data:<[value].mul[0.0003].add[0.25]>|purple quantity:20 offset:6,2,6 targets:<server.online_players>
      - wait 2t
    - run god_ritual_animation_spiral_launcher def:<[location]>|<[origin_point]>

god_ritual_animation_beacon:
  type: task
  debug: false
  definitions: location
  script:
    - repeat 6000:
      - define size1 <element[1.5].add[<[value].mul[0.00025]>]>
      - define size2 <[size1].add[0.2]>
      - playeffect at:<[location]> effect:redstone special_data:5|black quantity:60 offset:<[size1]>,<[size1]>,<[size1]> targets:<server.online_players>
      - playeffect at:<[location]> effect:redstone special_data:1|purple quantity:50 offset:<[size2]>,<[size2]>,<[size2]> targets:<server.online_players>
      - wait 2t

god_ritual_animation_spiral_launcher:
  type: task
  debug: false
  definitions: start|end
  script:
    #- repeat 300:
    - repeat 300:
      - run god_ritual_animation_spiral def:<[start]>|<[end]>
      - wait 1s

god_ritual_animation_spiral:
  type: task
  debug: false
  definitions: start|end
  script:
    - define spiral <proc[define_spiral].context[<[start]>|<[end]>|6|<util.random_decimal.mul[360].round>]>
    - foreach <[spiral]>:
      - playeffect at:<[value]> effect:redstone special_data:5|black quantity:1 offset:0,0,0 targets:<server.online_players>
      - playeffect at:<[value]> effect:redstone special_data:1|purple quantity:1 offset:1,1,1 targets:<server.online_players>
      - wait 1t