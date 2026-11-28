#import "../utils/fonts.typ": TJFONT_COVER, TJFONT_COVER_FIELD

// Cover — matches the LaTeX \MakeCover: the logo, TONGJI UNIVERSITY in bold
// 小二, the cover text in 小初 黑体, then one row per field: the label spread
// over four characters, the value centered over a 0.4 pt underline 20 em of
// 小三 wide. Rows are 43.875 pt apart (1.5 × the 1.625 line spacing of 小三);
// a value that wraps sets its lines 17.28 pt apart and grows its row upward.
// `cover` alternates labels and values.
#let make-cover(cover, cover-text: "毕业设计（论文）", fonts: none) = {
  let f = fonts
  let size = TJFONT_COVER_FIELD
  let row-above = 30.71pt // the strut above the baseline: 0.7 × 43.875 pt
  let row-below = 13.16pt // and below it: 0.3 × 43.875 pt
  let label-width = 75pt // 5 em of 小三
  let cell-width = 330pt // 22 em of 小三
  let value-width = 300pt // 20 em of 小三, centered in the cell
  let gutter = 16pt // two \tabcolsep of 8 pt

  let spread(label) = {
    let chars = label.clusters()
    if chars.len() < 2 { label } else {
      box(width: 4em, chars.join(h(1fr)))
    }
  }

  let row(label, value) = context {
    let value-box = box(width: value-width, {
      set par(leading: 17.28pt - 1em, justify: false, first-line-indent: 0pt)
      align(center, value)
    })
    // Height of the lines above the last baseline: the value box (whose
    // bottom is the last baseline) less the 0.172 em by which its one-em top
    // edge clears the first line's characters (SimHei rises 0.828 em in the
    // LaTeX template).
    let above = calc.max(row-above, measure(value-box).height - 0.172em.to-absolute())
    block(width: 100%, height: above + row-below, above: 0pt, below: 0pt, {
      let x0 = (100% - label-width - gutter - cell-width) / 2
      let x1 = x0 + label-width + gutter + (cell-width - value-width) / 2
      place(top + left, dx: x0, dy: above, box(width: label-width, align(center, box(
        text(top-edge: "baseline", bottom-edge: "baseline", spread(label)),
      ))))
      place(top + left, dx: x1, dy: above - measure(value-box).height, value-box)
      place(top + left, dx: x1, dy: above + 3.47pt, line(length: value-width, stroke: 0.4pt))
    })
  }

  set par(first-line-indent: 0pt, justify: false)
  set text(font: f.hei, size: size)
  align(center, image("../figures/tongji.svg", height: 2.5cm))
  v(17.08pt, weak: true)
  align(center, text(font: f.song, weight: "bold", "TONGJI UNIVERSITY"))
  v(34.18pt, weak: true)
  align(center, text(cover-text, size: TJFONT_COVER))
  v(64.64pt, weak: true)
  for i in range(0, cover.len(), step: 2) {
    row(cover.at(i), cover.at(i + 1))
  }
}
