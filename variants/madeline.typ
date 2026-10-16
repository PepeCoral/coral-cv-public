#import "../src/cv.typ": cv

#let data = (
  person: toml("../data/madeline/person.toml"),
  details: toml("../data/madeline/details.toml"),
  career: toml("../data/madeline/career.toml"),
)

#let translations = toml("../translations/en.toml")

#import "../style/themes/teal.typ": theme

#let overriden-theme = (..theme, font-size: 9pt)

#cv(data, overriden-theme, translations)
