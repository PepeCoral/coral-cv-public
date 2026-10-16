#import "../utils.typ": join, present

#let contact_parts(contact) = {
  let parts = ()
  if present(contact, "phone") {
    parts += (contact.phone,)
  }
  if present(contact, "links") {
    for item in contact.links {
      parts += (link(item.url)[#item.display],)
    }
  }
  parts
}

#let header(person, contact, theme) = [
  #align(center)[
    #text(size: theme.h1-font-size, weight: "bold", fill: rgb(theme.heading-color))[#person.name]
    #if present(person, "role") [
      \
      #text(size: theme.h2-font-size, weight: "bold", fill: rgb(theme.heading2-color))[#person.role]
    ]
    #if present(person, "location") [
      \
      #text(size: theme.h3-font-size, weight: "bold", fill: rgb("#555555"))[#person.location]
    ]
  ]

  #let parts = contact_parts(contact)
  #if parts.len() > 0 [
    #v(3pt)
    #align(center)[
      #set text(fill: rgb("#333333"))
      #join(parts, " · ")
    ]
  ]

  #v(4pt)
]
