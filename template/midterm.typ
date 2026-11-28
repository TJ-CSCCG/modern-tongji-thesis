#import "../lib.typ": *
#import "chapters/metadata.typ": *

// 毕业设计（论文）中期报告：与论文共用 chapters/metadata.typ 中的课题、学院、专业与学生信息。
#let field = "science"      // 与 main.typ 相同："science" 或 "humanities"
#let fontset = "auto"       // 与 main.typ 相同

#show: form.with(
  doctype: "midterm",
  school: school, major: major, id: id, student: student,
  title: title, subtitle: subtitle, field: field, fontset: fontset,
  midterm-decision: midterm-decision,
)

#include "chapters/midterm_body.typ"
