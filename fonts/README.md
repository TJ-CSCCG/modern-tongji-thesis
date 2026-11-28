# 字体文件 | Fonts

本目录不随仓库分发字体文件。用下面的脚本下载，或把字体装进系统。

This directory ships no font files. Download them with the script below, or install them on the system.

## 一键下载 | Download

```bash
./fonts/download-fonts.sh            # 免费字体 | the free fonts
./fonts/download-fonts.sh windows    # 另下载中易字体 | also the Zhongyi fonts of the Word template
```

脚本总是下载：

- `texlive` 字体集，即 LaTeX 模板 `fontset=texlive` 使用的免费字体：霞鹜新致宋（LXGW Neo ZhiSong）、霞鹜新晰黑（LXGW Neo XiHei）、朱雀仿宋（LXGW Zhuque Fangsong，CTAN `lxgw-fonts`）与文鼎 PL 中楷（AR PL KaitiM GB，CTAN `arphic-ttf`）；
- TeX Gyre Termes：中英文混排中的西文字体；
- Harano Aji Mincho：带圈数字 ①–㊿。

给出字体集名称（`windows`、`founder`、`adobe`、`fandol`）时，另从 [cjk-fonts-for-ctex](https://github.com/TJ-CSCCG/cjk-fonts-for-ctex) 的最新发行版下载该字体集，与 LaTeX 模板的 `make fonts` 相同。

The script always downloads the `texlive` set (the free fonts of the LaTeX template's `fontset=texlive`), TeX Gyre Termes for Latin text, and Harano Aji Mincho for circled numbers. With a set name (`windows`, `founder`, `adobe`, `fandol`) it also downloads that set from the latest [cjk-fonts-for-ctex](https://github.com/TJ-CSCCG/cjk-fonts-for-ctex) release, as the LaTeX template's `make fonts` does.

然后编译 | Then compile:

```bash
typst compile template/main.typ thesis.pdf --root . --font-path ./fonts
```

## 字体集 | Font sets

`template/main.typ` 中的 `fontset` 选择字体集，与 LaTeX 模板的同名选项对应。

| `fontset`         | 宋体 / 黑体 / 楷体 / 仿宋                                                   | 粗体     |
| ----------------- | --------------------------------------------------------------------------- | -------- |
| `"auto"`（默认）  | 装有 SimSun 时同 `windows`，否则同 `texlive`                                | 描边模拟 |
| `"windows"`       | SimSun / SimHei / KaiTi / FangSong（Word 模板所用的中易字体）               | 描边模拟 |
| `"texlive"`       | LXGW Neo ZhiSong / LXGW Neo XiHei / AR PL KaitiM GB / LXGW Zhuque Fangsong | 描边模拟 |
| `"founder"`       | 方正书宋 / 方正黑体 / 方正楷体 / 方正仿宋                                   | 描边模拟 |
| `"adobe"`         | Adobe Song Std / Adobe Heiti Std / Adobe Kaiti Std / Adobe Fangsong Std     | 描边模拟 |
| `"mac"`           | Songti SC / Heiti SC / Kaiti SC / STFangsong（macOS 自带）                  | 真粗体   |
| `"fandol"`        | FandolSong / FandolHei / FandolKai / FandolFang（作者已撤回，仅为旧稿保留） | 真粗体   |

没有粗体字形的字体，粗体按 Word 加粗宋体的方式以字号 1/35 的描边模拟，与 LaTeX 模板的 `AutoFakeBold=2.86` 相同。`"auto"` 只检测 SimSun：未安装时，每次编译会给出一条 `unknown font family: simsun` 警告，对应 LaTeX 模板“fontset=auto chose texlive”的提示；运行 `./fonts/download-fonts.sh windows` 或指定 `fontset: "texlive"` 即可消除。

`fontset` picks the font set, matching the LaTeX template's option. Fonts without a bold face get bold text stroked at 1/35 of the font size, as Word bolds SimSun and as the LaTeX template's `AutoFakeBold=2.86` does. `"auto"` probes only for SimSun: without it, each build reports one `unknown font family: simsun` warning, the counterpart of the LaTeX template's "fontset=auto chose texlive" message. Download the Windows set or set `fontset: "texlive"` to silence it.

## Typst Web App

把所需字体文件上传到项目中任意文件夹即可，Web App 会自动加载项目中的字体。

Upload the font files to any folder of the project; the web app loads fonts from the project.
