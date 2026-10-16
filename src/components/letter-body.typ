#let letter-body(content) = [
  #box(
    radius: 8pt,
    inset: 16pt,
    height: 100%,
    width: 100%,
  )[
    #eval(content, mode: "markup")
  ]
]
