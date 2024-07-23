## List of generic flags for entities to use
# no_damage - no damage taken
# no_fall_damage - negates all damage from falling

## You may append _once to any flag above for it to only negate the next time it applies

# no_fly_kick - disable getting "kicked for flying"

character_entity_flags:
  type: world
  debug: false
  events:
    on entity targets entity_flagged:character.on_target:
        - if <context.target.flag[character.on_target].object_type> == List:
          - foreach <context.target.flag[character.on_target]>:
            - inject <[value]>
        - else:
          - inject <context.target.flag[character.on_target]>
    on player starts sneaking flagged:character.on_sneak:
        - if <player.flag[character.on_sneak].object_type> == List:
          - foreach <player.flag[character.on_sneak]>:
            - inject <[value]>
        - else:
          - inject <player.flag[character.on_sneak]>
    on player right clicks entity_flagged:character.right_click_script:
      - if <context.entity.flag[character.right_click_script].object_type> == List:
        - foreach <context.entity.flag[character.right_click_script]>:
          - inject <[value]>
      - else:
        - inject <context.entity.flag[character.right_click_script]>
    on entity_flagged:character.on_dismount exits vehicle:
      - if <context.entity.flag[character.on_dismount].object_type> == List:
        - foreach <context.entity.flag[character.on_dismount]>:
          - inject <[value]>
      - else:
        - inject <context.entity.flag[character.on_dismount]>
    on entity_flagged:character.on_damaged damaged bukkit_priority:low:
      - if <context.entity.flag[character.on_damaged].object_type> == List:
        - foreach <context.entity.flag[character.on_damaged]>:
          - inject <[value]>
      - else:
        - inject <context.entity.flag[character.on_damaged]>
    on modded entity_flagged:character.on_hurt hurt:
      - if <context.entity.flag[character.on_damaged].object_type> == List:
        - foreach <context.entity.flag[character.on_damaged]>:
          - inject <[value]>
      - else:
        - inject <context.entity.flag[character.on_damaged]>
    on entity_flagged:character.on_damaging damages entity bukkit_priority:low:
      - if <context.entity.flag[character.on_damaging].object_type> == List:
        - foreach <context.entity.flag[character.on_damaging]>:
          - inject <[value]>
      - else:
        - inject <context.entity.flag[character.on_damaging]>
    on entity_flagged:character.on_death dies bukkit_priority:low:
      - if <context.entity.flag[character.on_death].object_type> == List:
        - foreach <context.entity.flag[character.on_death]>:
          - inject <[value]>
      - else:
        - inject <context.entity.flag[character.on_death]>
    on modded player dies flagged:character.on_modded_death bukkit_priority:low:
      - if <context.entity.flag[character.on_modded_death].object_type> == List:
        - foreach <context.entity.flag[character.on_modded_death]>:
          - inject <[value]>
      - else:
        - inject <context.entity.flag[character.on_modded_death]>
    on entity_flagged:character.on_break breaks block bukkit_priority:low:
      - if <context.hanging.flag[character.on_break].object_type> == List:
        - foreach <context.hanging.flag[character.on_break]>:
          - inject <[value]>
      - else:
        - inject <context.hanging.flag[character.on_break]>
    on entity_flagged:character.on_hunger_change changes food level bukkit_priority:low:
      - if <context.entity.flag[character.on_hunger_change].object_type> == List:
        - foreach <context.entity.flag[character.on_hunger_change]>:
          - inject <[value]>
      - else:
        - inject <context.entity.flag[character.on_hunger_change]>
    on entity_flagged:character.on_shoots_bow shoots bow bukkit_priority:low:
      - if <context.entity.flag[character.on_shoots_bow].object_type> == List:
        - foreach <context.entity.flag[character.on_shoots_bow]>:
          - inject <[value]>
      - else:
        - inject <context.entity.flag[character.on_shoots_bow]>
    on player starts flying bukkit_priority:low flagged:character.on_start_flying:
      - if <player.flag[character.on_start_flying].object_type> == List:
        - foreach <player.flag[character.on_start_flying]>:
          - inject <[value]>
      - else:
        - inject <player.flag[character.on_start_flying]>
    on player stops flying bukkit_priority:low flagged:character.on_stops_flying:
      - if <player.flag[character.on_stops_flying].object_type> == List:
        - foreach <player.flag[character.on_stops_flying]>:
          - inject <[value]>
      - else:
        - inject <player.flag[character.on_stops_flying]>
    on player kicked flagged:character.on_kick:
      - if <player.flag[character.on_kick].object_type> == List:
        - foreach <player.flag[character.on_kick]>:
          - inject <[value]>
      - else:
        - inject <player.flag[character.on_kick]>
    on entity_flagged:character.on_teleport teleports:
      - if <context.entity.flag[character.on_teleport].object_type> == List:
        - foreach <context.entity.flag[character.on_teleport]>:
          - inject <[value]>
      - else:
        - inject <context.entity.flag[character.on_teleport]>
    on player walks flagged:character.on_move:
      - if <player.flag[character.on_move].object_type> == List:
        - foreach <player.flag[character.on_move]>:
          - inject <[value]>
      - else:
        - inject <player.flag[character.on_move]>
    on player quits flagged:character.on_quit:
      - if <player.flag[character.on_quit].object_type> == List:
        - foreach <player.flag[character.on_quit]>:
          - inject <[value]>
      - else:
        - inject <player.flag[character.on_quit]>
    on player joins:
      - wait 3s
      - stop if:<player.is_online.not>
      - if <player.has_flag[character.on_join]>:
        - if <player.flag[character.on_join].object_type> == List:
          - foreach <player.flag[character.on_join]>:
            - inject <[value]>
        - else:
            - inject <player.flag[character.on_join]>
    on entity_flagged:character.on_drops_item drops item:
      - if <context.dropped_by.flag[character.on_drops_item].object_type> == List:
        - foreach <context.dropped_by.flag[character.on_drops_item]>:
          - inject <[value]>
      - else:
        - inject <context.dropped_by.flag[character.on_drops_item]>
      