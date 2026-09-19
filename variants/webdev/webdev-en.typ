#import "../../src/cv.typ": cv

#let data = (
  person: toml("../../data/webdev/en/person.toml"),
  sidebar: toml("../../data/webdev/en/sidebar.toml"),
  mainbar: toml("../../data/webdev/en/mainbar.toml"),
)

#let translations = toml("../../translations/en.toml")

#import "../../style/fonts/teal.typ": theme

#cv(data, theme, translations)
