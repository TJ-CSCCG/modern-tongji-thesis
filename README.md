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
| `"mac"`                | macOS 自带的华文字体                                                         |
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

### 文档类选项

在 `template/main.typ` 中配置：

```typ
#import "../modern-tongji-thesis/tongjithesis.typ": *
#import "chapters/metadata.typ": *
#import "chapters/00_abstract.typ": *

// -- 文档类选项 --
#let field = "science"      // "science" 理工科（默认） / "humanities" 文科
#let fontset = "auto"       // auto / windows / texlive / founder / adobe / mac / fandol
#let bib-path = ("ref.bib", "ref.yml")
#let twoside = false        // false 单面打印（默认） / true 双面打印

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
  field: field, fontset: fontset,
  bib-content: bib-path.map(read), twoside: twoside,
)
```

#### 主要选项说明

| 选项       | 类型     | 默认值      | 说明                                                                                        |
| ---------- | -------- | ----------- | ------------------------------------------------------------------------------------------- |
| `field`    | `string` | `"science"` | `"science"` 理工科，章节编号 1 / 1.1 / 1.1.1；`"humanities"` 文科，章节编号 一、/（一）/ 1. |
| `fontset`  | `string` | `"auto"`    | 字体集：`auto` / `windows` / `texlive` / `founder` / `adobe` / `mac` / `fandol`，见上文                         |
| `twoside`  | `bool`   | `false`     | 双面打印模式：启用后装订线交替出现在左右侧，页眉/页脚内容也相应切换                         |
| `bib-path` | `string` / `array` | — | 参考文献数据文件路径（BibLaTeX `.bib` 或 Hayagriva `.yml`），可以是多个文件组成的数组 |
| `infotype` | `string` | `"thesis"`  | 成果类型：`"thesis"` 毕业论文 / `"design"` 毕业设计 / `"engineering"` 工程设计              |

### 参考文献

参考文献按 GB/T 7714—2025 顺序编码制排版，样式文件为 [`csl/gb-t-7714-2025-numeric.csl`](csl/gb-t-7714-2025-numeric.csl)：取自 [CSL 官方样式库](https://github.com/citation-style-language/styles)的 `china-national-standard-gb-t-7714-2025-numeric.csl`（CC BY-SA 3.0），按撰写规范改为半角标点。在正文中用 `@key` 引用，连续的引用自动合并为 `[1,2]`、`[1-3]`。与 LaTeX 模板相比，需在文献数据中注意：

- 英文题名按原样输出，请写作句首大写；英文文献的版本项写作 `edition = {3rd ed.}`。
- 学位论文与报告的保存单位、出版者另写在 `publisher` 中。
- 报纸（[N]）与预印本（[PP]）写在 Hayagriva 格式的 `.yml` 文件中，示例见 `template/ref.yml`。

---

## 开源协议

MIT License。

欢迎提交 Issue 或 PR。详见 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 联系方式

- [Discussions](https://github.com/TJ-CSCCG/modern-tongji-thesis/discussions)
- QQ 群：`1013806782`
