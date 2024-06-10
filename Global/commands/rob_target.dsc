rob_target:
  type: command
  name: rob_target
  debug: false
  usage: /rob_target
  description: Rob your target.... duh.
  script:
    - ratelimit <player> 1s
    - define target <player.precise_target[5]||null>
    - if <[target]> == null:
      - narrate "<&c>You have no target."
      - stop
    - if <[target].has_flag[character.god]>:
      - narrate "<&c>You're not stupid enough to rob a god."
      - stop
    - if <[target].has_flag[on_robbed]>:
      - inject <[target].flag[on_robbed]>
    - if <[target].entity_type> == VILLAGER:
      - run start_timed_action "def:<&c>Robbing Villager|10s|rob_local_callback|<[target]>" def.distance_from_origin:1 def.animation_task:rob_local_animation
    - else if <[target].entity_type> == PLAYER:
      - if !<player.has_flag[temp.active_duty_guard]> && !<player.has_flag[character.god]>:
        - run start_timed_action "def:<&c>Robbing Target|10s|rob_player_callback|<[target]>" def.distance_from_origin:1 def.animation_task:rob_local_animation
        - run locals_report_robbery def:<player>
      - else:
        - run rob_player_callback def:<[target]>|!<player.has_flag[character.god]>
    - else if <[target].entity_type> == CORPSE_CORPSE:
      - run start_timed_action "def:<&c>Robbing Corpse|10s|rob_player_callback|<[target].flag[owner]>" def.distance_from_origin:1 def.animation_task:rob_local_animation
      - run locals_report_robbery def:<player>

locals_report_robbery:
  type: task
  debug: false
  definitions: criminal
  script:
    - foreach <[criminal].location.find_entities[VILLAGER].within[32]>:
      - if <[value].can_see[<[criminal]>]>:
        - run guards_report_crime "def:<[value].location>|Robbery In Progress|<[criminal]>"
        - stop
      - else:
        - wait 1t

rob_player_callback:
  type: task
  debug: false
  definitions: target|god
  script:
    - if <[target].location.distance[<player.location>]> < 5:
      - inventory open d:<[target].inventory>
    - narrate "<&c>Your pockets are being searched." targets:<[target]>

rob_local_animation:
  type: task
  debug: false
  definitions: target
  script:
    - animate <player> animation:ARM_SWING

rob_local_callback:
  type: task
  debug: false
  definitions: local
  script:
    - if <[local].has_flag[last_robbed]>:
      - if <[local].flag[last_robbed].from_now.is_less_than[10m]>:
        - narrate "<&e>The local did not have any money."
        - stop
    - define number <util.random_decimal.mul[100].round>
    - if <[number]> < 75:
      - narrate "<&c>You got caught, the Guards have been alerted!!"
      - run guards_report_crime "def:<[local].location>|Local Robbed|<player>"
      - bossbar update timed_action_<player.uuid> title:<&c>Failed! progress:1 color:RED
      - look <[local]> <player.eye_location>
      - playsound sound:entity_villager_no <[local].eye_location> pitch:<util.random_decimal.mul[2]>
      - wait 3s
      - if !<player.has_flag[timed_action]> && <player.bossbar_ids.contains[timed_action_<player.uuid>]>:
        - bossbar remove timed_action_<player.uuid>
      - stop
    - flag <[local]> last_robbed:<util.time_now>
    - narrate "<&e>Succesfully robbed Local"
    - if <[number]> > 97:
      - give item:<item[criminal_shipping_manifest_small]>
    - else:
      - give <item[coin_copper]>