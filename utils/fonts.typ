// Font size table — matching LaTeX Chinese font size system
#let font-size = (
  "0": 42pt,
  "-0": 36pt,
  "1": 26pt,
  "-1": 24pt,
  "2": 22pt,
  "-2": 18pt,
  "3": 16pt,
  "-3": 15pt,
  "4": 14pt,
  "-4": 12pt,
  "5": 10.5pt,
  "-5": 9pt,
  "6": 7.5pt,
  "-6": 6.5pt,
  "7": 5.5pt,
  "-7": 5pt,
)

// Named font size constants — matching the LaTeX template's \tjfont* macros,
// which follow《同济大学本科生毕业设计（论文）撰写规范》(revised October 2026).
#let TJFONT_COVER         = font-size.at("-0")  // 封面大标题：小初号 36pt
#let TJFONT_TITLE         = font-size.at("-2")  // 课题名称：小二号 18pt
#let TJFONT_CHAPTER       = font-size.at("-3")  // 章标题：小三号 15pt
#let TJFONT_HEADING       = font-size.at("4")   // 摘要/目录/参考文献/附录/谢辞标题：四号 14pt
#let TJFONT_INFO          = font-size.at("3")   // 信息说明页标题：三号 16pt
#let TJFONT_BODY          = font-size.at("-4")  // 正文：小四号 12pt
#let TJFONT_CAPTION       = font-size.at("5")   // 表题/图题：五号 10.5pt
#let TJFONT_TABLE         = font-size.at("5")   // 表内文字：五号 10.5pt（撰写规范“表中文字原则上采用宋体五号”）
#let TJFONT_FOOTNOTE      = font-size.at("-5")  // 脚注：小五号 9pt
#let TJFONT_COVER_FIELD   = font-size.at("-2")  // 封面表格字段：小二号 18pt
#let TJFONT_ABSTRACT      = font-size.at("-2")  // 摘要标题：小二号 18pt
#let TJFONT_ABSTRACT_SUB  = font-size.at("3")   // 摘要副标题：三号 16pt

// Distance between the baselines of body lines: Word's 1.5 line spacing of
// 小四 SimSun, the LaTeX template's \linespread{1.625} (12 × 1.2 × 1.625).
#let TJ_LINE_PITCH = 23.4pt

// Space between a figure or table and the text around it: one blank line.
#let TJ_FLOAT_SKIP = 23.4pt

// Synthesized bold for CJK fonts without a bold face: a stroke of 1/35 of the
// font size, the width Word uses for bold SimSun and the LaTeX template's
// AutoFakeBold=2.86.
#let TJ_FAKEBOLD_STROKE = 0.0286em

// Latin glyphs inside CJK text use TeX Gyre Termes, the free Times clone the
// LaTeX template's newtx fonts resemble.
#let latin-font = (name: "TeX Gyre Termes", covers: "latin-in-cjk")

// CJK font sets, named after the LaTeX template's fontset options. Each names
// the family Typst reports (`typst fonts`) for Song, Hei, Kai and FangSong.
// `bold`: whether Song and Hei have real bold faces; otherwise bold CJK text is
// synthesized with TJ_FAKEBOLD_STROKE.
#let cjk-font-sets = (
  // 中易字体: the fonts of the official Word template (Windows).
  windows: (
    song: "SimSun", hei: "SimHei", kai: "KaiTi", fang: "FangSong", bold: false,
  ),
  // The free fonts the LaTeX fontset=texlive uses (CTAN lxgw-fonts and arphic-ttf).
  texlive: (
    song: "LXGW Neo ZhiSong",
    hei: "LXGW Neo XiHei",
    kai: "AR PL KaitiM GB",
    fang: "Zhuque Fangsong (technical preview)",
    bold: false,
  ),
  founder: (
    song: "FZShuSong-Z01", hei: "FZHei-B01", kai: "FZKai-Z03", fang: "FZFangSong-Z02", bold: false,
  ),
  adobe: (
    song: "Adobe Song Std", hei: "Adobe Heiti Std", kai: "Adobe Kaiti Std R", fang: "Adobe Fangsong Std R",
    bold: false,
  ),
  mac: (
    song: "Songti SC", hei: "Heiti SC", kai: "Kaiti SC", fang: "STFangsong", bold: true,
  ),
  // Withdrawn by its authors; kept for theses that already use it.
  fandol: (
    song: "FandolSong", hei: "FandolHei", kai: "FandolKai", fang: "FandolFang R", bold: true,
  ),
)

// Resolve a fontset option to the font lists the template uses. Must be called
// in a context. "auto" chooses the Word template's fonts (windows) when SimSun
// is installed and the free texlive set otherwise, as the LaTeX fontset=auto
// does. Only SimSun is probed, so a build without it reports one
// "unknown font family: simsun" warning, the counterpart of the LaTeX
// template's "fontset=auto chose texlive" warning.
#let resolve-fonts(fontset) = {
  let name = if fontset == "auto" {
    let probe = text(font: "SimSun", fallback: false, "永")
    if measure(probe).width > 0pt { "windows" } else { "texlive" }
  } else {
    fontset
  }
  assert(
    name in cjk-font-sets,
    message: "fontset must be \"auto\" or one of " + cjk-font-sets.keys().map(repr).join(", ") + ", got " + repr(fontset),
  )
  let s = cjk-font-sets.at(name)
  (
    name: name,
    bold: s.bold,
    song: (latin-font, s.song),
    hei: (latin-font, s.hei),
    kai: (latin-font, s.kai),
    fang: (latin-font, s.fang),
    code: ("DejaVu Sans Mono", s.fang),
    // Math in New Computer Modern Math; text in math (quoted strings) falls
    // back to Song for CJK, as the LaTeX template's \text does.
    math: ("New Computer Modern Math", s.song),
  )
}

// The font lists thesis() resolved, for the helpers below.
#let thesis-fonts = state("tongji-thesis-fonts", none)

#let _with-font(role, body) = context {
  let ff = thesis-fonts.get()
  if ff == none { body } else { text(font: ff.at(role), body) }
}

// Set text in one of the four CJK faces of the chosen font set:
// #songti[宋体] #heiti[黑体] #kaiti[楷体] #fangsong[仿宋]
#let songti(body) = _with-font("song", body)
#let heiti(body) = _with-font("hei", body)
#let kaiti(body) = _with-font("kai", body)
#let fangsong(body) = _with-font("fang", body)

// Math symbols
// Upright imaginary units and the base of natural logarithms (GB 3102.11)
#let ii = math.class("normal", $upright(i)$)
#let jj = math.class("normal", $upright(j)$)
#let ee = math.class("normal", $upright(e)$)

#let LaTeX = {
  [L];box(move(dx: -4.2pt, dy: -1.2pt, box(scale(65%)[A])));box(move(dx: -5.7pt, dy: 0pt, [T]));box(move(dx: -7.0pt, dy: 2.7pt, box(scale(100%)[E])));box(move(dx: -8.0pt, dy: 0pt, [X]));h(-8.0pt)
}

#let TeX = {
  [T];box(move(dx: -1.3pt, dy: 2.7pt, box(scale(100%)[E])));box(move(dx: -2.3pt, dy: 0pt, [X]));h(-2.3pt)
}
