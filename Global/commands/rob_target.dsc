rob_target:
  type: command
  name: rob_target
  debug: false
  usage: /rob_target
  description: Rob your target.... duh.
  script:
    - ratelimit <player> 1s
    - define target <player.precise_target[3]||null>
    - if <[target]> == null:
      - narrate "<&c>You have no target."
      - stop
    - if <[target].has_flag[on_robbed]>:
      - inject <[target].flag[on_robbed]>
    - if <[target].entity_type> == VILLAGER:
      - run start_timed_action "def:<&c>Robbing Villager|10s|rob_local_callback|<[target]>" def.can_move:false def.animation_task:rob_local_animation

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
    - if <util.random_chance[75]>:
      - narrate "<&c>You got caught, the Guards have been alerted!!"
      - bossbar update timed_action_<player.uuid> title:<&c>Failed! progress:1 color:RED
      - look <[local]> <player.eye_location>
      - playsound sound:entity_villager_no <[local].eye_location> pitch:<util.random_decimal.mul[2]>
      - wait 3s
      - if !<player.has_flag[timed_action]> && <player.bossbar_ids.contains[timed_action_<player.uuid>]>:
        - bossbar remove timed_action_<player.uuid>
      - stop
    - flag <[local]> last_robbed:<util.time_now>
    - run job_get_rep def:mugging|0.1
    - narrate "<&e>Succesfully robbed Local"
    - if <util.random_chance[1]>:
      - give item:<item[criminal_shipping_manifest_small]>
    - else:
      - give <item[coin_copper]>