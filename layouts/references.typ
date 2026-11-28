#import "../utils/fonts.typ": TJ_LINE_PITCH, TJFONT_BODY

// Bibliography — GB/T 7714—2025 numeric, from the CSL style in
// csl/gb-t-7714-2025-numeric.csl (the official CSL repository's style with the
// half-width punctuation the writing spec requires).
#let gbt7714-2025-style = read("../csl/gb-t-7714-2025-numeric.csl", encoding: none)

// Marks where the reference list goes; thesis() replaces it with the
// bibliography of the files it was given.
#let _references-marker = metadata("tongji-thesis-references")

// The reference list: the 参考文献 heading (in the table of contents) and the
// entries. Call it where the list belongs, after the last chapter.
#let makereferences() = {
  heading(level: 1, numbering: none, outlined: true)[参考文献]
  _references-marker
}

// Cite several entries at once: #multicite("key1", "key2") prints [1,2] or
// [1-3]. A key may be (key: "...", supplement: [...]) to cite a page.
// Adjacent @key1 @key2 citations are merged the same way.
#let multicite(..keys) = keys.pos().map(k => {
  if type(k) == dictionary {
    cite(label(k.key), supplement: k.at("supplement", default: none))
  } else {
    cite(label(k))
  }
}).join()

// The bibliography element for the sources thesis() received (a string, or an
// array of strings, each the contents of a BibLaTeX or Hayagriva YAML file).
// Entries are set like the LaTeX template's \defbibenvironment: the label
// flush left in a column at least 0.74 cm wide, the text hanging after it.
// The style has one locale (Chinese), so two of its terms are set right here
// for Western-language entries, as GB/T 7714 writes them: “et al.” after a
// Western name instead of “等”, and “vol. 30” after a Western title instead
// of “卷30” (“第30卷” after a Chinese one).
#let render-references(sources) = {
  let sources = if type(sources) == array { sources } else { (sources,) }
  show bibliography: it => {
    show regex("\p{Latin}, 等"): m => m.text.replace("等", "et al")
    show regex("(\p{Latin}: )?卷\s*\d+"): m => {
      let n = m.text.find(regex("\d+"))
      if m.text.starts-with(regex("\p{Latin}")) {
        m.text.slice(0, m.text.position("卷")) + "vol. " + n
      } else {
        "第" + n + "卷"
      }
    }
    it
  }
  // The label flush left in a box at least 0.74 cm wide (wider for a wider
  // label), every line after the first hanging 0.74 cm. Typst hangs CSL
  // entries by 1.5 em, so the list is padded by the difference and the label
  // moved back by it.
  let hang = 0.74cm
  show bibliography: it => context {
    let shift = hang - 1.5em.to-absolute()
    show regex("\u{2060}\[\d+\]"): m => {
      let label = m.text.trim("\u{2060}")
      h(-shift) + context box(width: calc.max(hang.to-absolute(), measure(label).width), label)
    }
    pad(left: shift, it)
  }
  // Entries 5 pt apart beyond the line pitch, the LaTeX template's \bibitemsep
  show bibliography: set par(first-line-indent: 0pt, justify: true, spacing: TJ_LINE_PITCH - TJFONT_BODY + 5pt)
  bibliography(sources.map(bytes), style: gbt7714-2025-style, title: none, full: false)
}
