// ============================================================
//  封面信息
// ============================================================
#let school = "计算机科学与技术学院"
#let major = "计算机科学与技术"
#let id = "2654321"
#let student = "张同舟"
#let advisor = "李共济" + h(1em) + "教授"
#let title = "同济大学本科毕业设计（论文）模板与Typst排版技术应用"
#let subtitle = "模板排版功能示例、学术写作规范与格式设置指南"
// 英文题名：仅首词与专有名词首字母大写（撰写规范）
#let title-english = "Template and Typst typesetting for Tongji University undergraduate thesis"
#let subtitle-english = "A guide to typesetting features, academic writing standards, and formatting"
#let date = datetime(year: datetime.today().year(), month: datetime.today().month(), day: datetime.today().day())

// 任务书起讫时间（仅编译 taskbook.typ 时使用）；周数由起讫日期自动换算（向上取整）
#let taskbook-start = datetime(year: 2026, month: 9, day: 1)
#let taskbook-end = datetime(year: 2027, month: 6, day: 30)

// 中期报告“专业审核意见”的同意/不同意复选框（仅编译 midterm.typ 时使用）：
// none 时两格均留空，供打印后手写勾选；也可设为 "agree" 或 "disagree"
#let midterm-decision = none

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
// 在正文末尾插入 #wordcount() 可显示自动统计的字数作为参考
#let infothesiswords = "12345"

// 随附资料（每条一个字符串；留空数组 [] 则显示空白行）
#let infomaterials = (
  "随附资料名称一（如：全套图纸、程序源代码、计算书等）；",
  "随附资料名称二",
)

// ============================================================
//  摘要页论文标题（可选）
// ============================================================
// 设置摘要页展示的论文标题（非摘要 section 名称）。未设置时沿用 title 与 title-english。
// #let abstract-title = "自定义摘要标题"
// #let abstract-subtitle = "自定义摘要副标题"
// #let abstract-title-english = "Custom Abstract Title"
// #let abstract-subtitle-english = "Custom Abstract Subtitle"
#let abstract-title = none
#let abstract-subtitle = none
#let abstract-title-english = none
#let abstract-subtitle-english = none
