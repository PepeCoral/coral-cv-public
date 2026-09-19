#let data = toml("./whiskerworks.toml")

#import "../../style/fonts/rainbow.typ": theme

#let overriden-theme = (..theme, font-size: 11pt)

#import "../../src/cover.typ": cover

#cover(data, overriden-theme)