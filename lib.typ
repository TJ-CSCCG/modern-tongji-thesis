#import "utils/fonts.typ": *
#import "utils/tables.typ": *
#import "utils/theorion.typ": *
#import "utils/helpers.typ": *
#import "utils/word-count.typ": *
#import "utils/lists.typ": *
#import "utils/continued-table.typ": *
#import "utils/figurex.typ": *
#import "utils/numbering.typ": *
#import "layouts/cover.typ": *
#import "layouts/info-page.typ": *
#import "layouts/abstract.typ": *
#import "layouts/outline.typ": *
#import "layouts/header-footer.typ": *
#import "layouts/references.typ": *
#import "layouts/appendix.typ": *
#import "@preview/algo:0.3.6": algo, i, d, comment, code
#import "@preview/wordometer:0.1.5": word-count-of
#import "@preview/cuti:0.4.0": show-cn-fakebold
#import "@preview/equate:0.3.3": equate
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": codly-languages

#let thesis(
  school: "某学院", major: "某专业", id: "0000000", student: "某某某", advisor: "某某某", title: "某标题", subtitle: "某副标题", title-english: "Some Title", subtitle-english: "Some Subtitle", date: datetime.today(), abstract: "慧枫尚萍氢，驳展妙棚端梦称委竞励。绘象臂淬人壳闭营风混仓、问抬兽村蜡胡锹挤污艰烃伏惧派宝既抓章住蓟棒褶均谭穿谴属；羟贮银…钓郭曾牙记氢硝巍仰蒲邀趟。革旅剑撞压单施宵饼狼将售烷贸问术粮洞魔。却烟陕倍且隘框糟秩板商，宙刚疮顿表羽楞景哺驯邮戒歌溜著聪峻忙劈左绩卖卫萨讯完读百釉好仔帜纽龟玉炒脂衍蛴瓦副冯查索桐梁；轴派？蝗丸朝保岂搅搞燕挫品休礼倾玻黑李宽列邮苦仔汛鳙物己弱寸栓孝哄俭牙敬厄搬吨楞干捧原趋息…善！", keywords: ("关键词1", "关键词2", "关键词3"), abstract-english: lorem(300), keywords-english: ("Keyword1", "keyword2", "keyword3"), doc,
  field: "science",
  // "auto": the Word template's fonts (SimSun…) when installed, else the free
  // LXGW/AR PL set; or name a set: windows, texlive, founder, adobe, mac, fandol
  fontset: "auto",
  // Info page
  infotype: "thesis", infoabstract: "", infodrawings: "", infowordcount: "", infothesiswords: "", infomaterials: (),
  // Abstract titles (defaults to thesis title)
  abstract-title: none, abstract-subtitle: none, abstract-title-english: none, abstract-subtitle-english: none,
  // Bibliography: the contents of a .bib (BibLaTeX) or .yml (Hayagriva) file,
  // or an array of them, set as GB/T 7714—2025 where makereferences() is called
  bib-content: none,
  // Twoside
  twoside: false,
  // Punctuation — "circle" keeps U+3002, "dot" replaces with U+FF0E
  fullwidthstop: "circle",
  // Blind review: true leaves the student's name, student ID and advisor
  // blank on the cover (the fields stay) and names no author in the PDF;
  // main.typ leaves out the acknowledgements, and #tjblind[...][...] marks
  // other identifying text
  blind: false,
) = context {
  let is-humanities = (field == "humanities")
  let cover-text = if is-humanities { "毕业论文（设计）" } else { "毕业设计（论文）" }

  // Resolve the font set (fontset "auto" probes for SimSun) and share it with
  // songti/heiti/kaiti/fangsong.
  let ff = resolve-fonts(fontset)
  thesis-fonts.update(ff)
  blind-state.update(blind)
  set document(author: if blind { () } else { id + " " + student }, title: title)
  let anon(value) = if blind { "" } else { value }
  let page-margin = if twoside {
    (top: 4.0cm, bottom: 2.7cm, inside: 3.3cm, outside: 1.8cm)
  } else {
    (top: 4.0cm, bottom: 2.7cm, left: 3.3cm, right: 1.8cm)
  }
  set page(paper: "a4", margin: page-margin, binding: left)
  // Every line is one em tall above its baseline, so the leading alone sets
  // the distance between lines whatever the font: the body's 1.625 line
  // spacing of the LaTeX template (Word's 1.5 lines) puts baselines 23.4 pt
  // apart, and a page's first baseline sits one em below the text area, as
  // TeX's \topskip puts it.
  set text(
    TJFONT_BODY, font: ff.song, lang: "zh", region: "cn",
    top-edge: 1em, bottom-edge: "baseline",
  )
  set par(
    justify: true, first-line-indent: (amount: 2em, all: true),
    leading: TJ_LINE_PITCH - TJFONT_BODY, spacing: TJ_LINE_PITCH - TJFONT_BODY,
    justification-limits: (tracking: (min: -0.01em, max: 0.02em)), linebreaks: "optimized",
  )

  make-cover(
    (
      "课题名称", title, "副标题", subtitle, "学院", school, "专业", major, "学生姓名", anon(student), "学号", anon(id), "指导教师", anon(advisor), "日期", date.display("[year]年[month]月[day]日"),
    ),
    cover-text: cover-text,
    fonts: ff,
  )
  newpage(twoside: twoside)

  make-info-page(
    title: title, subtitle: subtitle, school: school, major: major,
    infotype: infotype, infoabstract: infoabstract, infodrawings: infodrawings,
    infowordcount: infowordcount, infothesiswords: infothesiswords,
    infomaterials: infomaterials, header-text: cover-text, fonts: ff,
  )
  newpage(twoside: twoside)

  // Bold CJK text in a set without bold faces is stroked like Word's bold
  // SimSun; Latin text keeps its real bold face.
  show: it => if ff.bold { it } else { show-cn-fakebold(it, stroke: TJ_FAKEBOLD_STROKE) }
  show emph: it => text(font: ff.kai, style: "italic", it.body)
  show raw: set text(font: ff.code)
  show math.equation: set text(font: ff.math)
  // Display math as the LaTeX template's 12 pt display skips and 1.625 line
  // spacing place it: the number's baseline 42.83 pt below the line before a
  // fraction and the next baseline 42.82 pt below it.
  show math.equation.where(block: true): set block(above: 24.65pt, below: 18.64pt)
  show: equate.with(breakable: true, sub-numbering: false)
  set underline(offset: 3pt, stroke: 0.6pt)
  // Footnotes: 小五, numbered ①②③
  set footnote(numbering: n => circled-number(n))
  show footnote.entry: set text(size: TJFONT_FOOTNOTE)
  show footnote.entry: set par(leading: 0.5em, spacing: 0.5em)
  // Lists: decoupled-marker layout avoids CJK-Latin baseline offset in items
  set enum(
    numbering: (..nums) => {
      let pos = nums.pos()
      if pos.len() == 1 {
        "（" + str(pos.first()) + "）"
      } else {
        circled-number(pos.last())
      }
    },
  )
  // fullwidthstop: "dot" prints every “。” as the full-width “．”
  show "。": it => if fullwidthstop == "dot" { "．" } else { it }

  let thm-kinds = ("theorem", "lemma", "corollary", "proposition", "conjecture", "assumption", "definition", "example", "remark", "proof")
  // Cross-reference formatting — "第 X 章" / "第 X 节" pattern
  show ref: it => {
    let el = it.element
    // Figures, tables, code and equations: the number they have where they
    // are, which the numbering functions below would otherwise work out at
    // the reference.
    if el != none and el.func() in (figure, math.equation) and el.numbering != none and not (el.func() == figure and (el.kind in thm-kinds or el.kind == "subfigure")) {
      let loc = el.location()
      let n = if el.func() == figure {
        counter(figure.where(kind: el.kind)).at(loc).first()
      } else {
        counter(math.equation).at(loc).first()
      }
      let number = float-number(n, loc: loc)
      let supplement = if it.supplement != auto { it.supplement } else { el.supplement }
      let body = if el.func() == math.equation { [(#number)] } else { number }
      return link(loc, if supplement in (none, []) { body } else { [#supplement~#body] })
    }
    if it.element != none and it.element.func() == heading {
      let h = it.element
      if h.numbering != none {
        let n = numbering(h.numbering, ..counter(heading).at(h.location()))
        let lv = h.level
        let prefix = if lv == 1 { "第" + n.trim("、") + "章" } else if lv == 2 { "第" + n.trim("（").trim("）") + "节" } else if lv == 3 { "第" + n.trim(".") + "小节" } else { none }
        if prefix != none { link(h.location(), prefix) } else { it }
      } else { it }
    } else {
      it
    }
  }

  // Heading numbers: science 1 / 1.1 / 1.1.1 / A. / a.;
  // humanities 一、/（一）/ 1. /（1）/ ①
  set heading(numbering: (..nums) => {
    let pos = nums.pos()
    if is-humanities {
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
      if pos.len() <= 3 {
        pos.map(str).join(".")
      } else if pos.len() == 4 {
        numbering("A", pos.at(-1)) + "."
      } else if pos.len() == 5 {
        numbering("a", pos.at(-1)) + "."
      } else {
        pos.map(str).join(".")
      }
    }
  })

  // Headings, as the LaTeX template sets them: a chapter starts a page (an odd
  // one in a two-sided thesis), its title centered in 小三 黑体 with its number
  // one em before it (“一、” with none in the humanities), its baseline
  // 25.26 pt below the text area; 目录, 参考文献, 附录 and 谢辞 likewise in 四号.
  // Lower levels are 小四 黑体, the number 0.5 em before the title, the third
  // and lower levels indented 2 em. Every heading's baseline is 30.6 pt from
  // the lines around it: the 23.4 pt line pitch plus 0.6 em before and after.
  show heading: it => {
    set par(first-line-indent: 0pt, justify: false)
    set text(font: ff.hei, weight: "regular")
    let number = if it.numbering != none {
      numbering(it.numbering, ..counter(heading).at(it.location()))
    }
    if it.level == 1 {
      let size = if number != none { TJFONT_CHAPTER } else { TJFONT_HEADING }
      let baseline = if number != none { 25.26pt } else { 23.31pt }
      let gap = if is-humanities { 0em } else { 1em }
      pagebreak(weak: true, to: if twoside { "odd" })
      // Figures, tables, code and equations are numbered within the chapter;
      // the appendix numbers them within its sections.
      context if not in-appendix.get() { reset-float-counters }
      v(baseline - size)
      block(width: 100%, above: 0pt, below: 30.6pt - TJFONT_BODY, {
        set text(size: size)
        align(center, if number != none { number + h(gap) + it.body } else { it.body })
      })
    } else {
      let spacing = TJ_LINE_PITCH - TJFONT_BODY + 0.6 * TJFONT_BODY
      block(width: 100%, above: spacing, below: spacing, sticky: true, {
        set text(size: TJFONT_BODY)
        if it.level >= 3 { h(2em) }
        if number != none { number + h(0.5em) }
        it.body
      })
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

  // Floats: centered, with a blank line between them and the text as the
  // spec asks, spaced as the LaTeX template's \intextsep leaves it: the float
  // starts 24.39 pt below the last baseline, and the next baseline is 44.6 pt
  // below a table's bottom rule or 49.36 pt below a figure's caption.
  // Theorem-kind figures are handled by theorion.
  show figure: it => {
    if it.kind in thm-kinds or it.kind == "subfigure" { it } else {
      set align(center)
      set par(first-line-indent: 0pt)
      let below = if it.kind == table { 44.6pt } else { 49.36pt } - TJFONT_BODY
      block(above: TJ_FLOAT_SKIP + 0.99pt, below: below, breakable: true, it)
    }
  }

  // Code blocks: syntax highlighting with line numbers
  show: codly-init.with()
  codly(languages: codly-languages)

  // Captions: 五号 宋体, the number then two spaces before the title; a table's
  // caption above it, a figure's below
  // Caption to figure: the caption's baseline 22.2 pt below a figure, a
  // table's top rule 14.21 pt below its caption's baseline.
  set figure.caption(separator: h(0.5em))
  set figure(gap: 22.2pt - TJFONT_CAPTION)
  show figure.where(kind: table): set figure(gap: 14.21pt)
  show figure.caption: it => {
    set text(font: ff.song, size: TJFONT_CAPTION)
    set par(first-line-indent: 0pt, leading: 1.95 * TJFONT_CAPTION - TJFONT_CAPTION)
    it
  }
  show figure.where(kind: table): set figure.caption(position: top)

  // Tables: 五号 text 18 pt apart, as in the LaTeX template's \tjfonttable
  show table: set text(size: TJFONT_TABLE)
  show table: set par(leading: 18pt - TJFONT_TABLE, spacing: 18pt - TJFONT_TABLE, first-line-indent: 0pt, justify: false)
  // Rows 18 pt apart with the baseline 12.6 pt below a row's top, as the
  // LaTeX \strut places it (0.7 of the row)
  set table(inset: (x: 6pt, top: 12.6pt - TJFONT_TABLE, bottom: 5.4pt))

  // Figures, tables, code and equations are numbered 1.1 within the chapter
  // (A.1 within the appendix section); the chapter number is Arabic in the
  // humanities too, as the spec's “(2.2)” example shows.
  set figure(numbering: n => context float-number(n))
  set math.equation(numbering: n => context "(" + float-number(n) + ")")

  set page(
    margin: page-margin, binding: left, numbering: "I",
    header: make-page-header(twoside, cover-text), header-ascent: 0pt,
    footer: make-front-footer(), footer-descent: 0pt,
    background: binding-line(twoside: twoside),
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

  set page(numbering: "1", footer: make-main-footer(twoside))
  counter(page).update(1)

  // Citation ranges use a hyphen, [5-6], as the writing spec's half-width
  // punctuation and the LaTeX template print them; a cited page follows the
  // brackets in superscript, [4]^{3-5}, as GB/T 7714 places it.
  show cite: it => {
    show "–": "-"
    it
    if it.supplement != none { super(it.supplement) }
  }
  // The reference list goes where makereferences() was called
  show metadata.where(value: "tongji-thesis-references"): it => {
    if bib-content != none { render-references(bib-content) }
  }
  let body-with-bib = doc

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
  let final = apply-list-rules(body)

  final
}
