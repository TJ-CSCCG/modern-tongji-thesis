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
| `"mac"`                 | Songti SC / Heiti SC / Kaiti SC / STFangsong, shipped with macOS                |
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
| `template/taskbook.typ`, `proposal.typ`, `midterm.typ` | Entry points of the task book, proposal and midterm report; their content is in `chapters/*_body.typ` |

### Document Options

Configure in `template/main.typ`:

```typ
#import "../lib.typ": *  // "@preview/modern-tongji-thesis:<version>" in a project created from Typst Universe
#import "chapters/metadata.typ": *
#import "chapters/00_abstract.typ": *

// -- document options --
#let field = "science"      // "science" (default) or "humanities"
#let fontset = "auto"       // auto / windows / texlive / founder / adobe / mac / fandol
#let bib-path = ("ref.bib", "ref.yml")  // .bib / .yml
#let twoside = false        // false single-sided (default) / true double-sided
#let blind = false          // true for the blind-review version

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
  field: field, fontset: fontset, twoside: twoside, blind: blind,
  bib-content: bib-path.map(read),
)
```

#### Key Options

| Option     | Type     | Default     | Description                                                                                                            |
| ---------- | -------- | ----------- | ---------------------------------------------------------------------------------------------------------------------- |
| `field`    | `string` | `"science"` | `"science"` for science/engineering numbering 1 / 1.1 / 1.1.1; `"humanities"` for humanities numbering 一、/（一）/ 1. |
| `fontset`  | `string` | `"auto"`    | Font set: `auto` / `windows` / `texlive` / `founder` / `adobe` / `mac` / `fandol`, see above                           |
| `twoside`  | `bool`   | `false`     | Double-sided mode: when enabled, binding marks alternate sides, header/footer content mirrors between odd/even pages   |
| `blind`    | `bool`   | `false`     | Blind-review version: the cover leaves the student's name, student ID and advisor blank, the acknowledgements are left out, and the PDF names no author (see below) |
| `bib-path` | `string` / `array` | — | Bibliography file path (BibLaTeX `.bib` or Hayagriva `.yml`), or an array of them |
| `infotype` | `string` | `"thesis"`  | Output type: `"thesis"` / `"design"` / `"engineering"`                                                                 |

### Task Book, Proposal and Midterm Report

Besides the thesis, the template provides the three official forms, matching the LaTeX template's `doctype=taskbook|proposal|midterm`. Each compiles on its own:

```bash
typst compile template/taskbook.typ --root . --font-path ./fonts   # 毕业设计（论文）任务书
typst compile template/proposal.typ --root . --font-path ./fonts   # 开题报告
typst compile template/midterm.typ --root . --font-path ./fonts    # 中期报告
```

They share the title, subtitle, school, major, student name and student ID in `template/chapters/metadata.typ` with the thesis; the advisor signs every form by hand, so the advisor is not printed. The task book's dates are `taskbook-start` and `taskbook-end`, from which the weeks are counted (rounded up). The midterm report's agree/disagree boxes stay blank unless `midterm-decision` is `"agree"` or `"disagree"`. For a humanities major, set `field` to `"humanities"` in each entry file.

The content goes in `template/chapters/taskbook_body.typ`, `proposal_body.typ` and `midterm_body.typ`, set with these commands, which choose the fonts and sizes:

| Command | Use |
| ------- | --- |
| `#form-section[一、……]` | Section heading: 四号 黑体, indented two characters |
| `#form-subsection[1．……]` | Subsection heading: 小四 黑体, indented two characters |
| `#form-note[……]` / `#form-hint[……]` | Gray notes: the first is deleted from the final version; the second is a prompt, whose “请在此处填写……” placeholders are replaced with your text |
| `#form-notice[填写说明]`, `#form-notice-body(...)` | The midterm report's instructions title (bold 小二 黑体) and numbered items (四号) |
| `#review-box[...]`, `#form-label[……]` | A review box and a field label in it (小四 黑体) |
| `#form-signature([指导教师签名])` | A right-aligned signature line (an underline and the date blanks, in 黑体); `width:` and `size:` adjust it |
| `#form-date-blank()`, `#midterm-decision()` | The date blanks; the midterm report's agree/disagree boxes |

### Blind Review

To submit an anonymous thesis (for a blind review a school organizes), set `blind` to `true` in `template/main.typ` and compile again; nothing has to be deleted by hand:

- the cover keeps its fields but leaves the student's name, student ID and advisor blank;
- the acknowledgements are left out (`#if not blind { include "chapters/acknowledgments.typ" }` in `main.typ`);
- the PDF names no author in its properties.

Mark other identifying text in the body with `#tjblind[official text][blind text]`, for example `#tjblind[国家自然科学基金（12345678）][某项目]`. The plagiarism check upload and the undergraduate thesis spot checks require the official version (同济本〔2021〕33号), so do not submit the blind version there.

### Bibliography

References follow the GB/T 7714—2025 numeric system with the style in [`csl/gb-t-7714-2025-numeric.csl`](csl/gb-t-7714-2025-numeric.csl): `china-national-standard-gb-t-7714-2025-numeric.csl` from the [official CSL style repository](https://github.com/citation-style-language/styles) (CC BY-SA 3.0), changed to the half-width punctuation the writing spec requires. Cite with `@key`; adjacent citations merge into `[1,2]` or `[1-3]`, and `@key[12]` prints the page in superscript after the number. Unlike the LaTeX template, the data needs care in three places:

- English titles are printed as written, so write them in sentence case; English editions are written `edition = {3rd ed.}`.
- The institution of a thesis or report also goes in `publisher`.
- Newspapers ([N]) and preprints ([PP]) go in a Hayagriva `.yml` file; see `template/ref.yml`.

### Differences from the LaTeX Template

This template follows 《同济大学本科生毕业设计（论文）撰写规范》 (revised October 2026) as the [LaTeX template](https://github.com/TJ-CSCCG/TongjiThesis) implements it; the cover, information page, abstracts, contents, body, references, appendix and acknowledgements were compared with it page by page. These differences remain:

- References: English titles are not converted to sentence case, pinyin given names are abbreviated, and CSTR is not printed; newspapers and preprints go in a `.yml` file (see above).
- Three-line tables have none of the 3–4 pt of extra space `booktabs` puts around the rules.
- Math uses New Computer Modern Math; the LaTeX template uses the Times-like `newtx`.
- Code blocks use `codly`'s style, not that of LaTeX `listings`.

### Upgrading from 0.2

- `songti`, `heiti`, `kaiti` and `fangsong` are functions that follow the chosen font set: write `#heiti[text]` instead of `#text(font: heiti)[text]`. `font-family` is removed.
- The default `fontset` is `"auto"` instead of `"fandol"`, so the fonts change; to keep Fandol, set `fontset: "fandol"` and download Fandol with `./fonts/download-fonts.sh fandol`.
- The bibliography no longer uses `gb7714-bilingual`: `#multicite()` still works, the `mark` field of a `.bib` entry is no longer read, and English titles, editions, newspapers and preprints need the changes the Bibliography section describes. `bib-content` takes the contents of several files.
- Table text is 五号 instead of 小五 (the writing spec), so a table sized to fill the text width at 小五 may need narrower columns.
- The new `blind` option: add `#let blind = false` to `main.typ`, pass it with `thesis.with(blind: blind)`, and include the acknowledgements with `#if not blind { include "chapters/acknowledgments.typ" }`.

---

## License

MIT License. `csl/gb-t-7714-2025-numeric.csl` is adapted from the official CSL style repository and shared under CC BY-SA 3.0.

Issues and PRs welcome. See [CONTRIBUTING.md](CONTRIBUTING.md).

## Contact

- [Discussions](https://github.com/TJ-CSCCG/modern-tongji-thesis/discussions)
- QQ Group: `1013806782`
