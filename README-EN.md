# TongjiThesis Typst

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
- Three-line tables (`tablex` + booktabs-style rules)
- Algorithm typesetting (`algo` package)
- Cross-references (`i-figured` package, chapter-prefixed numbering)
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

Set the `fontset` parameter in `init-files/metadata.typ`:


> All font presets use **TeX Gyre Termes** (free, open-source TNR clone; built into Typst Web App; Linux: `apt install fonts-texgyre` or download ZIP) as the Latin serif font for Chinese-English mixed typesetting.

| Platform | Recommended fontset | Notes                                                                      |
| -------- | ------------------- | -------------------------------------------------------------------------- |
| macOS    | `"mac"`             | Songti SC / Heiti SC system fonts                                          |
| Windows  | `"windows"`         | SimSun / SimHei system fonts                                               |
| Linux    | `"fandol"`          | Fandol + TeX Gyre Termes ([CTAN download](fonts/README.md))                |
| Adobe    | `"adobe"`           | Requires Adobe fonts                                                       |
| Founder  | `"founder"`         | Download from [cjk-fonts-for-ctex](https://github.com/TJ-CSCCG/cjk-fonts-for-ctex) |

#### 3. Compile

```bash
git clone https://github.com/TJ-CSCCG/TongjiThesis-typst.git
cd TongjiThesis-typst
typst compile init-files/main.typ --root .
```

---

## Template Configuration

### Document Options

Configure in `init-files/main.typ`:

```typ
#show: thesis.with(
  field: "science",      // "science" or "humanities"
  fontset: "fandol",   // fandol / windows / mac / adobe / founder
  bib-content: read("bib/note.bib"),
)
```

> `field: "humanities"` enables humanities numbering: 一、/（一）/ 1. / （1） / ①②③

### Metadata

All user information goes in `init-files/metadata.typ` (matches LaTeX's `chapters/metadata.tex`). See comments in that file.

### PDF/A Export

```bash
typst compile init-files/main.typ thesis.pdf --pdf-standard a-2b
```

---

## License

MIT License.

Issues and PRs welcome. See [CONTRIBUTING.md](CONTRIBUTING.md).

## Contact

- [Discussions](https://github.com/TJ-CSCCG/TongjiThesis-typst/discussions)
- QQ Group: `1013806782`
