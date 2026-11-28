// Page header, footer and binding line, placed where the LaTeX template's
// fancyhdr page styles and eso-pic binding line put them. Positions are
// measured from the page edges of an A4 page.
#import "../utils/fonts.typ": TJFONT_BODY, TJFONT_CAPTION

// Text whose baseline sits at the top of its box, so `place(dy: y)` puts the
// baseline at y.
#let _on-baseline(body) = box(text(top-edge: "baseline", bottom-edge: "baseline", body))

// Even pages of a two-sided thesis mirror the header, footer and binding line.
#let _is-even-twoside(twoside) = twoside and calc.even(counter(page).get().first())

// Binding line (装订线): 3 mm rules down the binding edge with 装, 订 and 线 in
// 五号, centered 1.6 cm (19.4 cm on even two-sided pages) plus half a box from
// the page edge. Each value is the bottom of a rule or the baseline of a
// character, in cm above the bottom of the page, as in the LaTeX template.
#let _binding-marks = (
  23.60, 23.12, 22.65, 22.16, 21.68, 21.20, 20.72, 20.24, 19.76, 19.29, 18.80, 18.32, 17.84,
  "装", 16.88, 16.40, 15.92, 15.44, 14.96, "订", 14.00, 13.52, 13.04, 12.56, 12.07,
  "线", 11.12, 10.63, 10.15, 9.68, 9.20, 8.71, 8.24, 7.76, 7.27, 6.79, 6.32, 5.84, 5.35,
)
#let _binding-labels = ("装": 17.37, "订": 14.50, "线": 11.60)

#let binding-line(twoside: false) = context {
  let center = (if _is-even-twoside(twoside) { 19.4cm } else { 1.6cm }) + 5.88pt
  let from-top(y) = 29.7cm - y * 1cm
  set text(size: TJFONT_CAPTION)
  for mark in _binding-marks {
    if type(mark) == str {
      place(top + left, dx: center - 0.5em, dy: from-top(_binding-labels.at(mark)), _on-baseline(mark))
    } else {
      place(top + left, dx: center, dy: from-top(mark) - 3mm, line(angle: 90deg, length: 3mm, stroke: 0.4pt))
    }
  }
}

// Page header: the Tongji logo 1 cm in from the binding side, the header text
// on the other side, and a double rule of two 0.5 pt lines. Use with
// `header-ascent: 0pt`; the box spans the 4 cm top margin.
#let make-page-header(twoside, header-text) = context {
  let even = _is-even-twoside(twoside)
  let logo = image("../figures/tongji-header.svg", height: 1.14cm)
  block(width: 100%, height: 4cm, {
    set text(size: TJFONT_BODY)
    place(if even { top + right } else { top + left }, dx: if even { -1cm } else { 1cm }, dy: 54.56pt, logo)
    place(if even { top + left } else { top + right }, dy: 72.87pt, _on-baseline(header-text))
    place(top + left, dy: 91.84pt, line(length: 100%, stroke: 0.5pt))
    place(top + left, dy: 93.34pt, line(length: 100%, stroke: 0.5pt))
  })
}

// Footer of the front matter: the page number in Roman numerals, centered.
// Use with `footer-descent: 0pt`; the box spans the 2.7 cm bottom margin.
#let make-front-footer() = context {
  block(width: 100%, height: 2.7cm, {
    set text(size: TJFONT_BODY)
    place(top + center, dy: 29.89pt, _on-baseline(numbering("I", counter(page).get().first())))
  })
}

// Footer of the main matter: a 1.8 pt rule and “共 N 页 第 n 页”, its parts one
// em apart, on the outer side.
#let make-main-footer(twoside) = context {
  let even = _is-even-twoside(twoside)
  let total = [共#h(1em)#counter(page).final().first()#h(1em)页]
  let current = [第#h(1em)#counter(page).get().first()#h(1em)页]
  block(width: 100%, height: 2.7cm, {
    set text(size: TJFONT_BODY)
    place(top + left, dy: 14.6pt, line(length: 100%, stroke: 1.8pt))
    if even {
      place(top + left, dy: 29.89pt, _on-baseline[#current#h(1em)#total])
    } else {
      place(top + right, dy: 29.89pt, _on-baseline[#total#h(1em)#current])
    }
  })
}

// Kept for theses written for 0.2: a paragraph after a heading is indented
// without it now.
#let empty-par() = none
