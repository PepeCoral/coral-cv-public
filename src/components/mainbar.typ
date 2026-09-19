#let cv-mainbar(data, translations, theme) = [
  #box(
    fill: rgb(theme.mainbar-color),
    radius: 8pt,
    inset: 16pt,
    height: 100%,
    width: 100%,
  )[
    = #translations.profile
    #data.profile

    = #translations.projects
    #for project in data.projects [

      #grid(
        columns: (1fr, auto),
        align: left + horizon,
        [
          == #project.title
        ],

        [
          #text(fill: rgb("#888888"), style: "italic", size: 10pt)[#project.subtitle]
        ],
      )

      #eval(project.body, mode: "markup")


    ]

    = #translations.experience
    #for experience in data.experiences [

      == #experience.role

      #grid(
        columns: (1fr, auto),
        align: left + horizon,
        [
          === #experience.title
        ],

        [
          #text(fill: rgb("#888888"), style: "italic", size: 10pt)[#experience.date]
        ],
      )

      #for body in experience.bodies [
        - #eval(body, mode: "markup")
      ]



    ]

    #if "gamejams" in data [
      = #translations.game_jams
      #for gamejam in data.gamejams [
        - #eval(gamejam.body, mode: "markup")
      ]
    ]
  ]
]
