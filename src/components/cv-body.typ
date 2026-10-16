#import "../utils.typ": join, present

#let section(title, theme, content) = [
  #block[
    #text(size: theme.h3-font-size, weight: "bold", fill: rgb(theme.heading-color))[#title]
    #v(1.5pt)
    #line(length: 100%, stroke: 0.6pt + rgb(theme.heading2-color))
  ]
  #v(2pt)
  #content
  #v(6pt)
]

#let profile(career) = career.profile

#let skills(details) = [
  #for skill in details.skills [
    #if present(skill, "title") [
      #text(weight: "bold")[#skill.title:] \
    ]
    #if present(skill, "tags") [
      #text()[#skill.tags.join(", ")] \
    ]
    #v(2pt)
  ]
]

#let experience(career) = [
  #for exp in career.experiences [
    #grid(
      columns: (1fr, auto),
      align: (left, right),

      [
        #if present(exp, "role") [
          #text(weight: "bold")[#exp.role]
        ]
        #if present(exp, "title") [
          #if present(exp, "role") [#text[ ]]
          #text[— #exp.title]
        ]
      ],

      [
        #if present(exp, "date") [
          #text(fill: rgb("#666666"))[#exp.date]
        ]
      ],
    )
    #v(3pt)

    #if present(exp, "description") [
      #eval(exp.description, mode: "markup")
    ]
    #v(3pt)

    #if present(exp, "bodies") [
      #for body in exp.bodies [
        - #eval(body, mode: "markup")
      ]
    ]

    #v(3pt)
  ]
]

#let projects(career) = [
  #for project in career.projects [
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      [
        #if present(project, "title") [
          #text(weight: "bold")[#project.title]
        ]
        #if present(project, "subtitle") [
          #if present(project, "title") [#text[ ]]
          #text(fill: rgb("#666666"))[— #project.subtitle]
        ]
      ],
      [
        #if present(project, "date") [
          #text(fill: rgb("#666666"))[#project.date]
        ]
      ],
    )
    #v(4pt)
    #if present(project, "bodies") [
      #for body in project.bodies [
        - #eval(body, mode: "markup")
      ]
    ]
    #v(6pt)
  ]
]

#let education(details) = [
  #for edu in details.education [
    #text[
      #if present(edu, "title") [#text(weight: "bold")[#edu.title]]
      #if present(edu, "place") [
        #if present(edu, "title") [, ]
        #edu.place
      ]
      #if present(edu, "date") [
        #text(fill: rgb("#666666"))[ (#edu.date)]
      ]
    ]
    #if present(edu, "description") [
      #edu.description
    ]
    \
  ]
]

#let languages(details) = {
  let parts = ()
  for language in details.languages {
    let part = text(weight: "bold")[#language.name]
    if present(language, "level") {
      part += text(size: 9.5pt)[ (#language.level)]
    }
    parts += (part,)
  }
  join(parts, "  ·  ")
}

#let softskills(details) = {
  let parts = ()
  for skill in details.softskills {
    parts += (text[#skill.name],)
  }
  join(parts, ", ")
}

#let gamejams(career) = [
  #for gamejam in career.gamejams [
    #if present(gamejam, "body") [
      - #eval(gamejam.body, mode: "markup")
    ]
  ]
]

#let cv-body(career, details, translations, theme) = [
  #if present(career, "profile") [
    #section(translations.profile, theme, profile(career))
  ]

  #if present(details, "skills") [
    #section(translations.skills, theme, skills(details))
  ]

  #if present(career, "experiences") [
    #section(translations.experience, theme, experience(career))
  ]

  #if present(career, "projects") [
    #section(translations.projects, theme, projects(career))
  ]

  #if present(details, "education") [
    #section(translations.education, theme, education(details))
  ]

  #if present(details, "languages") [
    #section(translations.languages, theme, languages(details))
  ]

  #if present(details, "softskills") [
    #section(translations.softskills, theme, softskills(details))
  ]

  #if present(career, "gamejams") [
    #section(translations.game_jams, theme, gamejams(career))
  ]
]
