no_gamerule:
  type: world
  debug: false
  events:
    on gamerule command:
      - if !<list[Mutim_Endymion|Xeane].contains[<player.name>]>:
        - determine fulfilled