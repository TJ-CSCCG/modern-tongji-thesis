<p align="center">
  <img src="init-files/figures/tongjithesis.svg" alt="TongjiThesis" width="550">
</p>

<p align="center">
  <em>Tongji University Undergraduate Thesis · Typst Template</em>
</p>

<p align="center">
  <a href="https://github.com/TJ-CSCCG/TongjiThesis-typst/actions/workflows/test.yml"><img src="https://github.com/TJ-CSCCG/TongjiThesis-typst/actions/workflows/test.yml/badge.svg" alt="CI"></a>
  <a href="https://github.com/TJ-CSCCG/TongjiThesis-typst/releases"><img src="https://img.shields.io/github/v/release/TJ-CSCCG/TongjiThesis-typst?label=Release" alt="Release"></a>
  <a href="https://typst.app/universe/package/paddling-tongji-thesis"><img src="https://img.shields.io/badge/Typst%20Universe-paddling--tongji--thesis-239dae" alt="Typst Universe"></a>
  <a href="https://github.com/TJ-CSCCG/TongjiThesis-typst/blob/dev/LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue" alt="License"></a>
  <img src="https://img.shields.io/badge/Typst-0.14+-239dae" alt="Typst 0.14+">
</p>

<p align="center">
  <a href="README.md">中文</a> | English
</p>

Typst template for Tongji University undergraduate thesis (final project).

> [!CAUTION]
> This template is still in beta. Formatting and features may change with Typst updates. The Typst project itself is under rapid development and some typographic details (CJK font rendering, spacing, etc.) are not yet fully stable.
>
> **For formal use, please prefer the [LaTeX template](https://github.com/TJ-CSCCG/TongjiThesis)**, which has been validated by multiple cohorts of students and strictly aligns with official formatting requirements. The Typst template is kept in sync but is currently for preview and testing only.

---

## Features

- Cover, info page, bilingual abstracts, TOC, body, bibliography, acknowledgments
- Dual discipline: `field: "science"` / `field: "humanities"`
- Theorem environments (theorem, corollary, lemma, proposition, conjecture, assumption, definition, example, remark, proof)
- Appendix (lettered sections A, B, C...)
- GB/T 7714-2015 bilingual bibliography (`gb7714-bilingual` package)
- Three-line tables (native Typst `table` + `table.hline`)
- Algorithm typesetting (`algo` package)
- Chapter-prefixed float numbering (native Typst `figure` counter, fig/table/equation/algo)
- Circled number footnotes ①②③ (Unicode 1-50 + drawn circles 51+)
- Five fontsets: `fandol` (default), `windows`, `mac`, `adobe`, `founder`
- Character-level justification + optimized line breaks

---

## Quick Start

### Typst Web App

Select `Start from a template` in the [Typst Web App](https://typst.app) and search for `paddling-tongji-thesis`.

### Local Usage

#### 1. Install Typst

```bash
# macOS
brew install typst

# See official docs for other platforms
# https://github.com/typst/typst#installation
```

#### 2. Choose Font Set

Fill cover and info page data in `init-files/chapters/metadata.typ`, and bilingual abstract content with keywords in `init-files/chapters/00_abstract.typ`. Other options are set in `init-files/main.typ`.

> All font presets use **TeX Gyre Termes** (free, open-source TNR clone; built into Typst Web App; Linux: `apt install fonts-texgyre` or download ZIP) as the Latin serif font for Chinese-English mixed typesetting.

| Platform        | Recommended fontset     | Notes                                                                              |
| --------------- | ----------------------- | ---------------------------------------------------------------------------------- |
| macOS           | `"mac"`                 | Songti SC / Heiti SC system fonts                                                  |
| Windows         | `"windows"`             | SimSun / SimHei system fonts                                                       |
| Linux           | `"fandol"`              | Fandol + TeX Gyre Termes ([CTAN download](fonts/README.md))                        |
| Adobe / Founder | `"adobe"` / `"founder"` | Download from [cjk-fonts-for-ctex](https://github.com/TJ-CSCCG/cjk-fonts-for-ctex) |

#### 3. Compile

```bash
# Download fonts (first time only)
./fonts/download-fonts.sh

# Compile
typst compile init-files/main.typ thesis.pdf --root . --font-path ./fonts
```

---

## Template Configuration

### Project File Layout

Mirrors the LaTeX template directory structure:

| File                                  | Purpose                                                                         |
| ------------------------------------- | ------------------------------------------------------------------------------- |
| `init-files/main.typ`                 | Entry point, document options (`field`, `fontset`, `twoside`, `bib-path`, etc.) |
| `init-files/chapters/metadata.typ`    | Cover info, info page data, abstract title overrides (optional)                 |
| `init-files/chapters/00_abstract.typ` | Bilingual abstract content and keywords                                         |

### Document Options

Configure in `init-files/main.typ`:

```typ
#import "../paddling-tongji-thesis/tongjithesis.typ": *
#import "chapters/metadata.typ": *
#import "chapters/00_abstract.typ": *

// -- document options --
#let field = "science"      // "science" (default) or "humanities"
#let fontset = "fandol"     // fandol / windows / mac / adobe / founder
#let bib-path = "bib/note.bib"
#let twoside = false        // false single-sided (default) / true double-sided

#show: thesis.with(
  // Cover info (from metadata.typ)
  school: school, major: major, id: id, student: student,
  advisor: advisor, title: title, subtitle: subtitle,
  title-english: title-english, subtitle-english: subtitle-english,
  date: date,

  // Abstracts (from 00_abstract.typ)
  abstract: abstract, keywords: keywords,
  abstract-english: abstract-english, keywords-english: keywords-english,

  // Info page (from metadata.typ)
  infotype: infotype, infoabstract: infoabstract,
  infodrawings: infodrawings, infowordcount: infowordcount,
  infothesiswords: infothesiswords, infomaterials: infomaterials,

  // Abstract title overrides (from metadata.typ, optional)
  abstract-title: abstract-title, abstract-subtitle: abstract-subtitle,
  abstract-title-english: abstract-title-english,
  abstract-subtitle-english: abstract-subtitle-english,

  // Document options
  field: field, fontset: fontset,
  bib-content: read(bib-path), twoside: twoside,
)
```

#### Key Options

| Option     | Type     | Default     | Description                                                                                                            |
| ---------- | -------- | ----------- | ---------------------------------------------------------------------------------------------------------------------- |
| `field`    | `string` | `"science"` | `"science"` for science/engineering numbering 1 / 1.1 / 1.1.1; `"humanities"` for humanities numbering 一、/（一）/ 1. |
| `fontset`  | `string` | `"fandol"`  | Font preset: `fandol` / `windows` / `mac` / `adobe` / `founder`                                                        |
| `twoside`  | `bool`   | `false`     | Double-sided mode: when enabled, binding marks alternate sides, header/footer content mirrors between odd/even pages   |
| `bib-path` | `string` | —           | Bibliography database file path (.bib)                                                                                 |
| `infotype` | `string` | `"thesis"`  | Output type: `"thesis"` / `"design"` / `"engineering"`                                                                 |

---

## License

MIT License.

Issues and PRs welcome. See [CONTRIBUTING.md](CONTRIBUTING.md).

## Contact

- [Discussions](https://github.com/TJ-CSCCG/TongjiThesis-typst/discussions)
- QQ Group: `1013806782`
