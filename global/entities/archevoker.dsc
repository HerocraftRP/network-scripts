spawn_group_archevoker:
  type: data
  day:
    archevoker_1:
      - adventurer_IRONS_SPELLBOOKS_ARCHEVOKER
    archevoker_2:
      - adventurer_IRONS_SPELLBOOKS_ARCHEVOKER
      - adventurer_IRONS_SPELLBOOKS_ARCHEVOKER
    archevoker_3:
      - adventurer_IRONS_SPELLBOOKS_ARCHEVOKER
      - adventurer_IRONS_SPELLBOOKS_ARCHEVOKER
      - adventurer_IRONS_SPELLBOOKS_ARCHEVOKER

adventurer_IRONS_SPELLBOOKS_ARCHEVOKER:
  type: entity
  debug: false
  entity_type: IRONS_SPELLBOOKS_ARCHEVOKER
  mechanisms:
    health_data: 120/120
  flags:
    on_death: handle_drops
    drops:
      - coin_gold