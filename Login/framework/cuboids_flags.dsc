cuboid_flags:
  type: world
  debug: false
  events:
    on player enters area_flagged:player_enters:
      - if <context.area.flag[player_enters].object_type> == List:
        - foreach <context.area.flag[player_enters]>:
          - inject <[value]>
      - else:
        - inject <context.area.flag[player_enters]>
    on player exits area_flagged:player_leaves:
      - if <context.area.flag[player_leaves].object_type> == List:
        - foreach <context.area.flag[player_leaves]>:
          - inject <[value]>
      - else:
        - inject <context.area.flag[player_leaves]>
    on player right clicks block in:area_flagged:on_right_click bukkit_priority:LOW:
      - foreach <player.location.cuboids[area_flagged:on_right_click]> as:cuboid:
        - if <[cuboid].flag[on_right_click].object_type> == List:
          - foreach <[cuboid].flag[on_right_click]>:
            - inject <[value]>
        - else:
          - inject <[cuboid].flag[on_right_click]>
    on player casts spell in:area_flagged:on_spell_cast bukkit_priority:LOW:
      - foreach <player.location.cuboids[area_flagged:on_spell_cast]> as:cuboid:
        - if <[cuboid].flag[on_spell_cast].object_type> == List:
          - foreach <[cuboid].flag[on_spell_cast]>:
            - inject <[value]>
        - else:
          - inject <[cuboid].flag[on_spell_cast]>