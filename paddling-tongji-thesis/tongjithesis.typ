#import "elements.typ": *
#import "utils.typ": font-presets
#import "@preview/gb7714-bilingual:0.2.3": init-gb7714-impl, gb7714-bibliography

#set pagebreak(weak: true)

#let newpage(twoside: false) = if twoside { pagebreak(to: "odd") } else { pagebreak() }

#let chinese-numeral(n) = {
  let digits = ("零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十")
  if n <= 10 {
    digits.at(n)
  } else if n < 20 {
    "十" + digits.at(n - 10)
  } else if n < 30 {
    digits.at(calc.quo(n, 10)) + "十" + if calc.rem(n, 10) != 0 { digits.at(calc.rem(n, 10)) }
  } else {
    str(n)
  }
}

#let circled-number(n) = {
  // Dedicated font for circled numbers 1-50 — matching LaTeX's HaranoAjiMincho strategy.
  // Apple SD Gothic Neo (macOS system) and HaranoAjiMincho (TeX Live) have full coverage.
  set text(font: ("Apple SD Gothic Neo", "HaranoAjiMincho"), fallback: true)
  if n >= 1 and n <= 20 {
    "①②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳".clusters().at(n - 1)
  } else if n >= 21 and n <= 35 {
    "㉑㉒㉓㉔㉕㉖㉗㉘㉙㉚㉛㉜㉝㉞㉟".clusters().at(n - 21)
  } else if n >= 36 and n <= 50 {
    "㊱㊲㊳㊴㊵㊶㊷㊸㊹㊺㊻㊼㊽㊾㊿".clusters().at(n - 36)
  } else {
    // >50: TikZ-style circle matching LaTeX — square box + radius:50% = perfect circle
    let w = str(n).len()
    let s = if w <= 2 { 0.65 } else if w == 3 { 0.50 } else { 0.40 }
    box(
      width: 0.93em, height: 0.93em,
      stroke: 0.5pt,
      radius: 50%,
      inset: 0.2pt,
      baseline: 0.1em,
      align(center + horizon, scale(x: s * 100%, y: s * 100%, text(size: 1em, str(n)))),
    )
  }
}

// Bibliography — matches LaTeX \defbibenvironment (0.74cm min label, right-aligned)
#let makereferences() = {
  heading(level: 1, numbering: none, outlined: true)[参考文献]
  gb7714-bibliography(title: none, full-control: entries => {
    context {
      // Label width: max(0.74cm, width of widest label "[N]")
      let widest = entries.fold(0, (acc, e) => if e.order > acc { e.order } else { acc })
      let label-w = measure("[" + str(widest) + "]").width + 4pt
      if label-w < 0.74cm { label-w = 0.74cm }

      for e in entries {
        grid(
          columns: (label-w, 1fr),
          align(right + top, "[" + str(e.order) + "]"),
          e.labeled-rendered,
        )
        parbreak()
      }
    }
  })
}

// Appendix — matches LaTeX
#let appendix(humanities: false, body) = {
  heading(level: 1, numbering: none, outlined: true)[附录]
  set heading(numbering: (..nums) => {
    let pos = nums.pos()
    let lv = pos.len()
    let letter(n) = numbering("A", n)
    if humanities {
      if lv == 2 { "（" + letter(pos.at(1)) + "）" }
      else if lv == 3 { str(pos.at(2)) + "." }
    } else {
      if lv == 2 { letter(pos.at(1)) + "." }
      else if lv == 3 { letter(pos.at(1)) + "." + str(pos.at(2)) }
    }
  })
  counter(heading).update(1)

  // Reset appendix figure/table counters at each H2 section
  show heading: it => {
    if it.level == 2 {
      counter(figure.where(kind: table)).update(0)
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: raw)).update(0)
      counter(figure.where(kind: "algo")).update(0)
    }
    it
  }

  // Appendix figure/table numbering: letter-based per-kind (A.1, A.2; 表 A.1, 表 A.2 …)
  show figure: it => {
    if it.numbering != none { it } else {
      let suppl = if it.kind == table { [表] } else if it.kind == image { [图] } else if it.kind == raw { [代码] } else { it.supplement }
      context {
        let hc = counter(heading).get()
        let sec = hc.at(1, default: 1)
        let letter = numbering("A", sec)
        figure(
          it.body,
          kind: it.kind,
          supplement: suppl,
          caption: it.caption,
          numbering: n => letter + "." + str(n),
        )
      }
    }
  }

  body
}

// Cross-reference convenience commands
#let chapref(label) = [第@label章]
#let secref(label) = [第@label节]
#let figref(label) = [图@label]
#let tabref(label) = [表@label]
#let eqref(label) = [式@label]
#let algoref(label) = [算法@label]

// Word count (auto-tracked, CJK characters)
#let wordcount() = context state("total-words-cjk").final()

// Theorem render — title + body inline (same paragraph), matching SJTUThesis & LaTeX
#let thm-render(prefix: none, title: "", full-title: auto, body) = {
  if full-title != "" {
    strong[#full-title] + sym.space
  }
  body
}

// Proof render — inline QED, matching SJTUThesis
#let pf-render(prefix: none, title: "", full-title: auto, body) = {
  strong[证明] + sym.space + body + box(width: 0em) + h(1fr) + sym.wj + $square$
}

// Theorem environments — module-level so chapter files can access them.
// Each type has an independent counter, matching LaTeX's \newtheorem{}.
#let (thm-ctr, thm-box, thm, show-thm) = make-frame(
  "theorem", theorion-i18n-map.at("theorem"), inherited-levels: 1, render: thm-render,
)
#let (cor-ctr, cor-box, cor, show-cor) = make-frame(
  "corollary", theorion-i18n-map.at("corollary"), inherited-levels: 1, render: thm-render,
)
#let (lem-ctr, lem-box, lem, show-lem) = make-frame(
  "lemma", theorion-i18n-map.at("lemma"), inherited-levels: 1, render: thm-render,
)
#let (prop-ctr, prop-box, prop, show-prop) = make-frame(
  "proposition", theorion-i18n-map.at("proposition"), inherited-levels: 1, render: thm-render,
)
#let (conj-ctr, conj-box, conj, show-conj) = make-frame(
  "conjecture", theorion-i18n-map.at("conjecture"), inherited-levels: 1, render: thm-render,
)
#let (assume-ctr, assume-box, assume, show-assume) = make-frame(
  "assumption", theorion-i18n-map.at("assumption"), inherited-levels: 1, render: thm-render,
)
#let (dfn-ctr, dfn-box, dfn, show-dfn) = make-frame(
  "definition", theorion-i18n-map.at("definition"), inherited-levels: 1, render: thm-render,
)
#let (exmp-ctr, exmp-box, exmp, show-exmp) = make-frame(
  "example", theorion-i18n-map.at("example"), inherited-levels: 1, render: thm-render,
)
#let (rem-ctr, rem-box, rem, show-rem) = make-frame(
  "remark", theorion-i18n-map.at("remark"), inherited-levels: 1, render: thm-render,
)
#let (pf-ctr, pf-box, pf, show-pf) = make-frame(
  "proof", theorion-i18n-map.at("proof"), render: pf-render,
)

#let thesis(
  school: "某学院", major: "某专业", id: "0000000", student: "某某某", advisor: "某某某", title: "某标题", subtitle: "某副标题", title-english: "Some Title", subtitle-english: "Some Subtitle", date: datetime.today(), abstract: "慧枫尚萍氢，驳展妙棚端梦称委竞励。绘象臂淬人壳闭营风混仓、问抬兽村蜡胡锹挤污艰烃伏惧派宝既抓章住蓟棒褶均谭穿谴属；羟贮银…钓郭曾牙记氢硝巍仰蒲邀趟。革旅剑撞压单施宵饼狼将售烷贸问术粮洞魔。却烟陕倍且隘框糟秩板商，宙刚疮顿表羽楞景哺驯邮戒歌溜著聪峻忙劈左绩卖卫萨讯完读百釉好仔帜纽龟玉炒脂衍蛴瓦副冯查索桐梁；轴派？蝗丸朝保岂搅搞燕挫品休礼倾玻黑李宽列邮苦仔汛鳙物己弱寸栓孝哄俭牙敬厄搬吨楞干捧原趋息…善！", keywords: ("关键词1", "关键词2", "关键词3"), abstract-english: lorem(300), keywords-english: ("Keyword1", "keyword2", "keyword3"), doc,
  field: "science",
  fontset: "fandol",
  // Info page
  infotype: "thesis", infoabstract: "", infodrawings: "", infowordcount: "", infothesiswords: "", infomaterials: (),
  // Abstract titles (defaults to thesis title)
  abstract-title: none, abstract-subtitle: none, abstract-title-english: none, abstract-subtitle-english: none,
  // Bibliography
  bib-content: none,
  // Twoside
  twoside: false,
) = {
  let is-humanities = (field == "humanities")
  let cover-text = if is-humanities { "毕业论文（设计）" } else { "毕业设计（论文）" }
  let header-text = cover-text

  // Apply fontset
  let p = font-presets.at(fontset)
  let ff = (
    song: p.song,
    hei: p.hei,
    kai: p.kai,
    fang: p.fang,
    xiaobiaosong: p.song,
    xihei: p.hei,
    code: ("DejaVu Sans Mono", "Fira Code"),
    math: ("New Computer Modern Math",),
  )
  set document(author: id + " " + student, title: title)
  let page-margin = if twoside {
    (top: 4.0cm, bottom: 2.7cm, inside: 3.3cm, outside: 1.8cm)
  } else {
    (top: 4.0cm, bottom: 2.7cm, left: 3.3cm, right: 1.8cm)
  }
  set page(
    paper: "a4", margin: page-margin, binding: left,
  )
  set text(TJFONT_BODY, font: ff.song, lang: "zh", region: "cn")

  make-cover(
    (
      "课题名称", title, "副标题", subtitle, "学院", school, "专业", major, "学生姓名", student, "学号", id, "指导教师", advisor, "日期", date.display("[year]年[month]月[day]日"),
    ),
    cover-text: cover-text,
    fonts: ff,
  )
  newpage(twoside: twoside)

  make-info-page(
    title: title, subtitle: subtitle, school: school, major: major,
    infotype: infotype, infoabstract: infoabstract, infodrawings: infodrawings,
    infowordcount: infowordcount, infothesiswords: infothesiswords,
    infomaterials: infomaterials, header-text: header-text, fonts: ff,
  )
  newpage(twoside: twoside)

  set par(justify: true, first-line-indent: (amount: 2em, all: true), leading: 1.2em, spacing: 1.2em)
  set par(justification-limits: (tracking: (min: -0.01em, max: 0.02em)), linebreaks: "optimized")
  show strong: it => text(font: ff.hei, it.body)
  show emph: it => text(font: ff.kai, style: "italic", it.body)
  show raw: set text(font: ff.code)
  show math.equation: set text(font: ff.math)
  // Display math spacing: 0pt above/below (official spec)
  show math.equation.where(block: true): it => v(0pt) + it + v(0pt)
  set underline(offset: 3pt, stroke: 0.6pt)
  // Circled number footnotes
  set footnote(numbering: n => circled-number(n))
  // Lists: enumerate L1 uses （1）full-width parens, itemize indents match paragraph
  set enum(numbering: n => "（" + str(n) + "）", indent: 2em, spacing: 1.2em)
  set list(indent: 2em, spacing: 1.2em)

  // Cross-reference formatting — "第 X 章" / "第 X 节" pattern
  show ref: it => {
    if it.element != none and it.element.func() == heading {
      let h = it.element
      if h.numbering != none {
        let n = numbering(h.numbering, ..counter(heading).at(h.location()))
        let lv = h.level
        let prefix = if lv == 1 { "第" + n + "章" } else if lv == 2 { "第" + n + "节" } else if lv == 3 { "第" + n + "小节" } else { none }
        if prefix != none { link(h.location(), prefix) } else { it }
      } else { it }
    } else {
      it
    }
  }

  set heading(numbering: (..nums) =>
    if is-humanities {
      let pos = nums.pos()
      if pos.len() == 1 {
        chinese-numeral(pos.at(0)) + "、"
      } else if pos.len() == 2 {
        "（" + chinese-numeral(pos.at(1)) + "）"
      } else if pos.len() == 3 {
        str(pos.at(2)) + "."
      } else if pos.len() == 4 {
        "（" + str(pos.at(3)) + "）"
      } else if pos.len() == 5 {
        circled-number(pos.at(4))
      } else {
        pos.map(str).join(".")
      }
    } else {
      if nums.pos().len() <= 3 {
        nums.pos().map(str).join(".")
      } else if nums.pos().len() == 4 {
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ".at(nums.pos().at(-1) - 1) + "."
      } else if nums.pos().len() == 5 {
        "abcdefghijklmnopqrstuvwxyz".at(nums.pos().at(-1) - 1) + "."
      }
    }
  )

  show heading: it => context {
    set par(first-line-indent: 0pt)
    if it.level == 1 {
      set align(center)
      let heading-size = if it.numbering != none { TJFONT_CHAPTER } else { TJFONT_HEADING }
      set text(font: ff.hei, size: heading-size, weight: "regular")
      v(16pt)
      if it.numbering != none {
        numbering(it.numbering, ..counter(heading).get())
        h(0.6em)
        it.body
      } else {
        it.body
      }
      v(0.6em)
    } else if it.level == 2 {
      set text(font: ff.hei, size: TJFONT_BODY, weight: "regular")
      v(0.6em)
      if it.numbering != none {
        numbering(it.numbering, ..counter(heading).get())
        h(0.6em)
        it.body
      } else {
        it.body
      }
      v(0.6em)
    } else if it.level == 3 {
      set text(font: ff.hei, size: TJFONT_BODY, weight: "regular")
      v(0.6em)
      if it.numbering != none {
        h(2em)
        numbering(it.numbering, ..counter(heading).get())
        h(0.6em)
        it.body
      } else {
        h(2em)
        it.body
      }
      v(0.6em)
    } else if it.level == 4 {
      set text(font: ff.hei, size: TJFONT_BODY, weight: "regular")
      v(0.6em)
      if it.numbering != none {
        h(2em)
        numbering(it.numbering, ..counter(heading).get())
        h(0.6em)
        it.body
      } else {
        h(2em)
        it.body
      }
      v(0.6em)
    } else if it.level == 5 {
      set text(font: ff.hei, size: TJFONT_BODY, weight: "regular")
      v(0.6em)
      if it.numbering != none {
        h(2em)
        numbering(it.numbering, ..counter(heading).get())
        h(0.6em)
        it.body
      } else {
        h(2em)
        it.body
      }
      v(0.6em)
    } else {
      it
    }
  }

  // Theorem environments — matching LaTeX's independent per-type counters
  set-inherited-levels(1)
  set-theorion-numbering("1.1")
  set-qed-symbol[#sym.wj]

  show: show-thm
  show: show-cor
  show: show-lem
  show: show-prop
  show: show-conj
  show: show-assume
  show: show-dfn
  show: show-exmp
  show: show-rem
  show: show-pf

  show list: it => it
  show enum: it => it
  // Figure auto-center + float spacing matching official spec
  // Skip theorem-kind figures (handled by theorion)
  show figure: it => {
    let thm-kinds = ("theorem", "lemma", "corollary", "proposition", "conjecture", "assumption", "definition", "example", "remark", "proof")
    if it.kind in thm-kinds { it }
    else { set align(center); v(1.2em) + it + v(1.2em) }
  }
  show figure: set block(breakable: true)
  show table: it => it
  show math.equation.where(block: true): it => it
  show raw.where(block: true): it => it

  // Code blocks: line numbers, frame, tab size, smaller font
  show raw.where(block: true): it => {
    set text(size: TJFONT_TABLE)
    set par(leading: 0.8em)
    block(
      fill: luma(250),
      inset: 10pt,
      radius: 4pt,
      stroke: 0.5pt + luma(200),
      it
    )
  }

  // Captions: 五号(10.5pt) 宋体, no indent
  show figure.caption: it => {
    set text(font: ff.song, size: TJFONT_CAPTION)
    set par(first-line-indent: 0pt)
    it
  }

  // Table text: 小五号(9pt)
  show figure.where(kind: table): it => {
    set text(size: TJFONT_TABLE)
    it
  }

  show heading: it => {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(figure.where(kind: "algo")).update(0)
    it
  }
  set figure(numbering: n => context {
    let ch = counter(heading).get().first()
    str(ch) + "." + str(n)
  })
  show math.equation.where(block: true): set math.equation(numbering: n => context {
    let ch = counter(heading).get().first()
    numbering("(1.1)", ch, n)
  })
  show figure.where(kind: table): set figure.caption(position: top)

  let make-page-header() = context {
    let is-odd = calc.rem(counter(page).get().first(), 2) != 0
    let flip = twoside and not is-odd
    set text(font: ff.song, size: TJFONT_BODY)
    let a = image("figures/tongji-header.svg", height: 1.14cm)
    let b = align(horizon, block(height: 1.14cm, align(center + horizon, text(font: ff.song, size: TJFONT_BODY, header-text))))
    let (logo, label) = if flip { (b, a) } else { (a, b) }
    let (cl, cr) = if flip { (0.5em, 1cm) } else { (1cm, 0.5em) }
    grid(
      columns: (cl, 1fr, auto, cr), [],
      logo,
      label,
      [],
    )
    v(-0.5em)
    block(width: 100%, height: 1.5pt, stroke: (top: 0.5pt, bottom: 0.5pt))
    draw-binding(twoside: twoside)
  }

  set page(
    margin: page-margin, binding: left,
    numbering: "I", header: make-page-header(), header-ascent: 20%, footer: context {
      set align(center)
      set text(font: ff.song, size: TJFONT_BODY)
      numbering("I", counter(page).get().first())
    },
  )
  counter(page).update(1)

  let cn-title = if abstract-title != none { abstract-title } else { title }
  let cn-subtitle = if abstract-subtitle != none { abstract-subtitle } else { subtitle }
  let en-title = if abstract-title-english != none { abstract-title-english } else { title-english }
  let en-subtitle = if abstract-subtitle-english != none { abstract-subtitle-english } else { subtitle-english }
  let cn-heading = if infotype == "engineering" { "设计总说明" } else { "摘" + h(0.5em) + "要" }

  make-abstract(
    title: cn-title, subtitle: cn-subtitle, abstract: abstract, keywords: keywords,
    prompt: (cn-heading, "关键词："), heading-override: cn-heading, fonts: ff,
  )
  pagebreak()

  make-abstract(
    title: en-title, subtitle: en-subtitle, abstract: abstract-english, keywords: keywords-english,
    prompt: ("ABSTRACT", "Key words: "), is-english: true, fonts: ff,
  )
  pagebreak()

  make-outline()
  newpage(twoside: twoside)

  set page(margin: page-margin, binding: left, numbering: "1", header: make-page-header(), header-ascent: 20%, footer: context {
    line(stroke: 1.8pt, length: 100%)
    set text(font: ff.song, size: TJFONT_BODY)
    v(-0.6em)
    let is-odd = calc.rem(counter(page).get().first(), 2) != 0
    let swap = twoside and not is-odd
    if swap {
      set align(left)
      [
        第#h(1em)
        #counter(page).display()
        #h(1em)页#h(1em)
        共#h(1em)
        #counter(page).final().at(0)#h(1em)
        页
      ]
    } else {
      set align(right)
      [
        共#h(1em)
        #counter(page).final().at(0)#h(1em)
        页#h(1em)
        第#h(1em)
        #counter(page).display()
        #h(1em)页
      ]
    }
  })
  counter(page).update(1)

  // Initialize bibliography if bib-content provided
  let body-with-bib = if bib-content != none {
    init-gb7714-impl(bib-content, style: "numeric", version: "2015", doc)
  } else {
    doc
  }

  // Word count tracking (CJK characters + words, excluding headings/tables/code)
  let word-count-tracked(content) = {
    let stats = word-count-of(
      content,
      exclude: (heading, table, raw, figure.caption),
      counter: s => {
        let cleaned = s.replace(regex("\s+"), "")
        (
          words-cjk: cleaned.clusters().len(),
        )
      },
    )
    state("total-words-cjk").update(prev => prev + stats.words-cjk)
    content
  }

  let body = word-count-tracked(body-with-bib)

  body
  }

  // Cross-reference convenience commands
  let chapref(label) = [第@label章]
  let secref(label) = [第@label节]
  let figref(label) = [图@label]
  let tabref(label) = [表@label]
  let eqref(label) = [式@label]
  let algoref(label) = [算法@label]

  // Word count (auto-tracked, CJK characters)
  let wordcount() = context state("total-words-cjk").final()

  body
}
