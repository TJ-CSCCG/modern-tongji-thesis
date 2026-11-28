# Changelog

## [0.3.0](https://github.com/TJ-CSCCG/modern-tongji-thesis/compare/v0.2.0...v0.3.0) (2026-11-28)


### ⚠ BREAKING CHANGES

* songti, heiti, kaiti and fangsong are functions that set their argument in the chosen font set (#heiti[...]); font-family, font-presets, xiaobiaosong and xihei are removed. They always named the Fandol fonts, whatever fontset a thesis chose.

### 新增 | New Features

* add the task book, proposal and midterm report forms ([#22](https://github.com/TJ-CSCCG/modern-tongji-thesis/issues/22)) ([e9336e9](https://github.com/TJ-CSCCG/modern-tongji-thesis/commit/e9336e9b1563bb452afdd8c26ecec71c483093c2))
* align with the LaTeX template (2026 spec, GB/T 7714—2025, blind) ([#21](https://github.com/TJ-CSCCG/modern-tongji-thesis/issues/21)) ([98e5a41](https://github.com/TJ-CSCCG/modern-tongji-thesis/commit/98e5a416d6d65a946f04f2697c027e0af6893960))


### 修正 | Fixes

* exclude example-image, replace GFM alert boxes, improve alt text ([f5ce3e8](https://github.com/TJ-CSCCG/modern-tongji-thesis/commit/f5ce3e8f250057512f87d0b28cd3344e1bf24d8e))
* regenerate thumbnail at 1080px, update bump script ([168b0d5](https://github.com/TJ-CSCCG/modern-tongji-thesis/commit/168b0d53f0db4de5ac3e7a48921deaaebb7880fe))
* remove leaked packages directory, restore local template imports ([459e4f7](https://github.com/TJ-CSCCG/modern-tongji-thesis/commit/459e4f74e87c0f6d42626b6b43c37d1561c27cbe))
* revert example-image exclude, improve license alt text ([945e2a9](https://github.com/TJ-CSCCG/modern-tongji-thesis/commit/945e2a947df46f25dc88d84d5021b4c7c89e0a7e))


### 文档与维护 | Docs & Maintenance

* bump equate to 0.3.3 ([44015a4](https://github.com/TJ-CSCCG/modern-tongji-thesis/commit/44015a479f1116cddfac9bb39857a70c38a08bf5))
* fix LaTeX template link to TJ-CSCCG/TongjiThesis ([dcd64e0](https://github.com/TJ-CSCCG/modern-tongji-thesis/commit/dcd64e094438ebe6b38960438e2732ebaf4360f8))
* name workflows CI and Publish; fix the Fandol download ([#18](https://github.com/TJ-CSCCG/modern-tongji-thesis/issues/18)) ([d967238](https://github.com/TJ-CSCCG/modern-tongji-thesis/commit/d967238aa78f475afe1f6edaba1ee68d542a3291))
* release with release-please; Publish attaches the assets ([#19](https://github.com/TJ-CSCCG/modern-tongji-thesis/issues/19)) ([287578b](https://github.com/TJ-CSCCG/modern-tongji-thesis/commit/287578b503281067c15a1138803c110e10fb61e1))
