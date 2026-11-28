#import "@preview/modern-tongji-thesis:0.3.0": *
#import "chapters/metadata.typ": *

// 毕业设计（论文）任务书：与论文共用 chapters/metadata.typ 中的课题、学院、专业与学生信息。
#let field = "science"      // 与 main.typ 相同："science" 或 "humanities"
#let fontset = "auto"       // 与 main.typ 相同

#show: form.with(
  doctype: "taskbook",
  school: school, major: major, id: id, student: student,
  title: title, subtitle: subtitle, field: field, fontset: fontset,
  taskbook-start: taskbook-start, taskbook-end: taskbook-end,
)

#include "chapters/taskbook_body.typ"
