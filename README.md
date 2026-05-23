# TongjiThesis Typst

<p align="center">
  <a href="https://github.com/TJ-CSCCG/TongjiThesis-typst/actions/workflows/test.yml"><img src="https://github.com/TJ-CSCCG/TongjiThesis-typst/actions/workflows/test.yml/badge.svg" alt="CI"></a>
  <a href="https://github.com/TJ-CSCCG/TongjiThesis-typst/releases"><img src="https://img.shields.io/github/v/release/TJ-CSCCG/TongjiThesis-typst?label=Release" alt="Release"></a>
  <a href="https://typst.app/universe/package/paddling-tongji-thesis"><img src="https://img.shields.io/badge/Typst%20Universe-paddling--tongji--thesis-239dae" alt="Typst Universe"></a>
  <a href="https://github.com/TJ-CSCCG/TongjiThesis-typst/blob/dev/LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue" alt="License"></a>
  <img src="https://img.shields.io/badge/Typst-0.14+-239dae" alt="Typst 0.14+">
</p>

<p align="center">
  中文 | <a href="README-EN.md">English</a>
</p>

同济大学本科毕业设计（论文）Typst 模板。

> [!CAUTION]
> 本模板仍处于测试阶段，格式与功能可能随 Typst 版本更新而变动。Typst 项目本身也在快速迭代中，部分排版细节（如中文字体渲染、CJK 间距等）尚未完全稳定。
>
> **正式使用请优先选择 [LaTeX 模板](https://github.com/TJ-CSCCG/TongjiThesis)**，该模板经过多届学生验证，格式严格对齐官方规范。Typst 模板同步更新，但目前仅供体验与测试。

---

## 特性

- 封面、信息说明页、中英文摘要、目录、正文、参考文献、谢辞
- 理工科（`field: "science"`）/ 文科（`field: "humanities"`）双模式
- 定理环境（定理、推论、引理、命题、猜想、假设、定义、例、注、证明）
- 附录（字母编号 A, B, C...）
- GB/T 7714-2015 双语参考文献（`gb7714-bilingual` 宏包）
- 三线表（`tablex` + `booktabs` 风格）
- 算法排版（`algo` 宏包）
- 交叉引用（`i-figured` 宏包，图/表/公式/算法按章节编号）
- ①②③ 脚注编号（Unicode 1-50 + 绘制圆圈 51+）
- 五种字体集：`fandol`（默认）、`windows`、`mac`、`adobe`、`founder`
- 字符级两端对齐 + 优化换行

---

## 快速开始

### 在线 Web App

在 [Typst Web App](https://typst.app) 中选择 `Start from a template`，搜索 `paddling-tongji-thesis`。

### 本地使用

#### 1. 安装 Typst

```bash
# macOS
brew install typst

# 或参照官方文档安装
# https://github.com/typst/typst#installation
```

#### 2. 选择字体集

在 `init-files/metadata.typ` 中设置 `fontset` 参数：

> 所有字体集均使用 **TeX Gyre Termes**（Times New Roman 的开源替代，Typst Web App 内置，Linux: `apt install fonts-texgyre` 或下载 ZIP）作为中英文混排的 Latin 衬线字体。

| 平台     | 推荐 fontset | 说明                                                                         |
| -------- | ------------ | ---------------------------------------------------------------------------- |
| macOS    | `"mac"`      | Songti SC / Heiti SC 系统字体                                                |
| Windows  | `"windows"`  | SimSun / SimHei 系统字体                                                     |
| Linux    | `"fandol"`   | 安装 Fandol（TeX Live 或 `apt install fonts-fandol`）                        |
| Adobe    | `"adobe"`    | 需安装 Adobe 字体                                                            |
| 方正字库 | `"founder"`  | 从 [cjk-fonts-for-ctex](https://github.com/TJ-CSCCG/cjk-fonts-for-ctex) 下载 |

#### 3. 编译

```bash
git clone https://github.com/TJ-CSCCG/TongjiThesis-typst.git
cd TongjiThesis-typst
typst compile init-files/main.typ --root .
```

---

## 模板配置

### 文档类选项

在 `init-files/main.typ` 的 `thesis.with()` 中配置：

```typ
#show: thesis.with(
  field: "science",      // "science" 理工科 / "humanities" 文科
  fontset: "fandol",   // fandol / windows / mac / adobe / founder
  bib-content: read("bib/note.bib"),
)
```

> `field: "humanities"` 启用文科格式：章节编号 一、/（一）/ 1. / （1） / ①②③

### 元数据

所有个人信息在 `init-files/metadata.typ` 中填写（与 LaTeX 模板的 `chapters/metadata.tex` 对应）：

```typ
// 封面信息
#let school = "计算机科学与技术学院"
#let major = "计算机科学与技术"
#let id = "2654321"
#let student = "张同舟"
#let advisor = "李共济  教授"
#let title = "论文题目"
#let subtitle = "副标题"
#let title-english = "Thesis Title"
#let subtitle-english = "Subtitle"

// 信息说明页
#let infotype = "thesis"        // "thesis" / "design" / "engineering"
#let infoabstract = [内容简述...]
#let infothesiswords = "12345"  // 毕业论文字数

// 中英文摘要
#let abstract = [摘要内容...]
#let keywords = ("关键词1", "关键词2", "关键词3")
#let abstract-english = [Abstract...]
#let keywords-english = ("Keyword1", "Keyword2", "Keyword3")
```

### 定理环境

```typ
#thm[这是定理内容]
#cor[这是推论内容]
#lem[这是引理内容]
#pf[这是证明内容]
```

### 交叉引用

```typ
#chapref(<label>)   // 第X章
#figref(<label>)    // 图X
#tabref(<label>)    // 表X
#eqref(<label>)     // 式X
```

### 附录

```typ
#appendix[
  = 附录A标题
  附录内容...
]
```

### PDF/A 导出

```bash
typst compile init-files/main.typ thesis.pdf --pdf-standard a-2b
```

---

## 开源协议

MIT License。

## 贡献与致谢

该项目起源于 [FeO3](https://github.com/seashell11234455) 的初始版本，后由 [RizhongLin](https://github.com/RizhongLin) 完善。感谢 [pkuthss-typst](https://github.com/lucifer1004/pkuthss-typst)、[HUST-typst-template](https://github.com/werifu/HUST-typst-template) 等项目的启发。

欢迎提交 Issue 或 PR。详见 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 联系方式

- [Discussions](https://github.com/TJ-CSCCG/TongjiThesis-typst/discussions)
- QQ 群：`1013806782`
