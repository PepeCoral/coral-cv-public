# Coral Data-Driven CV Generator

> Wait, are you Madeline?
>
> No, that's the point. Everything in this repository is **fictional**.
>
> This is a public copy of a personal CV pipeline I built to make my life
> easier.
>
> Madeline is the protagonist of *Celeste*. Such a cool game!

This is a **data-driven CV (and cover-letter) pipeline** built on [Typst](https://typst.app).
You write your CV once as plain-text data files, and it compiles into cool
PDFs.

## Quick start

```bash
# Build one CV
typst compile --root . --font-path style/fonts variants/webdev/webdev-en.typ /tmp/cv.pdf
```

```bash
# Build every variant
find variants -type f -name '*.typ' | while read f; do
  typst compile --root . --font-path style/fonts "$f"
done
```
```bash
# Ship everything as a GitHub Release
git tag v1.0 && git push origin v1.0
```

The included GitHub Actions workflow (`release.yaml`) compiles every variant on a
git tag push and attaches all PDFs to a Release so your files are always accessible from that Release.

## Making it yours

First let's understand a bit the project. Anything under the ```src/``` folder is the core of the builder. For basic usage,  you shouldn't need to modify anything. For advanced configuration it could be useful thought.

Each version of your CV lives in ```variants/``` each variant ```.typ``` file represents a different variant. Each one of those imports:

- The ``cv`` function from ```src/cv.typ``` this defines the structure of your CV.
- The data that will be the contents of your CV.
- The translation file this will be the language of your CV.
- The theme that will be the style of your CV.

Modify any of this files, create copies of them mix and match them as you like to create as many variants as you desire.


## Themes

| Theme | File | Vibe |
|---|---|---|
| `teal` | `style/themes/teal.typ` | The original, calm teal look |
| `graphite` | `style/themes/graphite.typ` | A gray based theme for those wanting a more serious look |
| `coral` | `style/themes/coral.typ` | A new reddish theme I am experimenting with |

Switch between them by changing one `#import` line. Themes are dictionaries, so a variant can also be modified for a specific variant with a one-line override.
(e.g. a smaller font for denser languages).

```typst
#import "../../style/themes/graphite.typ": theme

#let overriden-theme = (..theme, font-size: 9pt)

```

Good news for you, if you don't like any of this themes make your own.

## Translation

For generating a CV a language is required. Translation files include a couple of words used in the CV so creating a new translation shouldn't be difficult.

**Spanish** and **English** translations are provided. 

## Notes

- `.pdf` outputs are gitignored; the repo stores only the source of truth.
- Everything in this repository is fictional, including the author of the CV.
  If you see your real personal data here, someone shipped a non-demo build.
