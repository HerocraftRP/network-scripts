guild_data:
  type: data
  data:
    warrior:
      color: <&color[#FF0000]>
      modifiers_by_rep:
        1:
          stamina_vessels: 20
          health:
            HEAD: 4
            BODY: 8
            LEFT_ARM: 8
            RIGHT_ARM: 8
            LEFT_LEG: 8
            RIGHT_LEG: 8
            LEFT_FOOT: 8
            RIGHT_FOOT: 8
      skill_checks:
        guard: 1
        parrying: 1
        arrow_tenacity: 10
        stamina_pillager: 20
        dodge_master: 30
    mage:
      color: <&color[#FF33FF]>
      modifiers_by_rep:
        1:
          health:
            HEAD: 2
            BODY: 2
            LEFT_ARM: 2
            RIGHT_ARM: 2
            LEFT_LEG: 2
            RIGHT_LEG: 2
            LEFT_FOOT: 2
            RIGHT_FOOT: 2
      skill_checks:
        underfoot: 1
        toss: 10
        bounce: 20
        ignite: 30
        amplify: 40
    ranger:
      color: <&color[#00FF00]>
      modifiers_by_rep:
        1:
          stamina_vessels: 10
          health:
            HEAD: 2
            BODY: 4
            LEFT_ARM: 4
            RIGHT_ARM: 4
            LEFT_LEG: 6
            RIGHT_LEG: 6
            LEFT_FOOT: 6
            RIGHT_FOOT: 6
      skill_checks:
        FastRun: 1
        Dodge: 10
        Breakfall: 20
        Slide: 30
        CatLeap: 40
    merchant:
      color: <&color[#FFBB00]>
      modifiers_by_rep:
        1:
          noop: 3
      skill_checks:
        supply_cart: 1
        parrying: 1
        arrow_tenacity: 10
        stamina_pillager: 20
        dodge_master: 30
    no_guild:
      modifiers_by_rep:
        1:
          stamina_vessels: 0
          health:
            HEAD: 2
            BODY: 2
            LEFT_ARM: 2
            RIGHT_ARM: 2
            LEFT_LEG: 2
            RIGHT_LEG: 2
            LEFT_FOOT: 2
            RIGHT_FOOT: 2