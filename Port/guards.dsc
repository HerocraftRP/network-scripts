guard_sentence_player:
  type: command
  debug: false
  name: sentence
  description: Sentence townsmen to jail
  usage: /sentence (cell#) (months) (fine)
  permissions: herocraft.guard
  tab completions:
    1: cell#
    2: months
    3: fine
  script:
    - if <context.args.size> != 3:
      - narrate "<&c>Incorrect amount of arguments!"
      - narrate "/sentence (cell#) (months) (fine)"
      - stop
    - foreach <context.args>:
      - if !<[value].is_integer>:
        - narrate "<&c>Invalid input for argument <[loop_index]>: <&e><[value]>"
        - stop
    - if <context.args.get[1]> > 3 || <context.args.get[1]> < 1:
      - narrate "<&c>Invalid Cell Number: <context.args.get[1]>"
      - stop
    - define criminals <cuboid[cell_<context.args.get[1]>].players>
    - foreach <[criminals]> as:criminal:
      - run guard_take_money def:<context.args.get[3]> player:<[criminal]>
      - flag <[criminal]> jail.time.start:<util.time_now>
      - flag <[criminal]> jail.time.end:<util.time_now.add[<context.args.get[2]>m]>
      - teleport <[criminal]> prison

guard_take_money:
  type: task
  debug: false
  definitions: takeAmount
  data:
    Currency:
      Amount: long<&co><[newAmount]>
  script:
    - define wallet <player.curios.items.get[wallet]>
    - define amount <[wallet].raw_nbt.get[Currency].get[Amount].after[<&co>]>
    - define newAmount <[amount].sub[<[takeAmount]>]>
    - if <[newAmount]> < 0:
      - flag <player> city.debt:<[newAmount].abs>
      - define newAmount 0
    - adjust <player> curios_item:wallet|<[wallet].with[raw_nbt=<script.parsed_key[data]>]>