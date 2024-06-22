item_flags:
  type: world
  debug: false
  events:
    on player clicks item_flagged:run_script in inventory bukkit_priority:LOWEST:
      - if <context.item.flag[run_script].object_type> == List:
        - foreach <context.item.flag[run_script]>:
          - inject <[value]>
      - else:
        - inject <context.item.flag[run_script]>
    on player clicks item_flagged:cancelled in inventory bukkit_priority:LOWEST:
      - determine cancelled
    on player drops item_flagged:no_drop bukkit_priority:LOWEST:
      - determine cancelled
    on player drops item_flagged:on_drop bukkit_priority:LOWEST:
      - if <context.item.flag[on_drop].object_type> == List:
        - foreach <context.item.flag[on_drop]>:
          - inject <[value]>
      - else:
        - inject <context.item.flag[on_drop]>
    on player dies:
      - determine <context.drops.filter[has_flag[no_drop_on_death].not]>
    on player right clicks block with:item_flagged:right_click_script bukkit_priority:LOW ignorecancelled:true:
      - if <context.item.flag[right_click_script].object_type> == List:
        - foreach <context.item.flag[right_click_script]>:
          - inject <[value]>
      - else:
        - inject <context.item.flag[right_click_script]>
    on player right clicks entity with:item_flagged:right_click_script bukkit_priority:LOW:
      - if <context.item.flag[right_click_script].object_type> == List:
        - foreach <context.item.flag[right_click_script]>:
          - inject <[value]>
      - else:
        - inject <context.item.flag[right_click_script]>
    on player left clicks block with:item_flagged:left_click_script:
      - if <context.item.flag[left_click_script].object_type> == List:
        - foreach <context.item.flag[left_click_script]>:
          - inject <[value]>
      - else:
        - inject <context.item.flag[left_click_script]>
    on entity damages entity with:item_flagged:on_damage bukkit_priority:HIGHEST:
      - if <context.damager.item_in_hand.flag[on_damage].object_type> == List:
        - foreach <context.damager.item_in_hand.flag[on_damage]>:
          - inject <[value]>
      - else:
        - inject <context.damager.item_in_hand.flag[on_damage]>
    on entity damages entity with:item_flagged:on_damage_always ignorecancelled:true:
      - if <context.damager.item_in_hand.flag[on_damage_always].object_type> == List:
        - foreach <context.damager.item_in_hand.flag[on_damage_always]>:
          - inject <[value]>
      - else:
        - inject <context.damager.item_in_hand.flag[on_damage_always]>
    on entity_flagged:on_projectile_hits hits:
      - if <context.projectile.flag[on_projectile_hits].object_type> == List:
        - foreach <context.projectile.flag[on_projectile_hits]>:
          - inject <[value]>
      - else:
        - inject <context.projectile.flag[on_projectile_hits]>
    on entity_flagged:on_projectile_launched launched:
      - if <context.projectile.flag[on_projectile_launched].object_type> == List:
        - foreach <context.projectile.flag[on_projectile_launched]>:
          - inject <[value]>
      - else:
        - inject <context.projectile.flag[on_projectile_launched]>
    on inventory picks up item_flagged:on_item_pickup_inventory:
      - if <context.item.flag[on_item_pickup_inventory].object_type> == List:
        - foreach <context.item.flag[on_item_pickup_inventory]>:
          - inject <[value]>
      - else:
        - inject <context.item.flag[on_item_pickup_inventory]>
    on dropped_item added to world:
      - if <context.entity.item.has_flag[on_item_drop]>:
        - if <context.entity.item.flag[on_item_drop].object_type> == List:
          - foreach <context.entity.item.flag[on_item_drop]>:
            - inject <[value]>
        - else:
          - inject <context.entity.item.flag[on_item_drop]>
    on entity shoots item_flagged:on_item_shot:
      - if <context.bow.flag[on_item_shot].object_type> == List:
        - foreach <context.bow.flag[on_item_shot]>:
          - inject <[value]>
      - else:
        - inject <context.bow.flag[on_item_shot]>
    on entity shoots bow:
      - if <context.item.has_flag[on_shot]>:
        - inject <context.item.flag[on_shot]>
    on player equips item_flagged:on_equip:
      - if <context.new_item.flag[on_equip].object_type> == List:
        - foreach <context.new_item.flag[on_equip]>:
          - inject <[value]>
      - else:
        - inject <context.new_item.flag[on_equip]>
    on player unequips item_flagged:on_unequip:
      - if <context.old_item.flag[on_unequip].object_type> == List:
        - foreach <context.old_item.flag[on_unequip]>:
          - inject <[value]>
      - else:
        - inject <context.old_item.flag[on_unequip]>
    on player crafts item_flagged:on_craft:
      - if <context.item.flag[on_craft].object_type> == List:
        - foreach <context.item.flag[on_craft]>:
          - inject <[value]>
      - else:
        - inject <context.item.flag[on_craft]>
    on item_flagged:on_recipe_formed recipe formed:
      - if <context.item.flag[on_recipe_formed].object_type> == List:
        - foreach <context.item.flag[on_recipe_formed]>:
          - inject <[value]>
      - else:
        - inject <context.item.flag[on_recipe_formed]>
    on player places item_flagged:on_place ignorecancelled:true:
      - if <context.item_in_hand.flag[on_place].object_type> == List:
        - foreach <context.item_in_hand.flag[on_place]>:
          - inject <[value]>
      - else:
        - inject <context.item_in_hand.flag[on_place]>
    on player right clicks entity with:item_flagged:right_click_entity:
      - if <context.item.flag[right_click_entity].object_type> == List:
        - foreach <context.item.flag[right_click_entity]>:
          - inject <[value]>
      - else:
        - inject <context.item.flag[right_click_entity]>
    on player consumes item_flagged:on_consume:
      - if <context.item.flag[on_consume].object_type> == List:
        - foreach <context.item.flag[on_consume]>:
          - inject <[value]>
      - else:
        - inject <context.item.flag[on_consume]>