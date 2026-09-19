// Imports
#import "./components/header.typ": cv-header
#import "./components/body.typ": body


#let cover(data, theme) = [

  #set text(font: theme.font, size: theme.font-size)

  #set page(
    paper: "a4",
    margin: (x: 0.8cm, y: 0.8cm),
  )

  #set par(spacing: 2em)

  #show heading.where(level: 1): set text(
    fill: rgb(theme.heading-color),
    size: theme.h1-font-size,
  )

  #show heading.where(level: 2): set text(
    fill: rgb(theme.heading2-color),
    size: theme.h2-font-size,
  )

  #show heading.where(level: 3): set text(
    fill: rgb(theme.heading2-color),
    size: theme.h3-font-size,
  )



  #grid(
    rows: (auto, 1fr),
    columns: 1fr,
    gutter: 0.4cm,

    cv-header(data.person, theme),
    body(data.body.text, theme)
  )
]
