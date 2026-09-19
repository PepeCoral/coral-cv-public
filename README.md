# Pat Patter's Data-Driven CV Generator

> Wait — you work with a *cat*? That's the point. Everything in this repo is **fake**.
> It is a public, git-safe copy of a personal CV pipeline, dressed up as the career
> of **Pat Patter**, a feline software engineer from the Couch Kingdom.

This is a **data-driven CV & cover-letter pipeline** built on [Typst](https://typst.app).
You write your CV once as plain-text data files, and it compiles into pixel-perfect
PDFs — one per persona, language, or target company — either locally or automatically
in CI whenever you push a git tag.

## The cast

| Variant | What it is |
|---|---|
| `variants/webdev/*.typ` | Pat Patter, Feline Software Engineer (EN + ES) |
| `variants/gamedev/*.typ` | Pat Patter, Feline Game Developer (EN + ES) |
| `variants/whiskerworks/*.typ` | A cover letter to the fictional "WhiskerWorks" |

All names, contact details, employers, schools, and projects are invented. Nothing
real lives here — making the repo safe to fork, share, and put on GitHub.

## Quick start

```bash
# Build one CV
typst compile --root . --font-path style/fonts variants/webdev/webdev-en.typ /tmp/cv.pdf

# Build every variant
find variants -type f -name '*.typ' | while read f; do
  typst compile --root . --font-path style/fonts "$f"
done

# Ship everything as a GitHub Release
git tag v1.0 && git push origin v1.0
```

The included GitHub Actions workflow (`release.yaml`) compiles every variant on a
git tag push and attaches all PDFs to a Release.

## Making it yours

1. Replace `data/resources/photo.png` with your own photo (it is a placeholder drawing right now).
2. Edit the three files per persona under `data/<persona>/<lang>/`:
   - `person.toml` — your name, role, location, photo.
   - `sidebar.toml` — contact, education, skill chips, languages, soft skills.
   - `mainbar.toml` — profile blurb, projects, and experience.
3. Add a variant entry point under `variants/` and compile.

Content files are plain TOML, so you get full `#strong[...]`, `#link(...)`, and markup
inline — a 90% Markdown feel with full Typst power.

## Themes

Two palettes ship with the repo:

| Theme | File | Vibe |
|---|---|---|
| `teal` | `style/fonts/teal.typ` | The original, calm teal look |
| `rainbow` | `style/fonts/rainbow.typ` | New pastel-rainbow look (default) |

Switch a variant between them by changing one `#import` line. Themes are Typst
dictionaries, so a variant can also derive from one with a one-line override
(e.g. a smaller font for denser languages).

## Layout

```
data/          CV content as TOML (persona per language)
src/           Reusable Typst layout components (header, sidebar, mainbar, cover)
style/         Themes and bundled Lato font family
translations/  Localized section labels (en / es)
variants/      Entry points: one .typ per output document
assets/        Material Design Icons set used by the header
```

The key idea: **content and layout are separated.** A change to your CV is a few
lines of TOML — diffable, reviewable, and history-able in git — and the same template
renders every persona, language, and cover letter.

## Notes

- `.pdf` outputs are gitignored; the repo stores only the source of truth.
- Everything in this repository is fictional, including the author of the CV.
  If you see your real personal data here, someone shipped a non-demo build.