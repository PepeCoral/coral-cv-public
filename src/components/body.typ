#let body(text, theme) = [
  #box(
    fill: rgb(theme.mainbar-color),
    radius: 8pt,
    inset: 16pt,
    height: 100%,
    width: 100%,
  )[

    #eval(text, mode: "markup")
  ]
]
