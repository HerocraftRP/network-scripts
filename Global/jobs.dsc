job_data:
  type: data
  data:
    jobs:
      lumberjack:
        category: gathering
        job_shift: day
      mining:
        category: gathering
        job_shift: unlimited
      fishing:
        category: gathering
        job_shift: day
      ranching:
        category: gathering
        job_shift: day
      farming:
        category: gathering
        job_shift: day
      blacksmith:
        category: production
        job_shift: unlimited
      woodwork:
        category: production
        job_shift: day
      tailor:
        category: production
        job_shift: day
      cooking:
        category: production
        job_shift: unlimited
      wizard:
        category: guild
        job_shift: unlimited
      ranger:
        category: guild
        job_shift: unlimited
      warrior:
        category: guild
        job_shift: unlimited
      guard:
        category: guard
        job_shift: unlimited
      mugging:
        category: guard
        job_shift: unlimited
    shifts:
      unlimited:
      - day
      - night
      - dawn
      - dusk
      day:
      - day
      - dawn
      night:
      - night
      - dusk

jobs_initialize_data:
  type: world
  debug: false
  build:
    - flag server job_data:!
    # all jobs
    - foreach <script[job_data].data_key[data.jobs].keys> as:job:
      - flag server job_data.all.<[job]>
    # Reputation Tables for crafting
    - foreach <list[blacksmith|woodwork|tailoring]> as:job:
      - if <script[<[job]>_data].exists>:
        - foreach <script[<[job]>_data].data_key[data.craftables].keys> as:type:
          - define map <map>
          - foreach <script[<[job]>_data].data_key[data.craftables.<[type]>.items].keys> as:material:
            - define map <[map].with[<[material]>].as[<script[<[job]>_data].data_key[data.craftables.<[type]>.items.<[material]>.rep_needed]>]>
          - flag server job_data.reputation_tables.<[job]>.<[type]>:<[map].sort_by_value.invert>
    # Reputation Conflicts between jobs
    - foreach <script[job_data].data_key[data.jobs].keys> as:thisJob:
      - foreach <script[job_data].data_key[data.jobs].keys> as:checkJob:
        - if <[thisJob]> == <[checkJob]>:
          - foreach next
        - if <script[job_data].data_key[data.jobs.<[thisJob]>.category]> == <script[job_data].data_key[data.jobs.<[checkJob]>.category]>:
          - flag server job_data.reputation_conflicts.<[thisJob]>:->:<[checkJob]>
  events:
    after server start:
      - run <script> path:build
    after script reload:
      - run <script> path:build

job_get_rep:
  type: task
  debug: false
  definitions: job|rep
  script:
    - if !<server.flag[job_data.all.<[job]>]||false>:
      - announce to_console "ERROR - INVALID JOB - <[job]>"
      - stop
    - define current_rep <player.flag[job.<[job]>.reputation]||0>
    - flag <player> job.<[job]>.reputation:<[current_rep].add[<[rep]>]>
    - foreach <server.flag[job_data.reputation_conflicts.<[job]>]> as:conflictJob:
      - define newRep <element[0].max[<player.flag[job.<[conflictJob]>.reputation].sub[<[rep]>].if_null[0]>]>
      - flag <player> job.<[conflictJob]>.reputation:<[newRep]>

job_sign_in:
  type: task
  debug: false
  definitions: job
  script:
    - define job <context.entity.flag[job]> if:<[job].exists.not>
    - if <player.has_flag[temp.job]>:
      - if <player.flag[temp.job.name]> == <[job]>:
        - run job_sign_out
      - else:
        - narrate "<&6>You can't work here right now."
    - else:
      - define shift <script[job_data].data_key[data.jobs.<[job]>.job_shift]>
      - if !<script[job_data].data_key[data.shifts.<[shift]>].contains[<player.location.world.time.period>]>:
        - narrate "<&6>You can't work here right now."
        - stop
      - flag player temp.job.name:<[job]>
      - flag server jobs.<[job]>.members:->:<player>
      - narrate "<&6>You are now signed in for <[job]>."

job_sign_in_command:
  type: command
  name: job_sign_in
  debug: false
  description: Not for manual usage
  usage: DON'T
  script:
    - adjust <queue> linked_player:<server.match_player[<context.args.get[2]>]>
    - inventory close
    - run job_sign_in def:<context.args.get[1]>

job_sign_out:
  type: task
  debug: false
  script:
    - narrate "<&6>Signed out of <player.flag[temp.job.name]>"
    - inventory close
    - flag <player> temp.job:!