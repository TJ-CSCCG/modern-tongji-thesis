#import "../lib.typ": *
#import "chapters/metadata.typ": *
#import "chapters/00_abstract.typ": *

#set pagebreak(weak: true)

#let field = "science"
#let fontset = "auto"
#let bib-path = ("ref.bib", "ref.yml")  // BibLaTeX 与 Hayagriva YAML 文件，可只写一个
#let twoside = false
#let blind = false  // true：盲审版本，封面不写学生姓名、学号、指导教师，不输出谢辞

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
  field: field, fontset: fontset, blind: blind, bib-content: if type(bib-path) == array { bib-path.map(read) } else { read(bib-path) }, twoside: twoside,
)

#include "chapters/01_intro.typ"
#newpage(twoside: twoside)

#include "chapters/02_math.typ"
#newpage(twoside: twoside)

#include "chapters/03_reference.typ"
#newpage(twoside: twoside)

#include "chapters/04_figure.typ"
#newpage(twoside: twoside)

#include "chapters/05_conclusion.typ"
#newpage(twoside: twoside)

#makereferences()
#newpage(twoside: twoside)

#appendix(humanities: field == "humanities")[
  #include "chapters/appendix.typ"
]
#newpage(twoside: twoside)

// 盲审版本（blind = true）不含谢辞
#if not blind { include "chapters/acknowledgments.typ" }
