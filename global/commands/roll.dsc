roll_entity:
  type: entity
  entity_type: armor_stand
  mechanisms:
    marker: true
    visible: false
    custom_name_visible: true
  flags:
    on_entity_added: remove_context_entity

roll_command:
  type: command
  name: roll
  debug: false
  script:
    - define num1 null
    - if <context.args.size> == 1:
      - if <context.args.get[1].is_integer>:
        - define num1 <context.args.get[1]>
    - define max_num 6
    - if <[num1]> != null:
      - define max_num <[num1]>
    - spawn "roll_entity[custom_name=<&7>Rolled <util.random.int[1].to[<[max_num]>]> out of <[max_num]>]" <player.location.forward[0.4]> save:as
    - wait 5s
    - remove <entry[as].spawned_entity>