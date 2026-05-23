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

// Font presets — matching LaTeX template's fontset options.
// Each defines: song, hei, kai, fang (core four used by ctex).
// xiaobiaosong, xihei default to song/hei respectively if not specified.
// Uses `covers: "latin-in-cjk"` for proper Latin/CJK mixing.

#let font-presets = (
  // Fandol (default) — free, ships with TeX Live, available via `apt install fonts-fandol`
  fandol: (
    song: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "FandolSong"),
    hei:  ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "FandolHei"),
    kai:  ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "FandolKai"),
    fang: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "FandolFang"),
  ),
  // Windows — SimSun, SimHei, KaiTi, FangSong
  windows: (
    song: ((name: "Times New Roman", covers: "latin-in-cjk"), "SimSun", "Noto Serif CJK SC"),
    hei:  ((name: "Times New Roman", covers: "latin-in-cjk"), "SimHei", "Noto Sans CJK SC"),
    kai:  ((name: "Times New Roman", covers: "latin-in-cjk"), "KaiTi", "Noto Serif CJK SC"),
    fang: ((name: "Times New Roman", covers: "latin-in-cjk"), "FangSong", "Noto Serif CJK SC"),
  ),
  // macOS — Songti SC, Heiti SC, Kaiti SC, STFangsong
  mac: (
    song: ((name: "Times New Roman", covers: "latin-in-cjk"), "Songti SC", "Noto Serif CJK SC"),
    hei:  ((name: "Times New Roman", covers: "latin-in-cjk"), "Heiti SC", "Noto Sans CJK SC"),
    kai:  ((name: "Times New Roman", covers: "latin-in-cjk"), "Kaiti SC", "Noto Serif CJK SC"),
    fang: ((name: "Times New Roman", covers: "latin-in-cjk"), "STFangsong", "Noto Serif CJK SC"),
  ),
  // Adobe — AdobeSongStd, AdobeHeitiStd, AdobeKaitiStd, AdobeFangsongStd (commercial)
  adobe: (
    song: ((name: "Times New Roman", covers: "latin-in-cjk"), "AdobeSongStd-Light"),
    hei:  ((name: "Times New Roman", covers: "latin-in-cjk"), "AdobeHeitiStd-Regular"),
    kai:  ((name: "Times New Roman", covers: "latin-in-cjk"), "AdobeKaitiStd-Regular"),
    fang: ((name: "Times New Roman", covers: "latin-in-cjk"), "AdobeFangsongStd-Regular"),
  ),
  // Founder — 方正字库 (download from fonts branch, learning use only)
  founder: (
    song: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "FZShuSong-Z01"),
    hei:  ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "FZHei-B01"),
    kai:  ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "FZKai-Z03"),
    fang: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "FZFangSong-Z02"),
  ),
  // Noto — for Typst Web App (zero config)
  noto: (
    song: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "Noto Serif CJK SC"),
    hei:  ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "Noto Sans CJK SC"),
    kai:  ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "Noto Serif CJK SC"),
    fang: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "Noto Serif CJK SC"),
  ),
  // Auto: multi-platform fallback — tries macOS, Windows, then Noto
  "auto": (
    song: ((name: "Times New Roman", covers: "latin-in-cjk"), "Songti SC", "SimSun", "Noto Serif CJK SC"),
    hei:  ((name: "Times New Roman", covers: "latin-in-cjk"), "Heiti SC", "SimHei", "Noto Sans CJK SC"),
    kai:  ((name: "Times New Roman", covers: "latin-in-cjk"), "Kaiti SC", "KaiTi", "Noto Serif CJK SC"),
    fang: ((name: "Times New Roman", covers: "latin-in-cjk"), "FangSong", "Noto Serif CJK SC"),
  ),
)

// Default font-family — overridden by thesis() based on fontset
#let font-family = (
  song: font-presets.fandol.song,
  hei: font-presets.fandol.hei,
  kai: font-presets.fandol.kai,
  fangsong: font-presets.fandol.fang,
  xiaobiaosong: font-presets.fandol.song,
  xihei: font-presets.fandol.hei,
  code: ("DejaVu Sans Mono", "Fira Code"),
  math: ("New Computer Modern Math",),
)

#let songti = font-family.song
#let heiti = font-family.hei
#let fangsong = font-family.fangsong
#let kaiti = font-family.kai
#let xiaobiaosong = font-family.xiaobiaosong
#let xihei = font-family.xihei

#let ii = math.class("normal", $mono(i)$)
#let jj = math.class("normal", $mono(j)$)
#let ee = math.class("normal", $mono(e)$)

#let LaTeX = {
  [L];box(move(dx: -4.2pt, dy: -1.2pt, box(scale(65%)[A])));box(move(dx: -5.7pt, dy: 0pt, [T]));box(move(dx: -7.0pt, dy: 2.7pt, box(scale(100%)[E])));box(move(dx: -8.0pt, dy: 0pt, [X]));h(-8.0pt)
}

#let TeX = {
  [T];box(move(dx: -1.3pt, dy: 2.7pt, box(scale(100%)[E])));box(move(dx: -2.3pt, dy: 0pt, [X]));h(-2.3pt)
}
