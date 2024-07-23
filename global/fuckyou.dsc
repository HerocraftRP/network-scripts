fuck_you:
  type: world
  debug: false
  enabled: false
  events:
    on player right clicks block bukkit_priority:HIGHEST:
      - if !<player.has_flag[clicks]>:
        - flag <player> clicks.last:<util.time_now>
        - flag <player> clicks.count:1
        - stop
      - if <player.flag[clicks.last].from_now.is_less_than[4t]>:
        - if <player.flag[clicks.count]> > 1:
          - kick <player> "reason:Attempting to break the server by spam clicking. Admins have been notified."
          - run send_to_discord "def:<player.name> was kicked for trying to spam click, and bypass server protections"
        - flag <player> clicks.count:<player.flag[clicks.count].add[1]>
      - else:
        - flag <player> clicks.count:0
      - flag <player> clicks.last:<util.time_now>