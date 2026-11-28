#!/bin/bash
# Downloads the fonts the template uses into the fonts/ directory.
#
# Always downloaded:
#   - The free CJK set (fontset "texlive", the LaTeX template's fontset=texlive):
#     LXGW Neo ZhiSong, LXGW Neo XiHei, LXGW Zhuque Fangsong (CTAN lxgw-fonts)
#     and AR PL KaitiM GB (CTAN arphic-ttf)
#   - TeX Gyre Termes (Latin serif for Chinese-English mixing)
#   - Harano Aji Mincho (circled numbers ①–㊿)
#
# With a set name, also downloads that set from the latest
# TJ-CSCCG/cjk-fonts-for-ctex release, as the LaTeX template's `make fonts` does:
#   windows  SimSun, SimHei, KaiTi, FangSong: the fonts of the official Word
#            template, which fontset "auto" prefers when they are present
#   founder, adobe, fandol
#
# Usage, from the repository root:
#   ./fonts/download-fonts.sh [windows|founder|adobe|fandol]

set -euo pipefail

FONTS_DIR="$(cd "$(dirname "$0")" && pwd)"
SET_NAME="${1:-}"
case "$SET_NAME" in
  ""|windows|founder|adobe|fandol) ;;
  *) echo "Unknown font set: $SET_NAME (expected windows, founder, adobe or fandol)" >&2; exit 2 ;;
esac

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "Downloading fonts to $FONTS_DIR ..."

# Downloads a zip and copies the files matching each pattern into fonts/.
# mirrors.ctan.org sends each request to a random mirror, and some mirrors lag
# or fail TLS, so a failed download is retried (on another mirror) and an HTTP
# error fails the script instead of saving an error page as the zip.
download() {
  local name="$1" url="$2"
  shift 2
  echo "  → $name"
  rm -rf "$TMP/zip" "$TMP/files.zip"
  curl -fsSL --retry 3 --retry-all-errors "$url" -o "$TMP/files.zip"
  unzip -qo "$TMP/files.zip" -d "$TMP/zip"
  local pattern
  for pattern in "$@"; do
    find "$TMP/zip" -name "$pattern" -exec cp {} "$FONTS_DIR/" \;
  done
}

download "LXGW Neo ZhiSong, LXGW Neo XiHei, LXGW Zhuque Fangsong" \
  "https://mirrors.ctan.org/fonts/lxgw-fonts.zip" \
  "LXGWNeoZhiSong.ttf" "LXGWNeoXiHei.ttf" "LXGWZhuqueFangsong-Regular.ttf"

download "AR PL KaitiM GB" \
  "https://mirrors.ctan.org/fonts/arphic-ttf.zip" \
  "gkai00mp.ttf"

download "TeX Gyre Termes" \
  "https://mirrors.ctan.org/fonts/tex-gyre.zip" \
  "texgyretermes*.otf"

download "Harano Aji Mincho" \
  "https://mirrors.ctan.org/fonts/haranoaji.zip" \
  "HaranoAjiMincho*.otf"

if [ -n "$SET_NAME" ]; then
  download "$SET_NAME font set" \
    "https://github.com/TJ-CSCCG/cjk-fonts-for-ctex/releases/latest/download/${SET_NAME}.zip" \
    "*.ttf" "*.ttc" "*.otf" "*.TTF"
fi

echo ""
echo "Done. Fonts in $FONTS_DIR:"
ls "$FONTS_DIR"
echo ""
echo "Now compile with:"
echo "  typst compile template/main.typ thesis.pdf --root . --font-path ./fonts"
