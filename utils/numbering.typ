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
// “(2.2)” example shows), A.1 in the appendix. Call in a context.
#let float-number(n) = {
  let h = counter(heading).get()
  if in-appendix.get() {
    numbering("A.1", h.at(1, default: 1), n)
  } else {
    numbering("1.1", h.first(), n)
  }
}
