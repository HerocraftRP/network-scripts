code_stick:
  type: item
  debug: false
  material: stick
  display name: <&6>Entity Stick
  lore:
    - <&6>Set Code<&co><&b> /code_stick_set (script name)
    - <&6>Right Click<&co><&e> Set Code on Entity
    - <&6>Sneak + Right Click<&co><&e> Set Code on Block
    - <&6>Left Click<&co><&e> Check Script on Entity
  flags:
    right_click_script: code_stick_set
    left_click_script: code_stick_check
    on_damage_always: code_stick_check

code_stick_set:
  type: task
  debug: true
  script:
    - determine passively cancelled
    - ratelimit <player> 1t
    - define script <player.flag[entity_stick.script]||null>
    - if <[script]> == null:
      - narrate "<&c>No script selected"
      - narrate "<&b>/entity_stick_set (script name)"
      - stop
    #entity
    - if <context.entity||null> != null:
      - flag <context.entity> right_click_script:<player.flag[entity_stick.script]>
      - flag <context.entity> on_damaged:cancel
      - narrate "<&b><context.entity> was assigned script <[script]>"
    #Block
    - else if <context.location||null> != null:
      - flag <context.location> on_right_click:<player.flag[entity_stick.script]>
      - narrate "<&b><context.location> was assigned script <[script]>"
    #clear
    - if <player.flag[entity_stick.script]> == clear:
    #entity
      - if <context.entity||null> != null:
        - flag <context.entity> right_click_script:!
        - flag <context.entity> on_damaged:!
        - narrate "<&b><context.entity> scripts cleared."
      #Block
      - else if <context.location||null> != null:
        - flag <context.location> on_right_click:!
        - narrate "<&b><context.location> scripts cleared."

code_stick_check:
  type: task
  debug: false
  script:
    - determine passively cancelled
    - ratelimit <player> 1t
    - define script_name <context.entity.flag[right_click_script]||<context.location.flag[on_right_click]||NONE>>
    - if <context.entity.entity_type||<context.location||NONE>> == NONE:
      - stop
    - narrate "<&6><context.entity.entity_type||<context.location>>'s script is currently set to<&co> <&e><[script_name]>"

code_stick_set_script:
  type: command
  debug: false
  name: code_stick_set
  usage: /code_stick_set (script name)
  description: command for attaching scripts to entities
  permissions: herocraft.dev
  script:
    - define script <script[<context.args.get[1]>]||null>
    - if <context.args.get[1]> == clear:
      - flag <player> entity_stick.script:clear
      - narrate "<&6>Code Stick set to remove"
      - stop
    - if <[script]> == null:
      - narrate "<&c>Invalid Script<&co> <&e> <context.args.get[1]>"
      - stop
    - flag <player> entity_stick.script:<[script].name>
    - narrate "<&6>Active script set to: <&e><[script].name>"