#!/bin/bash

MAIN_BRANCH="main"
PACKAGE_RELEASE_BRANCH="package"

set -e

git branch -D $PACKAGE_RELEASE_BRANCH || true

git checkout -b $PACKAGE_RELEASE_BRANCH origin/$MAIN_BRANCH

# Replace local lib.typ imports with @preview imports
VERSION=$(grep '^version' typst.toml | head -1 | sed 's/.*= "//;s/"//')

find template -name '*.typ' -exec sed -i.bak \
  "s|#import \"\.\./lib.typ\": \*|#import \"@preview/modern-tongji-thesis:${VERSION}\": *|g" \
  {} \; -exec sed -i.bak \
  "s|#import \"\.\./\.\./lib.typ\": \*|#import \"@preview/modern-tongji-thesis:${VERSION}\": *|g" \
  {} \;

find template -name '*.bak' -delete

git add .

git commit -m "Applied package releasing patch to \`main\` branch"

git push origin $PACKAGE_RELEASE_BRANCH --force
