# How This Project Works

A **data-driven CV & cover-letter pipeline** built on [Typst](https://typst.app). Content is written once in plain-text data files, and compiled into pixel-perfect PDFs — one per target persona, language, or company — either locally or automatically in CI on a git tag.

```
      data/        ------------------>   src/ layout
   (TOML content)     imported by          (reusable templates)
        |                                    |
        |  variants/*.typ (entry points)     |
        +------------------------------------+
                         |
                         v
                typst compile
                         |
                         v
                    PDF output
                         |
                         v (optionally, via GitHub Actions)
               GitHub Release with all PDFs
```

---

## Core idea: separate *content* from *presentation*

The whole design rests on a single principle: **the CV text is data, not layout.**

Traditional CV management keeps content and layout welded together inside a `.docx` binary. Every change to a fact updates the layout; every change to the layout risks breaking the content. This repo splits them:

| Layer | Role | Where it lives |
|---|---|---|
| **Data** | *What* is said (profile, projects, jobs, skills, contact) | `data/**/*.toml` |
| **Template** | *How* it looks (header, sidebar, mainbar, theme) | `src/**/*.typ`, `style/**` |
| **Variant** | *Which* combination of data + template + language is rendered | `variants/**/*.typ` |
| **Translation** | Section labels per language | `translations/*.toml` |

---

## Directory structure

```
coral-cv/
├── data/                      # CV content, as TOML
│   ├── webdev/{en,es}/        #   person.toml, sidebar.toml, mainbar.toml
│   ├── gamedev/{en,es}/       #
│   └── resources/photo.png    # profile photo (shared)
├── variants/                  # entry points: one .typ per document
│   ├── webdev/webdev-en.typ   #   -> webdev-en.pdf
│   ├── gamedev/gamedev-en.typ #   -> gamedev-en.pdf
│   └── whiskerworks/*.typ     #   -> whiskerworks-cover.pdf
├── src/                       # reusable layout components
│   ├── cv.typ                 #   full-page CV layout
│   ├── cover.typ              #   cover-letter layout
│   └── components/            #   header / sidebar / mainbar / body
├── style/fonts/{teal,rainbow}.typ   # color & typography themes
├── translations/{en,es}.toml  # localized section headers
├── assets/mdi.json            # Material Design Icons set
└── .github/workflows/release.yaml   # CI build + release
```

The repo also packages the [Lato](https://fonts.google.com/specimen/Lato) font family locally (`style/fonts/Lato/`) so builds are reproducible without network access.

---

## How the pieces fit together

### 1. Content lives in TOML files

Each persona has three data files:

- **`person.toml`** — `name`, `role`, `location`, photo. The header component treats `location` and photo as optional so they can be toggled per variant.

- **`sidebar.toml`** — contact links, education, skills (rendered as chips), languages, soft skills. Straightforward, but the interesting part is that this is a *parsed structure*, not fixed text.

- **`mainbar.toml`** — the narrative part: `profile` blurb, `projects`, and `experiences`. Because Typst accepts **full markup inside TOML strings**, emphasis is expressible inline:

  ```toml
  [[projects]]
  title = "Radiant"
  body  = "Led the development of a ... #strong[17 engineers] and ..."
  ```

  Inline `#strong[...]`, `#link(...)`, and `#smallcaps(...)`-style markup can be embedded directly in the data string and is interpreted at compile time. This gives a 90% HTML/Markdown feel while keeping everything in plain text.

### 2. Variants compose data + template + theme + language

A variant is a tiny entry-point file — nothing but assembly:

```typst
#import "../../src/cv.typ": cv

#let data = (
  person:   toml("../../data/webdev/en/person.toml"),
  sidebar:  toml("../../data/webdev/en/sidebar.toml"),
  mainbar:  toml("../../data/webdev/en/mainbar.toml"),
)
#let translations = toml("../../translations/en.toml")
#import "../../style/fonts/rainbow.typ": theme

#cv(data, theme, translations)
```

Compile it and `webdev-en.pdf` appears. The same template, with different imports, yields the Spanish version, the game-dev version, a made-up company's cover letter, or anything else you can point data at. New variants are **declarative additions**, not code changes.

Because themes are Typst dictionaries, a variant can also *derive* from the base theme with a one-line override (e.g. a smaller body font for a language that typesets longer):

```typst
#let esTheme = (..theme, font-size: 10pt)
```

### 3. One shared template, parameterized

`src/cv.typ` defines the overall layout once: A4, 0.8cm margins, heading styles bound to the theme, then a grid — header on top, two columns below (`sidebar` at 2fr, `mainbar` at 4fr). The components (`header.typ`, `sidebar.typ`, `mainbar.typ`) receive `data`, `theme`, and `translations` and render the sections. Section labels come from the translation layer (`translations/en.toml` vs `es.toml`), so no text is hard-coded in the template.

`src/cover.typ` reuses the same header component for cover letters, feeding on a `body.typ` text container.

### 4. The build

Compiling is a one-liner:

```bash
typst compile --root . --font-path style/fonts variants/webdev/webdev-en.typ out.pdf
```

`--root` sets the reasoning base for `toml(...)` and image paths so all variants resolve the same relative layout; `--font-path` points Typst at the bundled fonts. Typst binaries are small, single-file, and compile fast (typically well under a second per CV).

### 5. Release engineering (optional, but included)

`.github/workflows/release.yaml` wires this into a release pipeline:

1. Trigger: push of any git tag.
2. Checkout, install Typst via `typst-community/setup-typst@v3`.
3. `find variants -type f -name '*.typ'` — compiles **every** variant into `release/` mirroring the directory tree.
4. `softprops/action-gh-release@v2` attaches all PDFs to a GitHub Release with auto-generated release notes.

Tag and ship: the deliverables are versioned, downloadable artifacts.

---

## What this buys you *over a .docx CV*

### A. Diff-able, reviewable history (the killer feature)

A `.docx` is a zip of binary XML. Git can't meaningfully diff it — a one-line edit shows as a full-binary change and every merge is a gamble. Here, a CV change is a few lines of TOML, and `git diff` shows:

```diff
- "role = Software Developer Intern"
+ "role = Software Developer (Intern)"
```

Every reasoning is in git history with a commit message ("added a cover-letter variant"), time-stamped and attributable — useful when recruiters/authors iterate. And because `.pdf` artifacts are gitignored, the repo stores only the *source of truth*, never stale binaries.

### B. One source of truth, N tailored outputs

Recruiters want tailored CVs. In Word that means maintaining N near-duplicate documents that drift apart the moment you edit one. Here, shared components + per-variant data means each target gets its own document while the *structure* stays identical, and shared data (person info, translations) is still written once. Updating a skill chip for web-dev does not touch the game-dev CV.

### C. Authoring CVs is now a development-friendly activity

- **Write as code**: plain text, no proprietary format; any editor, no license.
- **Validation**: a malformed TOML or a typo in a variant aborts the build loudly instead of silently corrupting layout — CI catches what Word would mangle silently.
- **Reproducibility**: locked-down fonts + a JSON icon set mean the same commit renders the same PDF forever, on any machine.
- **Automation**: derived documents (cover letters reusing header components, localized copies) are generated, not maintained.

### D. Localization is one file swap

Section headers come from `translations/*.toml`. Adding a third language is **adding one file**, not re-editing every document. Content translations are handled by maintaining parallel data directories, which is exactly what a `.docx` matrix cannot do cleanly.

### E. Semantic, not pixel, editing (increased flexibility over typescripts)

Because content is data structured into `projects`, `experiences`, etc., a template can *reason* about it: render project bodies conditionally, reorder sections per variant, or restyle globally with a theme change that propagates to every document at once. In Word, "change heading color everywhere" means repeating a manual action N times; here it's one edit in `rainbow.typ`.

### F. Price of the architecture

To stay balanced: it requires a toolchain (Typst) and a build step where Word works with a double-click; and a non-technical collaborator is editing TOML, not a familiar editor. Those costs are minimal for a technical user — which is the intended audience — and are repaid by the diffing, automation, and consistency guarantees above.

---

## Quick start

```bash
# Local build of one variant
typst compile --root . --font-path style/fonts variants/webdev/webdev-en.typ /tmp/cv.pdf

# Local build of everything
find variants -type f -name '*.typ' | while read f; do
  typst compile --root . --font-path style/fonts "$f"
done

# Ship all PDFs as a GitHub Release
git tag v1.0 && git push origin v1.0
```

---

## Glossary

| Term | Meaning |
|---|---|
| **Typst** | Markup-based typesetting language/compiler; the "LaTeX successor" in use here. |
| **Variant** | A standalone `.typ` entry point that composes data + template + theme to emit one document. |
| **Theme** | A Typst dictionary (`style/fonts/{teal,rainbow}.typ`) holding colors, fonts, and sizes. |
| **Data** | TOML files describing CV content per persona/language. |
| **Translations** | TOML files mapping section labels per language. |