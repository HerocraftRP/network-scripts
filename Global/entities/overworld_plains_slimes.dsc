spawn_group_overworld_plains_slimes:
  type: data
  day:
    newbie_slime_1:
      - tier1_slime
    newbie_slime_2:
      - tier1_slime
      - tier1_slime
    newbie_slime_3:
      - tier1_slime
      - tier1_slime
      - tier1_slime
    newbie_slime_4:
      - tier2_slime
    newbie_slime_5:
      - tier2_slime
      - tier1_slime
    newbie_slime_6:
      - tier2_slime
      - tier3_slime
      - tier1_slime


tier1_slime:
  type: entity
  debug: false
  entity_type: slime
  mechanisms:
    size: 2
    health_data: 20/20
  flags:
    on_split: cancel


tier2_slime:
  type: entity
  debug: false
  entity_type: slime
  mechanisms:
    size: 3
    health_data: 30/30
  flags:
    drops:
      slimeball: 5
    on_split: cancel


tier3_slime:
  type: entity
  debug: false
  entity_type: slime
  mechanisms:
    size: 4
    health_data: 40/40
  flags:
    drops:
      slimeball: 30
      bone: 10
    on_split: cancel