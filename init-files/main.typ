#import "../paddling-tongji-thesis/tongjithesis.typ": *
#import "metadata.typ": *

#set pagebreak(weak: true)

#show: thesis.with(
  school: school, major: major, id: id, student: student, advisor: advisor,
  title: title, subtitle: subtitle, title-english: title-english, subtitle-english: subtitle-english,
  date: date, abstract: abstract, keywords: keywords,
  abstract-english: abstract-english, keywords-english: keywords-english,
  infotype: infotype, infoabstract: infoabstract,
  infodrawings: infodrawings, infowordcount: infowordcount,
  infothesiswords: infothesiswords, infomaterials: infomaterials,
  abstract-title: abstract-title, abstract-subtitle: abstract-subtitle,
  abstract-title-english: abstract-title-english, abstract-subtitle-english: abstract-subtitle-english,
  bib-content: read(bib-path), fontset: fontset,
)

#include "chapters/01_intro.typ"
#pagebreak()

#include "chapters/02_math.typ"
#pagebreak()

#include "chapters/03_reference.typ"
#pagebreak()

#include "chapters/04_figure.typ"
#pagebreak()

#include "chapters/05_conclusion.typ"
#pagebreak()

#makereferences()
#pagebreak()

#include "chapters/acknowledgments.typ"
