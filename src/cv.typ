// Imports
#import "./components/header.typ": cv-header
#import "./components/sidebar.typ": cv-sidebar
#import "./components/mainbar.typ": cv-mainbar


#let cv(data, theme, translations) = [

  #set text(font: theme.font, size: theme.font-size)

  #set page(
    paper: "a4",
    margin: (x: 0.8cm, y: 0.8cm),
  )


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

    grid(
      columns: (2fr, 4fr),
      gutter: 0.4cm,

      cv-sidebar(data.sidebar, translations, theme), cv-mainbar(data.mainbar, translations, theme),
    ),
  )
]
