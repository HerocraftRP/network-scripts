make_a_million_fucking_schematics:
  type: task
  debug: false
  data:
    x_count: 133
    z_count: 156
  script:
    - define xchunk1 <server.flag[transfer_chunks.1].x.sub[50]>
    - define zchunk1 <server.flag[transfer_chunks.1].z.sub[50]>
    - define xchunk2 <server.flag[transfer_chunks.2].x.add[50]>
    - define zchunk2 <server.flag[transfer_chunks.2].z.add[50]>
    - announce to_console <[xchunk1]>,<[zchunk1]>
    - announce to_console <[xchunk2]>,<[zchunk2]>
    - announce to_console "Required X Loop<&co> <[xchunk1].sub[<[xchunk2]>].abs>"
    - announce to_console "Required Z Loop<&co> <[zchunk1].sub[<[zchunk2]>].abs>"
    - repeat <[xchunk1].sub[<[xchunk2]>].abs> as:x:
      - repeat <[zchunk1].sub[<[zchunk2]>].abs> as:z:
        - announce to_console "<[x]>,<[z]> is actually <chunk[<[xchunk1].add[<[x]>]>,<[zchunk1].add[<[z]>]>,<server.worlds.first.name>]>"
        - define final_chunk <chunk[<[xchunk1].add[<[x]>]>,<[zchunk1].add[<[z]>]>,<server.worlds.first.name>]>
        - if !<[final_chunk].is_loaded>:
          - chunkload <[final_chunk]> duration:10s
          - wait 10t
        - schematic create name:<[x]>,<[z]> area:<[final_chunk].cuboid> origin:<[final_chunk].cuboid.center> flags
        - schematic save name:<[x]>,<[z]> filename:global/herocraft/herocraft_<[x]>,<[z]>.schematic
        - schematic unload name:<[x]>,<[z]>
        - wait 1t

paste_a_million_fucking_schematics:
  type: task
  debug: false
  definitions: start_chunk
  script:
    - repeat 133 as:x:
      - repeat 156 as:z:
        - announce to_console "<[x]>,<[z]> is actually <chunk[<[start_chunk].x.add[<[x]>]>,<[start_chunk].z.add[<[z]>]>,<server.worlds.first.name>]>"
        - define final_chunk <chunk[<[start_chunk].x.add[<[x]>]>,<[start_chunk].z.add[<[z]>]>,<server.worlds.first.name>]>
        - if !<[final_chunk].is_loaded>:
          - chunkload <[final_chunk]> duration:10s
          - wait 1s
        - schematic load name:<[x]>,<[z]> filename:global/herocraft/herocraft_<[x]>,<[z]>.schematic
        - wait 10t
        - schematic paste name:<[x]>,<[z]> origin:<[final_chunk].cuboid.center.above[60]>
        - wait 1s
        - schematic unload name:<[x]>,<[z]>