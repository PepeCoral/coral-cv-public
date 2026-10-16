// Join a list of strings/content into a single content value using a separator.
#let join(items, sep) = {
  let sep = text(sep)
  let out = text("")
  for (i, item) in items.enumerate() {
    if i > 0 { out += sep }
    out += if type(item) == content { item } else { text(item) }
  }
  out
}

// Whether a dictionary contains a key whose value is present (not none/empty).
#let present(container, key) = {
  if type(container) != dictionary or key not in container { return false }
  let value = container.at(key)
  if value == none { return false }
  if type(value) in ("array", "dictionary") { return value.len() > 0 }
  if type(value) == str { return value.trim() != "" }
  true
}
