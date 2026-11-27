#!/bin/bash
# Download required fonts to the fonts/ directory.
#
# Fonts downloaded:
#   - Fandol (CJK: Song, Hei, Kai, Fang)
#   - TeX Gyre Termes (Latin serif for Chinese-English mixing)
#   - HaranoAjiMincho (circled numbers ①–㊿)
#
# Usage:
#   ./scripts/download-fonts.sh

set -euo pipefail

FONTS_DIR="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$FONTS_DIR"

echo "Downloading fonts to $FONTS_DIR ..."

# mirrors.ctan.org sends each request to a random mirror, and some mirrors lag
# or fail TLS, so a failed download is retried (on another mirror) and an HTTP
# error fails the script instead of saving an error page as the zip.
download_ctan() {
  local name="$1"
  local url="$2"
  local pattern="$3"
  echo "  → $name"
  curl -fsSL --retry 3 --retry-all-errors "$url" -o /tmp/typst-fonts.zip
  unzip -qo /tmp/typst-fonts.zip -d /tmp/typst-fonts-tmp
  find /tmp/typst-fonts-tmp -name "$pattern" -exec cp {} "$FONTS_DIR/" \;
  rm -rf /tmp/typst-fonts.zip /tmp/typst-fonts-tmp
}

# Fandol CJK. CTAN moved Fandol to its obsolete area when the authors withdrew
# it; TJ-CSCCG/cjk-fonts-for-ctex releases the same files.
download_ctan "Fandol" \
  "https://github.com/TJ-CSCCG/cjk-fonts-for-ctex/releases/latest/download/fandol.zip" \
  "*.otf"

# TeX Gyre Termes
download_ctan "TeX Gyre Termes" \
  "https://mirrors.ctan.org/fonts/tex-gyre.zip" \
  "texgyretermes*.otf"

# HaranoAjiMincho
download_ctan "HaranoAjiMincho" \
  "https://mirrors.ctan.org/fonts/haranoaji.zip" \
  "HaranoAjiMincho*.otf"

echo ""
echo "Done. Fonts in $FONTS_DIR:"
ls -la "$FONTS_DIR"
echo ""
echo "Now compile with:"
echo "  typst compile init-files/main.typ thesis.pdf --root . --font-path ./fonts"
