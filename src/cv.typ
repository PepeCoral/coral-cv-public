// Imports
#import "./components/header.typ": header
#import "./components/cv-body.typ": cv-body

#let cv(data, theme, translations) = [

  #set text(font: theme.font, size: theme.font-size)

  #set page(
    paper: "a4",
    margin: (x: 0.65cm, y: 0.6cm),
  )

  #set par(spacing: 2pt, justify: false)

  #show link: underline

  #show link: set text(fill: rgb(theme.link-color))

  #header(data.person, data.at("details", default: (:)).at("contact", default: (:)), theme)
  #cv-body(data.at("career", default: (:)), data.at("details", default: (:)), translations, theme)
]
