// ============================================================
//  文档类选项（在 main.typ 的 thesis.with(...) 中设置）
//  field: "science"     理工科（工科类、理科类，默认）— 章节编号：1 / 1.1 / 1.1.1
//  field: "humanities"  文科  （人文、法学、外语、艺术）     — 章节编号：一、/（一）/ 1.
//  经管类属社科：编号要求依理工，撰写依理工模版；26 届为过渡期，可选 science 或
//  humanities；自 27 届起统一使用 science。
// ============================================================

// ============================================================
//  封面信息
// ============================================================
#let school = "计算机科学与技术学院"
#let major = "计算机科学与技术"
#let id = "2654321"
#let student = "张同舟"
#let advisor = "李共济  教授"
#let title = "同济大学本科毕业设计（论文）模板与Typst排版技术应用"
#let subtitle = "模板排版功能示例、学术写作规范与格式设置指南"
#let title-english = "Template and Typst Typesetting for Tongji University Undergraduate Thesis"
#let subtitle-english = "A Guide to Typesetting Features, Academic Writing Standards, and Formatting"
#let date = datetime(year: datetime.today().year(), month: datetime.today().month(), day: datetime.today().day())

// ============================================================
//  信息说明页
// ============================================================

// 成果类型（三选一）：
//   "thesis"      — 毕业论文，摘要
//   "design"      — 毕业设计（软件/创意/建筑等非工程设计类），摘要
//   "engineering" — 毕业设计（工程设计类），设计总说明
#let infotype = "thesis"

// 内容简述（请用300字以内简要概述）
#let infoabstract = [
  请在此处填写论文内容简述，字数建议不超过300字。内容简述应概括论文的研究背景与问题动机、研究目标、主要方法与技术路线、实验设计与数据来源、关键实验结果及性能指标，以及研究结论与创新点，使读者能够快速了解本论文的核心贡献与研究意义。建议按照以下结构来组织简述内容：首先介绍研究背景与问题动机，充分说明研究的必要性与现有相关工作的主要不足之处；其次阐述所提出的方法或技术方案及其设计原理与主要实现细节；然后给出在典型数据集或实际应用场景下的主要实验结果与量化评价指标的全面横向对比分析；最后总结本研究的主要结论与当前局限性，并展望未来改进方向与潜在应用前景。请将以上示例文字全部替换为您的实际内容简述。
]

// 毕业设计：图纸数量与正文字数（成果类型为 design 或 engineering 时填写，两者须同时填写）
// #let infodrawings = "5"
// #let infowordcount = "15000"
#let infodrawings = ""
#let infowordcount = ""

// 毕业论文：正文总字数（成果类型为 thesis 时填写）
#let infothesiswords = "12345"

// 随附资料（每条一个字符串；留空数组 [] 则显示空白行）
#let infomaterials = (
  "随附材料名称一（如：全套图纸、程序源代码、计算书等）；",
  "随附材料名称二",
)

// ============================================================
//  中英文摘要页
// ============================================================

// 摘要页论文标题（可选）：设置摘要页展示的论文标题（非摘要 section 名称）。未设置时沿用 title 与 title-english。
// #let abstract-title = "自定义摘要标题"
// #let abstract-subtitle = "自定义摘要副标题"
// #let abstract-title-english = "Custom Abstract Title"
// #let abstract-subtitle-english = "Custom Abstract Subtitle"
#let abstract-title = none
#let abstract-subtitle = none
#let abstract-title-english = none
#let abstract-subtitle-english = none

// ============================================================
//  中英文摘要
// ============================================================
#let abstract = [
  摘要通常是一篇文章、论文、报告或其他文本的简短概括。它的目的是帮助读者了解文本的主要内容和结论，以便决定是否需要继续阅读原文。摘要通常包含文本的主题、目的、方法、结果和结论等方面的信息，并尽可能简洁明了地呈现。好的摘要应该能够概括文本的重点，同时避免使用不必要的细节和专业术语，以便广大读者能够轻松理解。

  此外，摘要通常也是学术界和研究人员评估一篇文献的重要依据之一。在文献检索和筛选过程中，人们通常会根据摘要来决定是否进一步查看完整的文献。因此，撰写一个清晰、准确、简洁的摘要对于文献的传播和影响力至关重要。在撰写摘要时，作者应该遵循文献的格式要求和撰写规范，同时结合文本的内容和目的，将摘要撰写得准确、简洁、易懂，以提高文献的传播和影响力。

  关键词1，关键词2，关键词3通常是与文章内容相关的几个词语，用于帮助读者更好地了解文章主题和内容。关键词的选择应该与文章的主题和研究领域密切相关，通常应该选择具有代表性、权威性、独特性和可搜索性的词语。
]

#let keywords = ("关键词1", "关键词2", "关键词3")

#let abstract-english = [
  An abstract is usually a short summary of an article, essay, report, or other
  text. Its purpose is to help the reader understand the main content and
  conclusions of the text so that he or she can decide whether he or she needs to
  continue reading the original text. The abstract usually contains information
  about the topic, purpose, methods, results, and conclusions of the text and is
  presented as concisely and clearly as possible. A good abstract should be able
  to summarize the main points of the text while avoiding unnecessary details and
  jargon so that it can be easily understood by a wide audience.

  In addition, abstracts are often one of the most important bases on which
  academics and researchers evaluate a piece of literature. During the literature
  search and selection process, people often base their decision to look further
  into the complete literature on the abstract. Therefore, writing a clear,
  accurate, and concise abstract is crucial to the dissemination and impact of the
  literature. When writing an abstract, authors should follow the formatting
  requirements and writing specifications of the literature, as well as combine
  the content and purpose of the text to write an accurate, concise, and
  easy-to-understand abstract in order to improve the dissemination and impact of
  the literature.

  Keyword 1, Keyword 2, and Keyword 3 are usually a few words related to the
  content of the article and are used to help readers better understand the topic
  and content of the article. The choice of keywords should be closely related to
  the topic and research area of the article, and words that are representative,
  authoritative, unique, and searchable should usually be chosen.
]

#let keywords-english = ("Keyword 1", "Keyword 2", "Keyword 3")

// ============================================================
//  字体与参考文献
// ============================================================
// 字体集：auto（自动） / noto（Web App） / fandol / mac / windows / adobe / founder
#let fontset = "fandol"

// 参考文献数据库文件路径
#let bib-path = "bib/note.bib"
