#import "fonts.typ": TJFONT_BODY, TJ_LINE_PITCH
#import "helpers.typ": circled-number

// Items follow each other at the body's line pitch, with no extra space
// (the LaTeX template's nosep).
#let item-spacing = TJ_LINE_PITCH - TJFONT_BODY

#let _tj-enum-depth = state("_tj-enum-depth", 0)
#let _tj-list-depth = state("_tj-list-depth", 0)

// Apply thesis-style enum and list show rules to body.
//
// How depth tracking works: the show rule emits [update(+1), context{render}, update(-1)]
// as a content sequence. In document order, update(+1) fires before the context reads the
// state, so depth is always correct. Nested enums trigger the same show rule inside the
// outer context block, so their depth reads are also correct.
//
// Enum L1: （1）（2）paragraph-style block labels (matching LaTeX setlist[enumerate,1])
// Enum L2: ①②③ circled numbers (matching LaTeX TJCircled + tj@cval{enumii})
// List L1: • at 2 em, L2: – at 4 em, each 0.5 em before the text; lines after
// the first start at the margin (the LaTeX template's wide lists)
#let apply-list-rules(body) = {
  show enum: it => {
    _tj-enum-depth.update(d => d + 1)
    context {
      let depth = _tj-enum-depth.get()
      if depth == 1 {
        // L1: block paragraphs with （1）（2） hanging labels
        let result = none
        let idx = 1
        for child in it.children {
          if child.func() == enum.item {
            let lbl = text(size: TJFONT_BODY)[（#idx）]
            let item-block = block(
              above: item-spacing,
              below: item-spacing,
              {
                set par(first-line-indent: 0pt)
                h(2em) + lbl + child.body
              },
            )
            result = if result == none { item-block } else { result + item-block }
            idx += 1
          }
        }
        result
      } else {
        // L2+: inline ①②③ separated by ；— Typst has no enumerate* built-in
        let items = ()
        let idx = 1
        for child in it.children {
          if child.func() == enum.item {
            items += (text(size: TJFONT_BODY, circled-number(idx)) + child.body,)
            idx += 1
          }
        }
        items.join([；])
      }
    }
    _tj-enum-depth.update(d => d - 1)
  }

  show list: it => {
    _tj-list-depth.update(d => d + 1)
    context {
      let depth = _tj-list-depth.get()
      let result = none
      for child in it.children {
        if child.func() == list.item {
          let marker = if depth == 1 { [•] } else { [–] }
          let lbl = text(size: TJFONT_BODY, marker) + h(0.5em)
          let item-block = block(
            above: item-spacing,
            below: item-spacing,
            {
              set par(first-line-indent: 0pt)
              h(2em * calc.min(depth, 2)) + lbl + child.body
            },
          )
          result = if result == none { item-block } else { result + item-block }
        }
      }
      result
    }
    _tj-list-depth.update(d => d - 1)
  }

  body
}
