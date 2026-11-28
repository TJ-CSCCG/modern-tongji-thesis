#!/bin/bash
# Turns this checkout into the package submitted to Typst Universe:
#
#   1. Renders thumbnail.png from the template's first page. Typst Universe
#      asks for a longer edge of at least 1080 px; an A4 page at 93 ppi is
#      769 x 1087 px.
#   2. Rewrites the template's imports of the local lib.typ into imports of
#      @preview/modern-tongji-thesis:<version>, with the version typst.toml
#      holds. No other file carries the version, so release-please bumping
#      typst.toml is all a release needs.
#
# The thumbnail is rendered first, while the template still imports the local
# lib.typ, because the @preview version it is rewritten to is not published yet.
#
# Run it from the repository root after fonts/download-fonts.sh. publish.yml
# runs it on the release tag and pushes the result to the `package` branch, the
# tree the Typst Universe submission is copied from; ci.yml runs it on every
# change and compiles a project created from the result with `typst init`.

set -euo pipefail

VERSION=$(sed -n 's/^version = "\(.*\)"$/\1/p' typst.toml)
if [ -z "$VERSION" ]; then
  echo "::error::typst.toml has no version line."
  exit 1
fi

typst compile template/main.typ thumbnail.png \
  --root . --font-path fonts --pages 1 --ppi 93

find template -name '*.typ' -exec sed -i.bak -E \
  "s|#import \"(\.\./)+lib\.typ\"|#import \"@preview/modern-tongji-thesis:${VERSION}\"|" {} +
find template -name '*.typ.bak' -delete

# `typst init` copies only template/, so a path back to lib.typ that is left
# would break every project created from the package.
if grep -rn --include='*.typ' '"[^"]*lib\.typ"' template; then
  echo "::error::The template files above still import lib.typ by path."
  exit 1
fi

echo "Packaged modern-tongji-thesis ${VERSION}."
