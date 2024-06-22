necklace_test:
  type: task
  debug: false
  data:
    necklace_modifiers:
      bra: string:mermaid_bra
      bra_color: int:<[bra_color]>
      gradient: string:tail_gradient
      gradient_color: int:<[gradient_color]>
      texture: string:<[texture]>
  script:
    - define bra_color 329215
    - define gradient_color 329215
    - define texture moon_rock
    - define texture ursula_shell
    - give mermod_sea_necklace[raw_nbt=<script.parsed_key[data]>]