#import "../../lib.typ": *

= 引用 <reference>

在本章（@reference）中，我们将探讨如何在 Typst
中进行参考文献引用和交叉引用，以便于读者查阅文献和方便地引用文档中的其他部分。

== 参考文献的引用

在学术论文或科技报告中，通常需要引用相关文献以支持观点或论证。为了方便读者查阅，我们需要在论文中标注参考文献。本模板按 GB/T 7714—2025 的顺序编码制排版参考文献，样式文件为 `csl/gb-t-7714-2025-numeric.csl`（取自 CSL 官方样式库，按撰写规范改为半角标点），正文引用为上标，连续的引用自动合并。参考文献数据可以写在 BibLaTeX（`.bib`）或 Hayagriva（`.yml`）文件中，在 `main.typ` 的 `bib-path` 中列出。

在正文中，可使用 ```typ @``` 命令引用参考文献。例如：

#table(columns: (1fr, 1fr), [
  #set align(center)
  #strong[代码]
], [
  #set align(center)
  #strong[渲染结果]
], ```typ
这是一个引用示例 @book1。
  ```, [
  #h(2em)这是一个引用示例 @book1。
])

其中，`book1` 是参考文献的键值，即参考文献文件中每个条目的唯一标识符。引用命令会自动在文中插入相应文献序号，并在文末的参考文献列表中显示相应文献条目。

如果需要同时标注多个参考文献，把引用连续写出即可，模板会把它们合并为 `[1,2]` 或 `[1-3]` 的形式；也可以使用 `#multicite()` 命令。例如：

#table(columns: (1fr, 1fr), [
  #set align(center)
  #strong[代码]
], [
  #set align(center)
  #strong[渲染结果]
], ```typ
多个引用 @book1 @online1，或 #multicite("book1", "online1")。
  ```, [
  #h(2em)多个引用 @book1 @online1，或 #multicite("book1", "online1")。
])

引用某一页时，把页码写在引用后的方括号中，页码以上标排在序号之后。例如：

#table(columns: (1fr, 1fr), [
  #set align(center)
  #strong[代码]
], [
  #set align(center)
  #strong[渲染结果]
], ```typ
见文献@qin2021[217-218]。
  ```, [
  #h(2em)见文献@qin2021[217-218]。
])

以下是各类文献的引用示例：

- 普通图书#multicite("book1", "book2")
- 论文集、会议录#multicite("conf1", "conf2")
- 科技报告#multicite("techreport1", "techreport2")
- 学位论文#multicite("thesis1", "thesis2", "thesis3")
- 专利文献#multicite("patent1", "patent2")
- 专著中析出的文献#multicite("inbook1", "inbook2")
- 期刊中析出的文献#multicite("qin2021", "article1", "guo_deepseek-r1_2025")
- 报纸中析出的文献#multicite("newspaper1", "newspaper2")
- 电子文献#multicite("online1", "online2", "online3")
- 预印本#multicite("preprint1", "preprint2")

GB/T 7714—2025 对英文文献的著录与 LaTeX 模板一致的部分由样式自动完成，以下几点需要在文献数据中写好：

- 英文题名按原样输出。请写作句首大写，如 `Deep residual learning for image recognition`，专有名词与缩写照常大写。
- 英文文献的版本项写作 `edition = {3rd ed.}`；中文文献写数字即可，输出为“3 版”。
- 学位论文的保存单位、报告的出版者除 `school`、`institution` 外，另写在 `publisher` 中，样式只读取后者。
- BibLaTeX 没有报纸与预印本类型，Typst 读取 `.bib` 文件时无法给出 [N] 与 [PP]。这两类文献请写在 Hayagriva 格式的 `ref.yml` 中，写法见该文件中的示例。

另外，为了避免遗漏引用，有时候需要使用文献管理工具来管理参考文献，例如 Zotero 或
EndNote
等。这些工具可以帮助你轻松管理文献数据库，生成参考文献列表，甚至将参考文献直接插入到文档中。

无论使用何种方法，都应该注意文献的准确性和完整性。在引用文献时，应尽可能使用最新的版本，并注意对文献信息的正确引用和格式化。这样可以提高文献的可信度，也能为读者提供更多参考信息。

== 脚注

脚注是一种在文本底部添加注释或补充说明的方式。我们可以使用 `footnote` 命令添加脚注。

#table(
  columns: (1fr, 1fr), [
    #set align(center)
    #strong[代码]
  ], [
    #set align(center)
    #strong[渲染结果]
  ], ```typ
  脚注是一种在文本底部添加注释或补充说明的方式#footnote[通常，我们在脚注里也写完整的句子。在文本中使用脚注时，应该遵循学术规范，尽可能引用可信的来源。]。
    ```, [
    #h(2em)脚注是一种在文本底部添加注释或补充说明的方式#footnote[通常，我们在脚注里也写完整的句子。在文本中使用脚注时，应该遵循学术规范，尽可能引用可信的来源。]。
  ],
)

其中，中括号中的文本就是脚注的内容。编译文档后，脚注会出现在页面底部，并自动标上数字。

需要注意的是，在使用脚注时，应该尽量避免使用过多的脚注，以免影响文本的阅读体验。同时，脚注的内容应该尽可能简洁明了，突出重点，有助于读者理解和记忆文本内容。对于自己的观点和推断，应该明确标注为个人观点，以免误导读者。

== 交叉引用

在文档中，交叉引用是指引用文档中的某个标签或标记，例如章节、图表、公式或页码等。在
Typst 中，可以使用 ```typ <label>``` 命令为文档中的对象添加标签，使用 ```typ @``` 命令进行引用。

例如，我们可以在文档的其他位置使用 ```typ @``` 命令来引用@introduction：

#table(columns: (1fr, 1fr), [
  #set align(center)
  #strong[代码]
], [
  #set align(center)
  #strong[渲染结果]
], ```typ
请参见@introduction。
  ```, [
  #h(2em)请参见@introduction。
])

引用其他章的图、表与公式时，编号为它们所在章的编号，如第 4 章的@fig:multifigure1 与@tbl:table1、第 2 章的@eq:harmonic-oscillator。

交叉引用在文档中很常用，可以帮助读者快速定位到相关内容，提高文档的可读性。但是，需要注意标签的唯一性和正确性，以及引用命令的正确使用方式。

由于我们对 Typst
中的浮动体（图表等）和公式的计数器进行了特殊处理，因此在引用浮动体和公式时，需要一些额外的操作。请参见@floats。
