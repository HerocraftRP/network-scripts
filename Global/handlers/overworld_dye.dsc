dye_gathering:
  type: data
  materials:
    poppy: red
    dandelion: yellow
    lily_of_the_valley: white
    cornflower: blue
    allium: pink
    blue_orchid: blue
    orange_tulip: orange
    lilac: purple

overworld_gather_dye:
  type: task
  debug: false
  script:
    - if !<player.is_sneaking>:
      - narrate "<&c>You must bend down to extract the dye from this."
      - stop
    - run start_timed_action "def:<&e>Extracting Dye|8s|overworld_gather_dye_callback|<context.location>" def.distance_from_origin:2 def.must_stay_sneak:true

overworld_gather_dye_callback:
  type: task
  debug: false
  definitions: passthrough
  script:
    - define material <[passthrough].material.name>
    - give item:<script[dye_gathering].data_key[materials.<[material]>]>_dye