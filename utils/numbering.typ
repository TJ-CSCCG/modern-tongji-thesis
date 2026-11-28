// Whether the document has reached the appendix, where floats and equations
// are numbered within the section (A.1) instead of the chapter.
#let in-appendix = state("tongji-in-appendix", false)

#let _float-kinds = (image, table, raw, "algo", "subfigure")

// Restart the numbering of figures, tables, code, algorithms and equations.
#let reset-float-counters = {
  for kind in _float-kinds {
    counter(figure.where(kind: kind)).update(0)
  }
  counter(math.equation).update(0)
}

// The number of a figure, table, code block or equation: 1.1 in the main
// matter (an Arabic chapter number in the humanities too, as the spec's
// “(2.2)” example shows), A.1 in the appendix. `loc` is the element's
// location, so a reference from another chapter gets the number the element
// has where it is; without it, the current location is used. Call in a
// context.
#let float-number(n, loc: auto) = {
  let h = if loc == auto { counter(heading).get() } else { counter(heading).at(loc) }
  let appendix = if loc == auto { in-appendix.get() } else { in-appendix.at(loc) }
  if appendix {
    numbering("A.1", h.at(1, default: 1), n)
  } else {
    numbering("1.1", h.first(), n)
  }
}
