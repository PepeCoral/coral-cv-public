// Imports
#import "./components/header.typ": header
#import "./components/letter-body.typ": letter-body


#let cover(data, content, theme) = [

  #set text(font: theme.font, size: theme.font-size)

  #set page(
    paper: "a4",
    margin: (x: 0.8cm, y: 0.8cm),
  )


  #grid(
    rows: (auto, 1fr),
    columns: 1fr,
    gutter: 0.4cm,

    header(data.person, data.at("details", default: (:)).at("contact", default: (:)), theme),
    letter-body(content.at("body", default: (:)).at("text", default: ""))
  )
]
