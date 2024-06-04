cooking_placeable:
  type: task
  debug: false
  data:
    list:
      farmersdelight_sweet_berry_cheesecake: true
      cake: true
  script:
    - if <script.data_key[data.list.<player.item_in_hand.material.name>].exists>:
      - modifyblock <context.location.above> <player.item_in_hand.material.name>
      - take iteminhand