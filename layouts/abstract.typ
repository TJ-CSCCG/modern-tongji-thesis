#import "../utils/fonts.typ": TJFONT_ABSTRACT, TJFONT_ABSTRACT_SUB, TJFONT_HEADING, TJFONT_BODY

// Abstract pages — matches the LaTeX \MakeAbstract and \MakeAbstractEng: the
// thesis title in bold 小二 and the subtitle in bold 三号 (黑体 in Chinese),
// both centered with the body's 1.625 line spacing; the heading in 四号 (bold
// in English); the abstract text; a blank line; then the keywords after a bold
// label, separated by “，” in Chinese and “, ” in English.
#let make-abstract(
  title: "", subtitle: none, abstract: "", keywords: (), prompt: (), is-english: false,
  heading-override: none, fonts: none,
) = {
  let f = fonts
  let title-font = if is-english { f.song } else { f.hei }
  // Lines of a centered title block, 1.625 × 1.2 × the font size apart.
  let title-block(size, body) = {
    set text(font: title-font, size: size, weight: "bold")
    set par(first-line-indent: 0pt, justify: false, leading: 1.95 * size - 1em)
    align(center, body)
  }
  set text(lang: "en", region: none) if is-english

  // Baselines as the LaTeX template places them: the title's first 37.72 pt
  // below the text area, the subtitle's 39.57 pt and the heading's 38.07 pt
  // below the line before, the text's 37.28 pt (35.59 pt in English) below
  // the heading.
  v(19.72pt)
  title-block(TJFONT_ABSTRACT, title)
  if subtitle not in (none, "") {
    v(23.57pt, weak: true)
    title-block(TJFONT_ABSTRACT_SUB, subtitle)
  }
  v(24.07pt, weak: true)
  let h = if heading-override != none { heading-override } else { prompt.at(0) }
  align(center, text(font: title-font, size: TJFONT_HEADING, weight: if is-english { "bold" } else { "regular" }, h))
  v(if is-english { 23.59pt } else { 25.28pt }, weak: true)

  abstract
  parbreak()
  // A blank line before the keywords
  v(23.4pt)
  set par(first-line-indent: 0pt)
  let sep = if is-english { ", " } else { "，" }
  [#strong(prompt.at(1))#keywords.join(sep)]
}
