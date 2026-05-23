#import "@preview/i-figured:0.2.2"
#import "@preview/tablex:0.0.9": cellx, tablex, gridx, hlinex, vlinex, colspanx, rowspanx
#import "@preview/algo:0.3.5": algo, i, d, comment, code
#import "@preview/gb7714-bilingual:0.2.3": multicite

#import "utils.typ": *

// Three-line table rules (booktabs-style, compatible with tablex)
#let heavyrulewidth = .08em
#let lightrulewidth = .05em
#let cmidrulewidth = .03em

#let toprule(stroke: heavyrulewidth) = { hlinex(stroke: stroke) }
#let midrule(stroke: lightrulewidth) = { hlinex(stroke: stroke) }
#let bottomrule(stroke: heavyrulewidth) = { hlinex(stroke: stroke) }
#let cmidrule(start: 0, end: -1, stroke: cmidrulewidth) = { hlinex(start: start, end: end, stroke: stroke) }

#let draw-binding() = {
  place("|", dx: -1.6cm, dy: 2.3cm)
  place("|", dx: -1.6cm, dy: 2.9cm)
  place("|", dx: -1.6cm, dy: 3.5cm)
  place("|", dx: -1.6cm, dy: 4.1cm)
  place("|", dx: -1.6cm, dy: 4.7cm)
  place("|", dx: -1.6cm, dy: 5.3cm)
  place("|", dx: -1.6cm, dy: 5.9cm)
  place("|", dx: -1.6cm, dy: 6.5cm)
  place("|", dx: -1.6cm, dy: 7.1cm)
  place("|", dx: -1.6cm, dy: 7.7cm)
  place("装", dx: -1.8cm, dy: 8.3cm)
  place("|", dx: -1.6cm, dy: 8.9cm)
  place("|", dx: -1.6cm, dy: 9.5cm)
  place("|", dx: -1.6cm, dy: 10.1cm)
  place("|", dx: -1.6cm, dy: 10.7cm)
  place("|", dx: -1.6cm, dy: 11.3cm)
  place("订", dx: -1.8cm, dy: 11.9cm)
  place("|", dx: -1.6cm, dy: 12.5cm)
  place("|", dx: -1.6cm, dy: 13.1cm)
  place("|", dx: -1.6cm, dy: 13.7cm)
  place("|", dx: -1.6cm, dy: 14.3cm)
  place("|", dx: -1.6cm, dy: 14.9cm)
  place("线", dx: -1.8cm, dy: 15.5cm)
  place("|", dx: -1.6cm, dy: 16.1cm)
  place("|", dx: -1.6cm, dy: 16.7cm)
  place("|", dx: -1.6cm, dy: 17.3cm)
  place("|", dx: -1.6cm, dy: 17.9cm)
  place("|", dx: -1.6cm, dy: 18.5cm)
  place("|", dx: -1.6cm, dy: 19.1cm)
  place("|", dx: -1.6cm, dy: 19.7cm)
  place("|", dx: -1.6cm, dy: 20.3cm)
  place("|", dx: -1.6cm, dy: 20.9cm)
  place("|", dx: -1.6cm, dy: 21.5cm)
}

#let empty-par() = {
  v(-1.2em)
  box()
}

#let make-cover(cover, cover-text: "毕业设计（论文）", fonts: none) = {
  let f = if fonts != none { fonts } else { font-family }
  align(center)[
  #image("figures/tongji.svg", height: 2.5cm)
  #text(
    "TONGJI UNIVERSITY",
    font: f.hei,
    size: font-size.at("-2"),
    weight: "bold",
  )

  #v(30pt)
  #text(cover-text, font: f.hei, size: font-size.at("-0"))
  #v(60pt)

  #set text(font: f.hei, size: font-size.at("-2"))
  #grid(
    columns: (5em, auto),
    gutter: 16pt,
    ..cover.enumerate().map(((idx, value)) => {
      set text(size: font-size.at("-2"))
      if calc.even(idx) {
        let arr = value.clusters()
        let k = (4 - arr.len()) / (arr.len() - 1)
        arr.join([#h(1em * k)])
      } else {
        block(
          width: 100%,
          inset: 4pt,
          stroke: (bottom: 1pt + black),
          align(center, value),
        )
      }
    }),
  )
]}

#let make-abstract(
  title: "", subtitle: none, abstract: "", keywords: (), prompt: (), is-english: false,
  heading-override: none, fonts: none,
) = {
  let f = if fonts != none { fonts } else { font-family }
  align(center)[
    #v(1em)
    #text(font: f.hei, size: font-size.at("-2"), weight: "bold", title)
    #if subtitle != none and subtitle != "" {
      [
        #v(0.2em)
        #text(font: f.hei, size: font-size.at("3"), weight: "bold", subtitle)
      ]
    }
    #v(1.5em)
  ]
  let h = if heading-override != none { heading-override } else { prompt.at(0) }
  heading(h, numbering: none, outlined: false)

  set par(first-line-indent: 2em)
  abstract
  v(1.0em)
  set par(first-line-indent: 0em)
  text(font: f.hei, weight: "bold", prompt.at(1))
  let keywords-string = if is-english { keywords.join(", ") } else { keywords.join("，") }
  text(keywords-string)
}

#let make-outline(title: "目 录", depth: 3, indent: true) = {
  heading(title, numbering: none, outlined: false)
  set par(first-line-indent: 0pt, leading: 1.2em)
  context {
    let elements = query(heading.where(outlined: true))

    for el in elements {
      if depth != none and el.level > depth { continue }

      let el_number = if el.numbering != none {
        numbering(el.numbering, ..counter(heading).at(el.location()))
        h(0.5em)
      }

      let line = {
        if indent {
          let indent-width = if el.level == 1 {
            0pt
          } else if el.level == 2 {
            2em
          } else if el.level == 3 {
            4em
          } else {
            0pt
          }
          h(indent-width)
        }

        link(el.location(), el_number)
        link(el.location(), el.body)
        box(width: 1fr, repeat[.])
        link(el.location(), str(counter(page).at(el.location()).first()))
        linebreak()
      }

      line
    }
  }
}

#let make-info-page(
  title: "", subtitle: "", school: "", major: "", infotype: "thesis",
  infoabstract: "", infodrawings: "", infowordcount: "", infothesiswords: "",
  infomaterials: (), header-text: "毕业设计（论文）", fonts: none,
) = {
  let f = if fonts != none { fonts } else { font-family }
  set align(center)
  text(font: f.hei, size: font-size.at("3"))[同济大学本科#header-text 信息说明页]
  v(1em)

  set align(left)
  set par(first-line-indent: 0pt, leading: 1.2em)
  set text(font: f.song, size: font-size.at("4"))

  let field-line(key, value) = {
    [#key： #value]
    v(0.5em)
  }

  // 课题名称: title — subtitle
  field-line("课题名称", {
    let t = title
    if subtitle != "" { t = t + "——" + subtitle }
    t
  })

  // 成果类型: design and engineering both map to 毕业设计
  let is-design = (infotype == "design" or infotype == "engineering")
  let check-box(w: 0.8em, h: 0.8em, ..body) = box(
    width: w, height: h, stroke: 0.5pt, align(center + horizon, ..body),
    baseline: 0.12em,
  )
  let checked-box = check-box(text(size: 0.8em)[✓])
  let unchecked-box = check-box([])
  field-line("成果类型", {
    if is-design { [#checked-box 毕业设计 #h(2em) #unchecked-box 毕业论文] }
    else { [#unchecked-box 毕业设计 #h(2em) #checked-box 毕业论文] }
  })

  field-line("学科专业", major)

  // 内容简述 (300字以内)
  field-line("内容简述（请用300字以内简要概述）", {
    v(0.2em)
    set text(size: font-size.at("-4"))
    set par(first-line-indent: 2em, leading: 0.65em)
    infoabstract
  })

  let ul-box(w, body) = box(
    width: w, outset: (bottom: 3pt), stroke: (bottom: 0.6pt), align(center, body)
  )

  // 毕业设计 (if design or engineering): 图纸 + 字数
  if is-design {
    let dwg = if infodrawings != "" { ul-box(4em, infodrawings) } else { ul-box(4em, []) }
    let wc = if infowordcount != "" { ul-box(6em, infowordcount) } else { ul-box(6em, []) }
    field-line("毕业设计", [主要图纸 #dwg 张，正文总字数 #wc 字])
  } else {
    let wc = if infothesiswords != "" { ul-box(6em, infothesiswords) } else { ul-box(6em, []) }
    field-line("毕业论文", [正文总字数 #wc 字])
  }

  // 随附资料
  field-line("随附资料", {
    if infomaterials.len() > 0 {
      enum(numbering: n => str(n) + ".", ..infomaterials)
    } else {
      v(0.5em)
      []
    }
  })

  [（请列出所有提交的支撑材料名称，如：毕业设计——全套图纸、毕业作品、计算书、程序代码、附录等）]
}