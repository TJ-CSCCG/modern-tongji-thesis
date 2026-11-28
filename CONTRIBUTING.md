# 贡献指南 | Contributing

## 仓库结构 | Repository Structure

- **源文件**：`lib.typ` 以及 `utils/`、`layouts/` 目录下的 `.typ` 模板文件。
- **文档文件**：`template/` 目录下的 `.typ` 文件（包括 `main.typ`），用于展示模板的使用方法。
- **配置文件**：规范开发与使用的文件（如 `.gitignore`、`typst.toml`、`.editorconfig`）。

## 如何贡献 | How to Contribute

### 寻求帮助 | Asking for Help

我们通过 [Discussions](https://github.com/TJ-CSCCG/modern-tongji-thesis/discussions) 提供技术支持。

**请勿通过即时通讯工具直接联系贡献者。**

### 反馈 Bug | Reporting a Bug

如确认存在 Bug，请通过 [Issue](https://github.com/TJ-CSCCG/modern-tongji-thesis/issues) 模板提交反馈。

### 提交 Pull Request

1. Fork 本仓库。
2. 将 Fork 后的仓库克隆到本地。
3. 创建一个新分支进行修改。
4. 提交更改到新分支。
5. 将分支推送到你的 Fork 仓库。
6. 从你的分支向本仓库发起 Pull Request。

### Pull Request 前的检查清单 | Before Your PR

PR 标题与提交信息遵循 [Conventional Commits](https://www.conventionalcommits.org/zh-hans/)，例如 `feat: 新增跨页续表`、`fix: 修正列表基线偏移`。发布工具 release-please 据此生成更新日志并决定下一个版本号：`feat` 记入“新增”并提升次版本号，`fix` 记入“修正”并提升修订号，`refactor` 与 `perf` 记入“规范对齐”，`docs`、`chore`、`ci`、`build` 记入“文档与维护”。

PR titles and commit messages follow [Conventional Commits](https://www.conventionalcommits.org/), e.g. `feat: add continued tables` or `fix: correct the list baseline`. release-please reads them to write the changelog and choose the next version: `feat` goes under New Features and bumps the minor version, `fix` goes under Fixes and bumps the patch version, `refactor` and `perf` go under Spec Alignment, and `docs`, `chore`, `ci` and `build` go under Docs & Maintenance.

模板中的文件统一通过 `#import "../lib.typ": *`（按目录层级调整 `../` 的个数）引用本仓库，发布时会被自动替换为 `@preview` 引用，无需手动维护补丁。

Template files import this repository with `#import "../lib.typ": *` (one `../` per directory level). Publishing rewrites these imports to `@preview` imports, so there is no patch file to maintain.

## 发布流程 | Releasing

版本号由 release-please 维护，请勿手动修改 `typst.toml` 或 `package.json` 中的版本号。如需指定版本号，在提交信息末尾加一行 `Release-As: X.Y.Z`。

release-please maintains the version: do not edit it in `typst.toml` or `package.json` by hand. To choose a version, end a commit message with a `Release-As: X.Y.Z` line.

1. 每次推送到 `main` 后，[Release PR](.github/workflows/release-please.yml) 工作流更新一个发布 PR：它写入 `CHANGELOG.md`，并提升 `package.json` 与 `typst.toml` 中的版本号。
   On every push to `main`, the [Release PR](.github/workflows/release-please.yml) workflow updates a release PR that writes `CHANGELOG.md` and bumps the version in `package.json` and `typst.toml`.
2. 维护者合并发布 PR 后，release-please 创建 `vX.Y.Z` 标签和一个以更新日志为正文的草稿 Release。
   Merging the release PR creates the `vX.Y.Z` tag and a draft release whose notes are the changelog.
3. 维护者检查并发布该草稿。[Publish](.github/workflows/publish.yml) 随即从该标签编译理工科与文科示例 PDF、打包源码并附加到 Release，然后重建 `package` 分支：模板中的 `lib.typ` 引用改为 `@preview/modern-tongji-thesis:X.Y.Z`，并由模板首页生成 `thumbnail.png`。手动运行 Publish 并填写标签，可为该版本重新生成附件与 `package` 分支。
   A maintainer reviews and publishes the draft. [Publish](.github/workflows/publish.yml) then builds the science and humanities PDFs and the source tarball from the tag, attaches them to the release, and rebuilds the `package` branch: the template's `lib.typ` imports become `@preview/modern-tongji-thesis:X.Y.Z` and `thumbnail.png` is rendered from the template's first page. Running Publish by hand with a tag rebuilds that release's assets and the `package` branch.
4. 将 `package` 分支中的包文件（不含 `.github/`、`.gitignore` 与 release-please 配置等仓库文件）复制到 [typst/packages](https://github.com/typst/packages) fork 的 `packages/preview/modern-tongji-thesis/X.Y.Z/` 目录，并向 typst/packages 提交 PR。
   Copy the package files from the `package` branch (leaving out repository files such as `.github/`, `.gitignore` and the release-please configuration) into `packages/preview/modern-tongji-thesis/X.Y.Z/` of a [typst/packages](https://github.com/typst/packages) fork, and open a pull request to typst/packages.

## 项目历史 | Project History

| 日期    | 贡献者                                      | 贡献内容                                                                                                         |
| ------- | ------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| 2024.06 | [FeO3](https://github.com/seashell11234455) | 项目起源，创建初始 Typst 模板                                                                                    |
| 2024.07 | [RizhongLin](https://github.com/RizhongLin) | 开始贡献，完善模板格式、增加 Typst 教程，持续维护更新                                                            |
| 2025.05 | —                                           | 全面对齐 LaTeX 模板：字体集系统、信息说明页、定理环境、附录、gb7714-bilingual 参考文献、双学科模式、CI/CD 工作流 |
| 2026.11 | [RizhongLin](https://github.com/RizhongLin) | 对齐 2026 年 10 月修订的撰写规范与 LaTeX 模板：逐页版式、`fontset: "auto"` 与 Word 式描边加粗、GB/T 7714—2025 参考文献（CSL）、盲审版本 |

我们非常感谢以上贡献者的付出。如果您觉得本项目对您的毕业设计或论文有所帮助，希望您可以在致谢部分提及。
