#import "../utils/numbering.typ": in-appendix, reset-float-counters

// Appendix — matches the LaTeX \appendix: an unnumbered 附录 heading in the
// table of contents, sections numbered “A.” (science) or “（A）” (humanities)
// with A.1 subsections, and floats and equations numbered A.1, B.1 within each
// section.
#let appendix(humanities: false, body) = {
  heading(level: 1, numbering: none, outlined: true)[附录]
  in-appendix.update(true)
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

  show heading.where(level: 2): it => {
    reset-float-counters
    it
  }

  body
}
