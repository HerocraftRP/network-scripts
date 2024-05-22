parcool_limitation_defaults:
  type: task
  debug: false
  data:
    skills:
      BreakfallReady:
        enabled: false
        stamina_consumption: 0
      CatLeap:
        enabled: false
        stamina_consumption: 100
      Crawl:
        enabled: true
        stamina_consumption: 0
      Dive:
        enabled: true
        stamina_consumption: 0
      Dodge:
        enabled: false
        stamina_consumption: 100
      FastRun:
        enabled: false
        stamina_consumption: 2
      FastSwim:
        enabled: false
        stamina_consumption: 10
      Flipping:
        enabled: false
        stamina_consumption: 100
      HangDown:
        enabled: true
        stamina_consumption: 20
      HorizontalWallRun:
        enabled: false
        stamina_consumption: 10
      JumpFromBar:
        enabled: false
        stamina_consumption: 100
      QuickTurn:
        enabled: false
        stamina_consumption: 0
      Roll:
        enabled: false
        stamina_consumption: 5
      SkyDive:
        enabled: false
        stamina_consumption: 0
      Slide:
        enabled: false
        stamina_consumption: 0
      Tap:
        enabled: false
        stamina_consumption: 0
      Vault:
        enabled: false
        stamina_consumption: 10
      VerticalWallRun:
        enabled: false
        stamina_consumption: 10
      WallJump:
        enabled: false
        stamina_consumption: 100
      WallSlide:
        enabled: false
        stamina_consumption: 10
      ClingToCliff:
        enabled: true
        stamina_consumption: 20
      ClimbPoles:
        enabled: false
        stamina_consumption: 20
  script:
    - execute as_server "parcool limitation enable individual of <player.name>"
    - foreach <script.data_key[data.skills]>:
      - execute as_server "parcool limitation set individual of <player.name> possibility <[key]> <script.data_key[data.skills.<[key]>.enabled]>"
      - execute as_server "parcool limitation set individual of <player.name> least_stamina_consumption <[key]> <script.data_key[data.skills.<[key]>.stamina_consumption]>"