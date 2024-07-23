placeable_torchflower:
  type: item
  debug: false
  material: torchflower_seeds
  display name: <&6>Torchflower Seeds
  flags:
    right_click_script: custom_placeable
  data:
    tick_timer: 30m
    placed_material: torchflower_crop
    can_place_on:
    - dirt
    - grass_block
    persist_between_storms: false
    scripts:
        on_place:
          - narrate "<&6>Placed!"
        on_break:
          - narrate "<&c>Broken!"
        interact:
          - if <[location].material.name> == torchflower:
            - run start_timed_action "def:<&6>Harvesting Torchflower|8s|placeable_torchflower_harvest|<[location]>" def.can_move:false
          - else:
            - if <[location].material.age> == 1:
              - narrate "<&e>I think this has at most 30 minutes left to grow."
            - else:
              - narrate "<&e>I think this has at most 60 minutes left to grow."
        tick:
          - if <[location].material.name> == torchflower:
            - stop
          - if <[location].material.age> == 1:
            - modifyblock <[location]> torchflower no_physics
          - else:
            - adjustblock <[location]> age:1

placeable_torchflower_harvest:
  type: task
  debug: false
  definitions: location
  script:
    - if <[location].material.name> == torchflower:
      - narrate "<&e>You successfully harvested the Torchflower."
      - give torchflower
      - run clear_custom_placeable def:<[location]>
    - else:
      - narrate "<&c>Someone else harvested this first."