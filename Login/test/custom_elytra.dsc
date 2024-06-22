get_colored_elytra:
  type: procedure
  debug: false
  data:
    customizableelytra:customization:
      left:
        id: string:customizableelytra:elytra_wing
        Count: byte:1
        tag:
          RepairCost: int:0
          customizableelytra:customization:
            color: int:<[color1]>
          Damage: int:0
      right:
        id: string:customizableelytra:elytra_wing
        Count: byte:1
        tag:
          RepairCost: int:0
          customizableelytra:customization:
            color: int:<[color2]>
          Damage: int:0
  definitions: color1|color2
  custom_colors:
    pink: 16761035
    brown: 9849600
  script:
    - foreach <[color1]>|<[color2]>:
      - if <script.data_key[custom_colors.<[value]>].exists>:
        - define color<[loop_index]> <script.data_key[custom_colors.<[value]>]>
      - else:
        - define color<[loop_index]> <color[<[value]>].rgb_integer>
    - determine <item[elytra].with[raw_nbt=<script.parsed_key[data]>].with_flag[run_script:cancel]>

cancel:
  type: task
  debug: false
  script:
    - determine cancelled