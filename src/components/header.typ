#import "@preview/iconify:0.5.3": icon, provide-icons


#let cv-header(person, theme) = [
  #provide-icons(json("../../assets/mdi.json"))

  #box(fill: rgb(theme.header-color), radius: 8pt, inset: 16pt, width: 100%)[
    #grid(
      columns: (1fr, 80pt),
      align: (left, center),

      [
        #align(left + horizon)[
          #text(size: 26pt, weight: "bold", fill: rgb(theme.header-h1-color))[#person.name]
          \
          #text(size: 14pt, weight: "bold", fill: rgb(theme.header-h2-color))[#person.role]
          \
          #v(0pt)
          #if "location" in person [
            #text(size: 10pt, weight: "bold", fill: rgb(
              theme.header-h2-color,
            ))[#icon("mdi:location", y: -0.2em, width: 1.1em) #person.location]]
        ]
      ],

      [
        #if "photo" in person [
          #box(
            width: 72pt,
            height: 72pt,
            radius: 50%,
            stroke: 2pt + rgb(theme.heading2-color),
            clip: true,
          )[
            #image(
              person.photo,
              width: 72pt,
              height: 72pt,
              fit: "cover",
            )
          ]
        ]
      ],
    )
  ]
]
