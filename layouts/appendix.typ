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
