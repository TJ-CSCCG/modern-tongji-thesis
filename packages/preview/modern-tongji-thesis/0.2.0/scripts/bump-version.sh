#!/bin/bash
# Bump version across all files and optionally create a git tag.
#
# Usage:
#   ./scripts/bump-version.sh <new-version> [--tag]
#
# Examples:
#   ./scripts/bump-version.sh 0.2.1
#   ./scripts/bump-version.sh 0.2.1 --tag
#
# Updates:
#   - package.json              "version" field
#   - typst.toml                "version" field
#   - .github/patches/package_release.diff   version in import paths
#   - thumbnail.png             regenerated from compiled PDF first page

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <new-version> [--tag]"
  echo "Example: $0 0.2.1 --tag"
  exit 1
fi

NEW_VERSION="$1"
CREATE_TAG=false
if [ "${2:-}" = "--tag" ]; then
  CREATE_TAG=true
fi

if ! echo "$NEW_VERSION" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$'; then
  echo "Error: version must be in X.Y.Z format (got '$NEW_VERSION')"
  exit 1
fi

OLD_VERSION=$(grep '^version' typst.toml | head -1 | sed 's/.*= "//;s/"//')

if [ "$OLD_VERSION" = "$NEW_VERSION" ]; then
  echo "Error: new version ($NEW_VERSION) is the same as current version"
  exit 1
fi

echo "Bumping $OLD_VERSION → $NEW_VERSION"

# package.json
jq ".version = \"$NEW_VERSION\"" package.json > package.json.tmp && mv package.json.tmp package.json

# typst.toml
sed -i.bak "s/version = \"${OLD_VERSION}\"/version = \"${NEW_VERSION}\"/" typst.toml
rm typst.toml.bak

# package_release.diff
sed -i.bak "s/@preview\/modern-tongji-thesis:${OLD_VERSION}/@preview\/modern-tongji-thesis:${NEW_VERSION}/g" .github/patches/package_release.diff
rm .github/patches/package_release.diff.bak

echo ""
echo "Updated files:"
grep -n "version" package.json typst.toml | head -5
grep "modern-tongji-thesis:" .github/patches/package_release.diff | head -3

# Regenerate thumbnail from PDF first page
echo ""
echo "Regenerating thumbnail..."
typst compile template/main.typ /tmp/thumbnail.pdf --root .
magick -density 300 "/tmp/thumbnail.pdf[0]" -background white -alpha remove -alpha off -resize 512x512 thumbnail.png
echo "  thumbnail.png updated ($(wc -c < thumbnail.png | tr -d ' ') bytes)"
rm /tmp/thumbnail.pdf

echo ""
git diff --stat

git add package.json typst.toml .github/patches/package_release.diff thumbnail.png
git commit -m "chore: bump version to v${NEW_VERSION}"

if [ "$CREATE_TAG" = true ]; then
  git tag "v${NEW_VERSION}"
  echo ""
  echo "Tagged v${NEW_VERSION}. Push with:"
  echo "  git push && git push origin v${NEW_VERSION}"
else
  echo ""
  echo "Done. To also create a tag, run:"
  echo "  git tag v${NEW_VERSION}"
  echo "  git push && git push origin v${NEW_VERSION}"
fi
