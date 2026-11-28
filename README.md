<p align="center">
  <img src="template/figures/modern-tongji-thesis.svg" alt="modern-tongji-thesis logo" width="550">
</p>

<p align="center">
  <em>同济大学本科生毕业设计（论文）· Typst 模板</em>
</p>

<p align="center">
  <a href="https://github.com/TJ-CSCCG/modern-tongji-thesis/actions/workflows/ci.yml"><img src="https://github.com/TJ-CSCCG/modern-tongji-thesis/actions/workflows/ci.yml/badge.svg" alt="CI status"></a>
  <a href="https://github.com/TJ-CSCCG/modern-tongji-thesis/releases"><img src="https://img.shields.io/github/v/release/TJ-CSCCG/modern-tongji-thesis?label=Release" alt="Release version"></a>
  <a href="https://typst.app/universe/package/modern-tongji-thesis"><img src="https://img.shields.io/badge/Typst%20Universe-modern--tongji--thesis-239dae" alt="Typst Universe"></a>
  <a href="https://github.com/TJ-CSCCG/modern-tongji-thesis/blob/dev/LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue" alt="MIT License"></a>
  <img src="https://img.shields.io/badge/Typst-0.14+-239dae" alt="Typst 0.14+">
</p>

<p align="center">
  中文 | <a href="README-EN.md">English</a>
</p>

同济大学本科毕业设计（论文）Typst 模板。

> **注意 | Caution**
> 本模板仍处于测试阶段，格式与功能可能随 Typst 版本更新而变动。Typst 项目本身也在快速迭代中，部分排版细节（如中文字体渲染、CJK 间距等）尚未完全稳定。
>
> **正式使用请优先选择 [LaTeX 模板](https://github.com/TJ-CSCCG/TongjiThesis)**，该模板经过多届学生验证，格式严格对齐官方规范。Typst 模板同步更新，但目前仅供体验与测试。

---

---

## 快速开始

### 在线 Web App

在 [Typst Web App](https://typst.app) 中选择 `Start from a template`，搜索 `modern-tongji-thesis`。

### 本地使用

#### 1. 安装 Typst

```bash
# macOS
brew install typst

# 或参照官方文档安装
# https://github.com/typst/typst#installation
```

#### 2. 填写信息与选择字体

在 `template/chapters/metadata.typ` 中填写封面与信息说明页信息，在 `template/chapters/00_abstract.typ` 中填写中英文摘要与关键词。其他选项在 `template/main.typ` 中设置。

字体集由 `fontset` 选择，与 LaTeX 模板的同名选项对应。默认值 `"auto"` 在装有 Word 模板所用的中易字体（SimSun、SimHei、KaiTi、FangSong，Windows 自带）时使用它们，否则使用 LaTeX 模板 `fontset=texlive` 的免费字体（霞鹜新致宋、霞鹜新晰黑、文鼎 PL 中楷、朱雀仿宋）。西文统一使用 TeX Gyre Termes（Times New Roman 的开源替代）。没有粗体字形的中文字体，粗体按 Word 的方式以字号 1/35 的描边模拟。

| `fontset`              | 字体                                                                         |
| ---------------------- | ---------------------------------------------------------------------------- |
| `"auto"`（默认）       | 有 SimSun 时同 `"windows"`，否则同 `"texlive"`                               |
| `"windows"`            | 中易字体（Windows 自带；其他系统运行 `./fonts/download-fonts.sh windows`）   |
| `"texlive"`            | 免费字体（`./fonts/download-fonts.sh` 下载）                                 |
| `"founder"` / `"adobe"` | 方正 / Adobe 字体（`./fonts/download-fonts.sh founder` 或 `adobe`）         |
| `"mac"`                | macOS 自带的 Songti SC / Heiti SC / Kaiti SC / STFangsong                    |
| `"fandol"`             | Fandol（作者已撤回，仅为旧稿保留）                                           |

详见 [fonts/README.md](fonts/README.md)。

#### 3. 编译

```bash
# 下载字体（首次使用；加上 windows 另下载 Word 模板所用的中易字体）
./fonts/download-fonts.sh

# 编译
typst compile template/main.typ thesis.pdf --root . --font-path ./fonts
```

---

## 模板配置

### 项目文件组织

与 LaTeX 模板保持一致的目录结构：

| 文件                                | 用途                                                                     |
| ----------------------------------- | ------------------------------------------------------------------------ |
| `template/main.typ`                 | 编译入口，配置文档类选项（`field`、`fontset`、`twoside`、`bib-path` 等） |
| `template/chapters/metadata.typ`    | 封面信息、信息说明页数据、摘要页标题覆盖（可选）                         |
| `template/chapters/00_abstract.typ` | 中英文摘要内容与关键词                                                   |
| `template/taskbook.typ`、`proposal.typ`、`midterm.typ` | 任务书、开题报告、中期报告的编译入口，正文在 `chapters/*_body.typ` 中 |

### 文档类选项

在 `template/main.typ` 中配置：

```typ
#import "../lib.typ": *  // 从 Typst Universe 创建的项目中为 "@preview/modern-tongji-thesis:<版本>"
#import "chapters/metadata.typ": *
#import "chapters/00_abstract.typ": *

// -- 文档类选项 --
#let field = "science"      // "science" 理工科（默认） / "humanities" 文科
#let fontset = "auto"       // auto / windows / texlive / founder / adobe / mac / fandol
#let bib-path = ("ref.bib", "ref.yml")  // .bib / .yml
#let twoside = false        // false 单面打印（默认） / true 双面打印
#let blind = false          // true 盲审版本

#show: thesis.with(
  // 封面信息（来自 metadata.typ）
  school: school, major: major, id: id, student: student,
  advisor: advisor, title: title, subtitle: subtitle,
  title-english: title-english, subtitle-english: subtitle-english,
  date: date,

  // 摘要（来自 00_abstract.typ）
  abstract: abstract, keywords: keywords,
  abstract-english: abstract-english, keywords-english: keywords-english,

  // 信息说明页（来自 metadata.typ）
  infotype: infotype, infoabstract: infoabstract,
  infodrawings: infodrawings, infowordcount: infowordcount,
  infothesiswords: infothesiswords, infomaterials: infomaterials,

  // 摘要页标题覆盖（来自 metadata.typ，可选）
  abstract-title: abstract-title, abstract-subtitle: abstract-subtitle,
  abstract-title-english: abstract-title-english,
  abstract-subtitle-english: abstract-subtitle-english,

  // 文档类选项
  field: field, fontset: fontset, twoside: twoside, blind: blind,
  bib-content: bib-path.map(read),
)
```

#### 主要选项说明

| 选项       | 类型     | 默认值      | 说明                                                                                        |
| ---------- | -------- | ----------- | ------------------------------------------------------------------------------------------- |
| `field`    | `string` | `"science"` | `"science"` 理工科，章节编号 1 / 1.1 / 1.1.1；`"humanities"` 文科，章节编号 一、/（一）/ 1. |
| `fontset`  | `string` | `"auto"`    | 字体集：`auto` / `windows` / `texlive` / `founder` / `adobe` / `mac` / `fandol`，见上文                         |
| `twoside`  | `bool`   | `false`     | 双面打印模式：启用后装订线交替出现在左右侧，页眉/页脚内容也相应切换                         |
| `blind`    | `bool`   | `false`     | 盲审版本：封面上的学生姓名、学号、指导教师留空，不输出谢辞，PDF 文档属性中不写作者，见下文                    |
| `bib-path` | `string` / `array` | — | 参考文献数据文件路径（BibLaTeX `.bib` 或 Hayagriva `.yml`），可以是多个文件组成的数组 |
| `infotype` | `string` | `"thesis"`  | 成果类型：`"thesis"` 毕业论文 / `"design"` 毕业设计 / `"engineering"` 工程设计              |

### 任务书、开题报告与中期报告

除论文外，模板还提供三份官方表格，与 LaTeX 模板的 `doctype=taskbook|proposal|midterm` 对应，各自单独编译：

```bash
typst compile template/taskbook.typ --root . --font-path ./fonts   # 毕业设计（论文）任务书
typst compile template/proposal.typ --root . --font-path ./fonts   # 开题报告
typst compile template/midterm.typ --root . --font-path ./fonts    # 中期报告
```

三者与论文共用 `template/chapters/metadata.typ` 中的课题名称、副标题、学院、专业、学生姓名与学号；指导教师在三份表格中均为手写签字位，不预填。任务书的起讫时间写在 `taskbook-start`、`taskbook-end` 中，周数自动换算（向上取整）；中期报告“专业审核意见”的复选框默认留空，可在 `midterm-decision` 中设为 `"agree"` 或 `"disagree"`。文科专业请在各入口文件中把 `field` 改为 `"humanities"`。

正文写在 `template/chapters/taskbook_body.typ`、`proposal_body.typ`、`midterm_body.typ` 中，用以下命令排版，字体字号由命令负责：

| 命令 | 用途 |
| ---- | ---- |
| `#form-section[一、……]` | 一级分节标题：四号黑体，缩进 2 字符 |
| `#form-subsection[1．……]` | 二级分节标题：小四黑体，缩进 2 字符 |
| `#form-note[……]` / `#form-hint[……]` | 灰色批注：前者为说明文字，成稿时删除；后者为内容提示，请把“请在此处填写……”换成正文 |
| `#form-notice[填写说明]`、`#form-notice-body(...)` | 中期报告首页的说明标题（小二黑体加粗）与编号说明（四号） |
| `#review-box[...]`、`#form-label[……]` | 审核意见方框与框内的字段标签（小四黑体） |
| `#form-signature([指导教师签名])` | 右对齐的签字行（签名下划线与年月日填空，黑体）；`width:`、`size:` 可调 |
| `#form-date-blank()`、`#midterm-decision()` | 年月日填空；中期报告的同意/不同意复选框 |

### 盲审版本

需要提交匿名论文（如学院组织的盲审）时，把 `template/main.typ` 中的 `blind` 改为 `true` 重新编译，不必手工删改内容：

- 封面保留各栏目，但学生姓名、学号、指导教师留空；
- 不输出谢辞（`main.typ` 中的 `#if not blind { include "chapters/acknowledgments.typ" }`）；
- PDF 文档属性中不写作者。

正文中其他能识别身份的内容用 `#tjblind[正式版内容][盲审版内容]` 标记，例如 `#tjblind[国家自然科学基金（12345678）][某项目]`，本人已发表成果可写作“第一作者”等。查重上传与本科毕业论文抽检要求提交正式版（同济本〔2021〕33号），不要使用盲审版本。

### 参考文献

参考文献按 GB/T 7714—2025 顺序编码制排版，样式文件为 [`csl/gb-t-7714-2025-numeric.csl`](csl/gb-t-7714-2025-numeric.csl)：取自 [CSL 官方样式库](https://github.com/citation-style-language/styles)的 `china-national-standard-gb-t-7714-2025-numeric.csl`（CC BY-SA 3.0），按撰写规范改为半角标点。在正文中用 `@key` 引用，连续的引用自动合并为 `[1,2]`、`[1-3]`；引用页码写作 `@key[12]`，以上标排在序号之后。与 LaTeX 模板相比，需在文献数据中注意：

- 英文题名按原样输出，请写作句首大写；英文文献的版本项写作 `edition = {3rd ed.}`。
- 学位论文与报告的保存单位、出版者另写在 `publisher` 中。
- 报纸（[N]）与预印本（[PP]）写在 Hayagriva 格式的 `.yml` 文件中，示例见 `template/ref.yml`。

### 与 LaTeX 模板的差异

本模板按 [LaTeX 模板](https://github.com/TJ-CSCCG/TongjiThesis)实现的《同济大学本科生毕业设计（论文）撰写规范》（2026 年 10 月修订版）排版，封面、信息说明页、摘要、目录、正文、参考文献、附录与谢辞的版式与之逐页对照。目前仍有以下不同：

- 参考文献：英文题名不自动改为句首大写，汉语拼音姓名缩写为首字母，不著录 CSTR；报纸与预印本需写在 `.yml` 文件中（见上文）。
- 三线表：顶线、栏目线、底线两侧没有 LaTeX `booktabs` 额外的 3～4 pt 留白。
- 公式使用 New Computer Modern Math，LaTeX 模板使用 Times 风格的 `newtx`。
- 代码块使用 `codly` 的样式，与 LaTeX 的 `listings` 不同。

### 从 0.2 升级

- `songti`、`heiti`、`kaiti`、`fangsong` 改为函数，按所选字体集排版：`#text(font: heiti)[文字]` 改写为 `#heiti[文字]`；`font-family` 已删除。
- `fontset` 默认值由 `"fandol"` 改为 `"auto"`，输出字体随之改变；要保留 Fandol，写 `fontset: "fandol"`，并用 `./fonts/download-fonts.sh fandol` 下载 Fandol 字体。
- 参考文献不再使用 `gb7714-bilingual`：`#multicite()` 仍可使用，`.bib` 中的 `mark` 字段不再读取；按上文“参考文献”一节调整英文题名、版本项与报纸、预印本条目。`bib-content` 可传入多个文件的内容。
- 表内文字由小五号改为五号（撰写规范），按小五号排满版心的表格可能需要调整列宽。
- 新增 `blind` 选项：在 `main.typ` 中加入 `#let blind = false`，传给 `thesis.with(blind: blind)`，并把谢辞改为 `#if not blind { include "chapters/acknowledgments.typ" }`。

---

## 开源协议

MIT License。`csl/gb-t-7714-2025-numeric.csl` 改编自 CSL 官方样式库，按 CC BY-SA 3.0 发布。

欢迎提交 Issue 或 PR。详见 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 联系方式

- [Discussions](https://github.com/TJ-CSCCG/modern-tongji-thesis/discussions)
- QQ 群：`1013806782`
