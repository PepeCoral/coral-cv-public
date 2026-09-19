
#let chip(word, theme) = box(
  fill: rgb(theme.chip-color),
  radius: 4pt,
  inset: (x: 8pt, y: 4pt),
  text(size: 9pt, fill: white, weight: "bold")[#word],
)

#let chips(words, theme) = {
  for word in words {
    chip(word, theme)
    h(2pt)
  }
}


#let cv-sidebar(data, translations, theme) = [
  #box(
    fill: rgb(theme.sidebar-color),
    radius: 8pt,
    inset: 16pt,
    width: 100%,
    height: 100%,
  )[
    #show link: set text(fill: rgb(theme.link-color))

    = #translations.contact

    #data.contact.phone

    #v(-0.2cm)

    #for contact_link in data.contact.links [
      #link(contact_link.url)[#contact_link.display]
      \
    ]

    = #translations.education

    #for edu in data.education [
      *#edu.title* \
      #edu.place \
      #text(fill: rgb("#888888"), style: "italic", size: 10pt)[#edu.date]

    ]

    = #translations.skills

    #for skill in data.skills [
      #block[
        #heading(level: 2)[#skill.title]
        #chips(skill.tags, theme)
      ]
    ]

    = #translations.languages

    #for language in data.languages [
      *#language.name* -
      #language.level
      #v(-0.1cm)
    ]

    = #translations.softskills
    #for soft in data.softskills [
      #block[
        - *#soft.name*
      ]
      #v(-0.1cm)
    ]
  ]
]
