set_god:
  type: task
  debug: false
  definitions: target|name
  script:
    - define target <player> if:<[target].exists.not>
    - flag <[target]> character.god:<[name]>
    - define god_script <script[god_<[name]>]>
    - foreach <script[all_god_powers].data_key[powers]>:
      - execute as_server "lp user <[target].name> permission set <[value]> <script[god_<[name]>].data_key[powers.<[value]>]>"
    - flag <[target]> character.vision_level:<[god_script].data_key[data.vision_level]>
    - flag <[target]> character.order.name:<[name]>
    - run group_manager_create def:<[name]>|order|<[target]>

build_god_list:
  type: world
  debug: false
  build_list:
    - flag server god_list:<util.scripts.filter[name.starts_with[god]].filter[container_type.equals[DATA]].parse[name.after[god_].to_titlecase]>
  events:
    on script reload:
      - run <script> path:build_list
    on server start:
      - run <script> path:build_list