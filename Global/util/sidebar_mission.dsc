sidebar_mission:
  type: data
  data:
    missions:
      # Export Mission
      export:
        steps:
          - Go to Lumberjack sales.
          - Talk to the Shopkeeper.
          - Deliver the goods to the dock.
          - Go collect your pay
          - test


##Hate This, let it burn.
sidebar_mission_set_stage:
  type: task
  debug: false
  definitions: mission|stage|target
  script:
    - stop if:<script[sidebar_mission].data_key[data.missions.<[mission]>.steps].exists.not>
    - define target <player> if:<[target].exists.not>
    - stop if:<[target].has_flag[temp.sidebar.<[mission]>].not>
    - define steps <list[]>
    - foreach <script[sidebar_mission].parsed_key[data.missions.<[mission]>.steps]>:
      - if <[loop_index]> < <[stage]>:
        - define steps <[steps].include[<&a><&m><[value]>]>
      - if <[loop_index]> == <[stage]>:
        - define steps <[steps].include[<&e><[value]>]>
      - if <[loop_index]> > <[stage]>:
        - define steps <[steps].include[<&7><[value]>]>
    - sidebar players:<[target]> "title:<&e><[mission].to_titlecase> Job" "values:<[steps]>" scores:1|2|3|4|5|6|7|8|9
    - flag <player> temp.sidebar.<[mission]>.stage:<[stage]>