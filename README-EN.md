<p align="center">
  <img src="template/figures/modern-tongji-thesis.svg" alt="modern-tongji-thesis logo" width="550">
</p>

<p align="center">
  <em>Tongji University Undergraduate Thesis · Typst Template</em>
</p>

<p align="center">
  <a href="https://github.com/TJ-CSCCG/modern-tongji-thesis/actions/workflows/ci.yml"><img src="https://github.com/TJ-CSCCG/modern-tongji-thesis/actions/workflows/ci.yml/badge.svg" alt="CI status"></a>
  <a href="https://github.com/TJ-CSCCG/modern-tongji-thesis/releases"><img src="https://img.shields.io/github/v/release/TJ-CSCCG/modern-tongji-thesis?label=Release" alt="Release version"></a>
  <a href="https://typst.app/universe/package/modern-tongji-thesis"><img src="https://img.shields.io/badge/Typst%20Universe-modern--tongji--thesis-239dae" alt="Typst Universe"></a>
  <a href="https://github.com/TJ-CSCCG/modern-tongji-thesis/blob/dev/LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue" alt="MIT License"></a>
  <img src="https://img.shields.io/badge/Typst-0.14+-239dae" alt="Typst 0.14+">
</p>

<p align="center">
  <a href="README.md">中文</a> | English
</p>

Typst template for Tongji University undergraduate thesis (final project).

> **Note | 注意**
> This template is still in beta. Formatting and features may change with Typst updates. The Typst project itself is under rapid development and some typographic details (CJK font rendering, spacing, etc.) are not yet fully stable.
>
> **For formal use, please prefer the [LaTeX template](https://github.com/TJ-CSCCG/TongjiThesis)**, which has been validated by multiple cohorts of students and strictly aligns with official formatting requirements. The Typst template is kept in sync but is currently for preview and testing only.

---

---

## Quick Start

### Typst Web App

Select `Start from a template` in the [Typst Web App](https://typst.app) and search for `modern-tongji-thesis`.

### Local Usage

#### 1. Install Typst

```bash
# macOS
brew install typst

# See official docs for other platforms
# https://github.com/typst/typst#installation
```

#### 2. Fill In and Choose Fonts

Fill cover and info page data in `template/chapters/metadata.typ`, and bilingual abstract content with keywords in `template/chapters/00_abstract.typ`. Other options are set in `template/main.typ`.

`fontset` picks the CJK fonts, matching the LaTeX template's option. The default `"auto"` uses the Zhongyi fonts of the official Word template (SimSun, SimHei, KaiTi, FangSong, shipped with Windows) when they are installed, and otherwise the free fonts of the LaTeX template's `fontset=texlive` (LXGW Neo ZhiSong, LXGW Neo XiHei, AR PL KaitiM GB, LXGW Zhuque Fangsong). Latin text uses TeX Gyre Termes, a free Times New Roman clone. CJK fonts without a bold face get bold text stroked at 1/35 of the font size, as Word does.

| `fontset`               | Fonts                                                                           |
| ----------------------- | ------------------------------------------------------------------------------- |
| `"auto"` (default)      | `"windows"` when SimSun is installed, otherwise `"texlive"`                     |
| `"windows"`             | Zhongyi fonts (Windows; elsewhere run `./fonts/download-fonts.sh windows`)      |
| `"texlive"`             | Free fonts (downloaded by `./fonts/download-fonts.sh`)                          |
| `"founder"` / `"adobe"` | Founder / Adobe fonts (`./fonts/download-fonts.sh founder` or `adobe`)          |
| `"mac"`                 | The STHeiti family shipped with macOS                                           |
| `"fandol"`              | Fandol (withdrawn by its authors; kept for theses already using it)             |

See [fonts/README.md](fonts/README.md).

#### 3. Compile

```bash
# Download fonts (first time only; add `windows` for the Word template's Zhongyi fonts)
./fonts/download-fonts.sh

# Compile
typst compile template/main.typ thesis.pdf --root . --font-path ./fonts
```

---

## Template Configuration

### Project File Layout

Mirrors the LaTeX template directory structure:

| File                                | Purpose                                                                         |
| ----------------------------------- | ------------------------------------------------------------------------------- |
| `template/main.typ`                 | Entry point, document options (`field`, `fontset`, `twoside`, `bib-path`, etc.) |
| `template/chapters/metadata.typ`    | Cover info, info page data, abstract title overrides (optional)                 |
| `template/chapters/00_abstract.typ` | Bilingual abstract content and keywords                                         |

### Document Options

Configure in `template/main.typ`:

```typ
#import "../modern-tongji-thesis/tongjithesis.typ": *
#import "chapters/metadata.typ": *
#import "chapters/00_abstract.typ": *

// -- document options --
#let field = "science"      // "science" (default) or "humanities"
#let fontset = "auto"       // auto / windows / texlive / founder / adobe / mac / fandol
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
| `fontset`  | `string` | `"auto"`    | Font set: `auto` / `windows` / `texlive` / `founder` / `adobe` / `mac` / `fandol`, see above                           |
| `twoside`  | `bool`   | `false`     | Double-sided mode: when enabled, binding marks alternate sides, header/footer content mirrors between odd/even pages   |
| `bib-path` | `string` | —           | Bibliography database file path (.bib)                                                                                 |
| `infotype` | `string` | `"thesis"`  | Output type: `"thesis"` / `"design"` / `"engineering"`                                                                 |

---

## License

MIT License.

Issues and PRs welcome. See [CONTRIBUTING.md](CONTRIBUTING.md).

## Contact

- [Discussions](https://github.com/TJ-CSCCG/modern-tongji-thesis/discussions)
- QQ Group: `1013806782`
