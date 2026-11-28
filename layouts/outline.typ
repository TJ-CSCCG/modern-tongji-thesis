// Table of contents — matches the LaTeX \tableofcontents: the 目录 heading in
// 四号 黑体 followed by a blank line, then entries in 小四 宋体 23.4 pt apart.
// Chapters start at the margin with their titles 1.47 em in; sections are
// indented 23.5 pt with their titles 1.75 em after the number; subsections
// 47 pt with 2.5 em; a wider number (humanities) keeps a gap of 0.3 em. Dot
// leaders 4.33 pt apart stop 3.78 pt before the page number box, 1.55 em wide.
#let make-outline(title: [目#h(0.5em)录], depth: 3, indent: true) = {
  heading(title, numbering: none, outlined: false)
  v(23.4pt)
  set par(first-line-indent: 0pt, justify: false)
  context {
    let elements = query(heading.where(outlined: true))

    for el in elements {
      if depth != none and el.level > depth { continue }
      let lv = calc.min(el.level, 3)
      let number = if el.numbering != none {
        let n = numbering(el.numbering, ..counter(heading).at(el.location()))
        let width = (1.47em, 1.75em, 2.5em).at(lv - 1).to-absolute()
        n + h(calc.max(width, measure(n).width + 0.3em.to-absolute()) - measure(n).width)
      }
      let page-format = el.location().page-numbering()
      let page-number = numbering(if page-format != none { page-format } else { "1" }, ..counter(page).at(el.location()))
      block(above: 23.4pt - 1em, below: 23.4pt - 1em, link(el.location(), {
        if indent { h((0pt, 23.5pt, 47pt).at(lv - 1)) }
        number
        el.body
        box(width: 1fr, repeat(gap: 1.33pt)[.])
        h(3.78pt + calc.max(0pt, 1.55em.to-absolute() - measure(page-number).width))
        page-number
      }))
    }
  }
}
