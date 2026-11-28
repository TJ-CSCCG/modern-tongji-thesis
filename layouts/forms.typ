// The three forms of the graduation project, ported from the LaTeX template's
// doctype=taskbook|proposal|midterm (\MakeTaskBook, \MakeProposal,
// \MakeMidterm and the \tjform* commands): 毕业设计（论文）任务书, 开题报告 and
// 中期报告. Each is its own document (template/taskbook.typ, proposal.typ,
// midterm.typ) sharing chapters/metadata.typ with the thesis. Positions are
// those of the LaTeX template's PDFs, in pt from the page edges of an A4 page.
#import "../utils/fonts.typ": *
#import "../utils/helpers.typ": blind-state
#import "info-page.typ": tj-checkbox
#import "@preview/cuti:0.4.0": show-cn-fakebold

#let _form-titles = (taskbook: "任务书", proposal: "开题报告", midterm: "中期报告")
#let _note-gray = rgb("#ADADAD")
#let _hint-gray = rgb("#747474")

// Text whose baseline sits at the top of its box.
#let _on-baseline(body) = box(text(top-edge: "baseline", bottom-edge: "baseline", body))

// A fixed-width underline with its content centered, empty when there is none.
#let form-line(width, body: none) = box(
  width: width, outset: (bottom: 3.26pt), stroke: (bottom: 0.4pt), align(center, body),
)

// 年 / 月 / 日 blanks.
#let form-date-blank() = [#form-line(3em)~年~#form-line(2em)~月~#form-line(2em)~日]

// 一级小节标题：四号黑体，缩进 2 字符，前空一行、后空半行。
#let form-section(body) = block(above: 46.8pt - TJFONT_HEADING, below: 35.1pt - TJFONT_BODY, sticky: true, context {
  set par(first-line-indent: 0pt)
  text(font: thesis-fonts.get().hei, size: TJFONT_HEADING, h(2em) + body)
})

// 二级小节标题：小四号黑体，缩进 2 字符，前后各空半行。
#let form-subsection(body) = block(above: 35.1pt - TJFONT_BODY, below: 35.1pt - TJFONT_BODY, sticky: true, context {
  set par(first-line-indent: (amount: 2em, all: true))
  text(font: thesis-fonts.get().hei, body)
  parbreak()
})

// 说明性文字（成稿删除），浅灰。
#let form-note(body) = {
  text(fill: _note-gray, body)
  parbreak()
}

// 提示性文字（内容提示，不删除），深灰。
#let form-hint(body) = {
  text(fill: _hint-gray, body)
  parbreak()
}

// 审核意见框内的字段标签，小四黑体。
#let form-label(body) = context text(font: thesis-fonts.get().hei, body)

// 右对齐的签字行：签名标签 + 定宽下划线 + 日期填空，整行黑体。
#let form-signature(label, width: 8em, size: TJFONT_BODY) = context {
  // The space the LaTeX flushright environment adds above the line
  v(12.95pt)
  align(right, text(
  font: thesis-fonts.get().hei, size: size,
  [#label：#form-line(width)#h(2em)#form-date-blank()],
))
}

// 居中的说明性大标题（中期报告首页的“填写说明”）：小二黑体加粗。
#let form-notice(body) = {
  // Three blank lines above and two below, with the space the LaTeX center
  // environment adds around the title
  v(3 * TJ_LINE_PITCH + 19.4pt)
  context align(center, text(font: thesis-fonts.get().hei, size: font-size.at("-2"), weight: "bold", body))
  v(2 * TJ_LINE_PITCH + 12.95pt)
}

// 说明正文：四号，编号列表的各项悬挂于 2 字符缩进处。
#let form-notice-body(..items) = {
  set text(size: TJFONT_HEADING)
  set par(first-line-indent: 0pt, leading: 27.3pt - TJFONT_HEADING, spacing: 27.3pt - TJFONT_HEADING)
  for (i, item) in items.pos().enumerate() {
    pad(left: 2em, par[#(i + 1).#h(0.5em)#item])
  }
}

// 审核意见方框：小四，内含标签、提示、留白与签字行。
#let review-box(body) = block(above: 24.85pt, below: 24.85pt, breakable: false, pad(left: 2pt, block(
  width: 100%, inset: (x: 3.2pt, top: 1.07pt, bottom: 6.2pt), stroke: 0.4pt, {
    set par(first-line-indent: 0pt)
    body
  },
)))

// 同意 / 不同意 复选框：decision 为 "agree" 或 "disagree" 时打勾，none 时均留空。
#let form-decision(decision) = [
  #tj-checkbox(decision == "agree")~同#h(0.25em)意#h(2em)#tj-checkbox(decision == "disagree")~不#h(0.25em)同#h(0.25em)意
]

// Weeks between two dates, rounded up, as the LaTeX \taskbookperiod counts them.
#let _weeks(start, end) = calc.ceil(((end - start).days() + 1) / 7)

// The cover's subject table: one row per field, labels spread over four
// characters, values centered over a 20 em underline, rows 43.68 pt apart.
#let _subject-table(fields) = {
  let size = TJFONT_HEADING
  let label-width = 5em
  let cell-width = 22em
  let value-width = 20em
  let gutter = 16pt
  let row(label, value) = context {
    let row-above = 30.58pt
    let value-box = box(width: value-width, {
      set par(leading: 13.44pt - 1em, justify: false, first-line-indent: 0pt)
      align(center, value)
    })
    let above = calc.max(row-above, measure(value-box).height - 0.172em.to-absolute())
    block(width: 100%, height: above + 13.1pt, above: 0pt, below: 0pt, {
      let x0 = (100% - label-width - gutter - cell-width) / 2
      let x1 = x0 + label-width + gutter + (cell-width - value-width) / 2
      let chars = label.clusters()
      place(top + left, dx: x0, dy: above, box(width: label-width, align(center, _on-baseline(
        box(width: 4em, chars.join(h(1fr))),
      ))))
      place(top + left, dx: x1, dy: above - measure(value-box).height, value-box)
      place(top + left, dx: x1, dy: above + 3.26pt, line(length: value-width, stroke: 0.4pt))
    })
  }
  set text(size: size)
  for i in range(0, fields.len(), step: 2) {
    row(fields.at(i), fields.at(i + 1))
  }
}

// A form document. `doctype` is "taskbook", "proposal" or "midterm"; the
// other fields come from chapters/metadata.typ. The advisor is never printed:
// every form leaves the advisor's signature to be written by hand.
#let form(
  doctype: "taskbook",
  school: "", major: "", id: "", student: "", title: "", subtitle: "",
  field: "science", fontset: "auto",
  // Task book: the start and end dates; the weeks are counted from them.
  taskbook-start: none, taskbook-end: none,
  // Midterm report: "agree" or "disagree" ticks a box, none leaves both blank.
  midterm-decision: none,
  body,
) = context {
  assert(doctype in _form-titles, message: "doctype must be \"taskbook\", \"proposal\" or \"midterm\", got " + repr(doctype))
  let ff = resolve-fonts(fontset)
  thesis-fonts.update(ff)
  blind-state.update(false)
  // The title's parentheses are half-width so the 小初 title fits one line,
  // with a quarter em on each side as xeCJK spaces them in the LaTeX template.
  let header-text = if field == "humanities" { [毕业论文#h(0.25em);(设计)#h(0.25em)] } else { [毕业设计#h(0.25em);(论文)#h(0.25em)] }

  let plain-header = if field == "humanities" { "毕业论文(设计)" } else { "毕业设计(论文)" }
  set document(author: id + " " + student, title: title + " " + plain-header + _form-titles.at(doctype))
  set page(paper: "a4", margin: (top: 2.3cm, bottom: 1.0cm, x: 3.17cm))
  set text(TJFONT_BODY, font: ff.song, lang: "zh", region: "cn", top-edge: 1em, bottom-edge: "baseline")
  set par(
    justify: true, first-line-indent: (amount: 2em, all: true),
    leading: TJ_LINE_PITCH - TJFONT_BODY, spacing: TJ_LINE_PITCH - TJFONT_BODY,
  )
  show: it => if ff.bold { it } else { show-cn-fakebold(it, stroke: TJ_FAKEBOLD_STROKE) }

  // Cover: logo, title, subject table, then the dates and signatures (task
  // book) or the date (proposal, 四号; midterm, 三号) at the bottom.
  {
    set par(first-line-indent: 0pt, justify: false)
    v(60.93pt)
    align(center, image("../figures/tongji.svg", height: 1.7cm))
    v(215.66pt - 174.56pt + 0.24pt - TJFONT_COVER, weak: true)
    align(center, text(font: ff.hei, size: TJFONT_COVER, header-text + _form-titles.at(doctype)))
    // The table's first row sits lower on the proposal and midterm covers.
    v(if doctype == "taskbook" { 82.62pt } else { 90.52pt }, weak: true)
    _subject-table(("课题名称", title, "副标题", subtitle, "学院", school, "专业", major, "学生姓名", student, "学号", id))
    set text(size: TJFONT_HEADING)
    if doctype == "taskbook" {
      let start = taskbook-start
      let end = taskbook-end
      let number(width, date, part) = form-line(width, body: if date != none { str(part(date)) })
      v(629.76pt - 550.51pt - 13.1pt - TJFONT_HEADING + 3.26pt, weak: true)
      align(center)[#header-text;起讫时间]
      v(34.29pt - TJFONT_HEADING, weak: true)
      let weeks = if start != none and end != none { _weeks(start, end) }
      align(center)[自~#number(2.4em, start, d => d.year())~年~#number(1.5em, start, d => d.month())~月~#number(1.5em, start, d => d.day())~日至~#number(2.4em, end, d => d.year())~年~#number(1.5em, end, d => d.month())~月~#number(1.5em, end, d => d.day())~日共~#number(1.5em, weeks, w => w)~周]
      v(1fr)
      // Signature rows 43.68 pt apart, the last baseline 60.67 pt above the
      // bottom margin. The hidden character gives the empty underline a line
      // of text to sit on, so it lines up with the labels.
      let signature-line = [#hide[字]#h(-1em)#form-line(8.6em)]
      align(center, grid(
        columns: (7em, 8.6em, 11.5em), column-gutter: 4pt, row-gutter: 43.68pt - TJFONT_HEADING, align: center,
        [指导教师签名], signature-line, form-date-blank(),
        [教学院长签名], signature-line, form-date-blank(),
      ))
      v(60.67pt)
    } else {
      v(1fr)
      let size = if doctype == "midterm" { font-size.at("3") } else { TJFONT_HEADING }
      align(center, text(size: size, form-date-blank()))
      v(if doctype == "midterm" { 53.69pt } else { 53.25pt })
    }
  }
  pagebreak()
  // A heading at the top of a page sits as high as TeX's \topskip puts it.
  v(-2.05pt)

  // Body pages: no header, footer or binding line; the content is the
  // writer's, set with form-section, form-hint and the other commands here.
  state("tongji-midterm-decision").update(midterm-decision)
  body
}

// The midterm decision given to form(), for the review box.
#let midterm-decision() = context form-decision(state("tongji-midterm-decision").get())
