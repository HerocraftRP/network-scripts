guidebook_give:
  type: command
  name: guidebook_give
  usage: Nope
  description: don toy uod it white boy
  permission: not.a.perm
  script:
    - adjust <queue> linked_player:<server.match_player[<context.args.get[1]>]>
    - give <server.flag[guide_book]>
    - narrate "<&e>The guide hands you a book."
    - inventory close