make_a_million_fucking_schematics:
  type: task
  debug: false
  data:
    x_count: 73
    z_count: 96
  script:
    - define xchunk1 <server.flag[transfer_chunks.1].chunk.x>
    - define zchunk1 <server.flag[transfer_chunks.1].chunk.z>
    - define xchunk2 <server.flag[transfer_chunks.2].chunk.x>
    - define zchunk2 <server.flag[transfer_chunks.2].chunk.z>
    - announce to_console <[xchunk1]>,<[zchunk1]>
    - announce to_console <[xchunk2]>,<[zchunk2]>
    - announce to_console "Required X Loop<&co> <[xchunk1].sub[<[xchunk2]>].abs>"
    - announce to_console "Required Z Loop<&co> <[zchunk1].sub[<[zchunk2]>].abs>"
    - repeat <[xchunk1].sub[<[xchunk2]>].abs> as:x:
      - repeat <[zchunk1].sub[<[zchunk2]>].abs> as:z:
        - announce to_console "<[x]>,<[z]> is actually <chunk[<[xchunk1].add[<[x]>].round_down>,<[zchunk1].add[<[z]>].round_down>,<server.worlds.first.name>]>"
        - define final_chunk <chunk[<[xchunk1].add[<[x]>].round_down>,<[zchunk1].add[<[z]>].round_down>,<server.worlds.first.name>]>
        - if !<[final_chunk].is_loaded>:
          - chunkload <[final_chunk]> duration:10s
          - wait 10t
        - schematic create name:<[x]>,<[z]> area:<[final_chunk].cuboid> origin:<[final_chunk].cuboid.center>
        - wait 1t
        - define new_location <[final_chunk].cuboid.center.add[1000000,0,1000000]>
        - if !<[new_location].chunk.is_loaded>:
          - chunkload <[new_location].chunk> duration:10s
          - wait 10t
        - schematic paste name:<[x]>,<[z]> origin:<[new_location]>
        - schematic unload name:<[x]>,<[z]>
        - announce to_console "Pasted To Chunk <[x]>,<[z]> - Location<&co> <[new_location]> FROM <[final_chunk].cuboid.center>"
        - wait 1t

transfer_a_million_biomes:
  type: task
  debug: false
  data:
    x_count: 73
    z_count: 96
  script:
    - define xchunk1 <server.flag[transfer_chunks.1].chunk.x>
    - define zchunk1 <server.flag[transfer_chunks.1].chunk.z>
    - define xchunk2 <server.flag[transfer_chunks.2].chunk.x>
    - define zchunk2 <server.flag[transfer_chunks.2].chunk.z>
    - announce to_console <[xchunk1]>,<[zchunk1]>
    - announce to_console <[xchunk2]>,<[zchunk2]>
    - announce to_console "Required X Loop<&co> <[xchunk1].sub[<[xchunk2]>].abs>"
    - announce to_console "Required Z Loop<&co> <[zchunk1].sub[<[zchunk2]>].abs>"
    - announce to_console "ETA<&co> <[xchunk1].sub[<[xchunk2]>].abs.mul[<[zchunk1].sub[<[zchunk2]>].abs>].mul[6128].div[100].div[20]> seconds"
    - repeat <[xchunk1].sub[<[xchunk2]>].abs> as:x:
      - repeat <[zchunk1].sub[<[zchunk2]>].abs> as:z:
        - define final_chunk <chunk[<[xchunk1].add[<[x]>].round_down>,<[zchunk1].add[<[z]>].round_down>,<server.worlds.first.name>]>
        - define mirror_chunk <[final_chunk].cuboid.center.add[-100000,0,-100000].chunk>
        - chunkload <[final_chunk]> duration:1m
        - chunkload <[mirror_chunk]> duration:1m
        - foreach <[final_chunk].cuboid.blocks> as:block:
          - adjust <[block].center.add[-100000,0,-100000]> biome:<[block].biome>
          - wait 1t if:<[loop_index].mod[1000].equals[0]>


paste_a_million_fucking_schematics:
  type: task
  debug: false
  definitions: start_chunk
  script:
    - repeat 73 as:x:
      - repeat 96 as:z:
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

teleport_me_a_million_chunks:
  type: task
  debug: false
  script:
    - define xchunk1 <server.flag[transfer_chunks.1].chunk.x>
    - define zchunk1 <server.flag[transfer_chunks.1].chunk.z>
    - define xchunk2 <server.flag[transfer_chunks.2].chunk.x>
    - define zchunk2 <server.flag[transfer_chunks.2].chunk.z>
    - repeat <[xchunk1].sub[<[xchunk2]>].abs> as:x:
      - repeat <[zchunk1].sub[<[zchunk2]>].abs> as:z:
        - define chunk <chunk[<[xchunk1].add[<[x]>].round_down>,<[zchunk1].add[<[z]>].round_down>,<server.worlds.first.name>]>
        - if !<[chunk].is_loaded>:
          - chunkload <[chunk]> duration:10s
          - wait 10t
        - teleport <player> <[chunk].cuboid.center.add[-100000,100,-100000].highest.above[10]>
        - wait 5t

kill_queues:
  type: task
  debug: false
  script:
    - foreach <util.queues>:
      - if <[value]> != <queue>:
        - queue <[value]> stop