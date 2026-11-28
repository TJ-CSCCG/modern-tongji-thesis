#import "../utils/fonts.typ": TJFONT_INFO, TJFONT_HEADING, TJFONT_BODY

// 复选框：与汉字等宽等高的方框，勾选时内含对勾。
#let tj-checkbox(checked) = box(
  width: 0.95em, height: 0.95em, baseline: 0.1em, stroke: 0.5pt,
  // The check mark comes from the math font, which every font set has.
  if checked { align(center + horizon, text(size: 0.62em, $checkmark$)) },
)

// 定宽下划线，内容居中；内容为空时为纯下划线。
#let tj-underline(width, body) = box(
  width: width, outset: (bottom: 2.94pt), stroke: (bottom: 0.78pt), align(center, body),
)

// Info page — matches the LaTeX \MakeInfoPage: the title in 三号 黑体, then
// the fields in 四号 宋体 28 pt apart, each field 0.5 em below the one before;
// the content summary in 小四 18 pt apart.
#let make-info-page(
  title: "", subtitle: "", school: "", major: "", infotype: "thesis",
  infoabstract: "", infodrawings: "", infowordcount: "", infothesiswords: "",
  infomaterials: (), header-text: "毕业设计（论文）", fonts: none,
) = {
  let f = fonts
  // The title's baseline 13.25 pt below the text area, as in the LaTeX template
  v(13.25pt - TJFONT_INFO)
  align(center, text(font: f.hei, size: TJFONT_INFO)[同济大学本科#header-text;信息说明页])
  // \vspace{1em} below the LaTeX center environment, which adds its own space
  v(17.98pt)

  set text(font: f.song, size: TJFONT_HEADING)
  set par(first-line-indent: 0pt, justify: true, leading: 28pt - 1em, spacing: 28pt - 1em + 0.5em)

  // 课题名称：标题（含副标题）换行后与冒号后的第一个字对齐
  let full-title = if subtitle not in ("", none) { [#title——#subtitle] } else { title }
  grid(columns: (5em, 1fr), row-gutter: 0pt, [课题名称：], full-title)

  let is-design = infotype in ("design", "engineering")
  par[成果类型：#tj-checkbox(is-design)#h(1em / 6)毕业设计#h(1em)#tj-checkbox(not is-design)#h(1em / 6)毕业论文]

  par[学科专业：#major]

  par[内容简述（请用300字以内简要概述）：]
  block(above: 8.78pt, {
    set text(size: TJFONT_BODY)
    set par(first-line-indent: (amount: 2em, all: true), leading: 18pt - 1em, spacing: 18pt - 1em)
    // The break makes even a one-paragraph summary a paragraph, so it is indented.
    infoabstract
    parbreak()
  })

  if is-design {
    par[毕业设计：主要图纸~#tj-underline(4em, infodrawings)~张，正文总字数~#tj-underline(6em, infowordcount)~字]
  } else {
    par[毕业论文：正文总字数~#tj-underline(6em, infothesiswords)~字]
  }

  par[随附资料：]
  if infomaterials.len() > 0 {
    block(above: 28pt - 1em, below: 30.4pt - 1em, {
      set par(spacing: 30.8pt - 1em)
      for (i, m) in infomaterials.enumerate() {
        par[#(i + 1).#h(0.5em)#m]
      }
    })
  } else {
    v(28pt)
  }

  par[（请列出所有提交的支撑材料名称，如：毕业设计-全套图纸、毕业作品、计算书、程序代码、附录等）]
}
