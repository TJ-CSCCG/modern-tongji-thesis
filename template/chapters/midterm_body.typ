#import "../../lib.typ": *

#form-notice[填写说明]

#form-notice-body(
  [请每位学生根据学校及学院检查的要求认真进行自查，及时发现课题研究过程中存在的问题，分析原因，并提出解决思路和措施，明确下一阶段任务。],
  [每位学生应根据项目实施情况认真、实事求是填写。],
  [该表填写完毕后，须请指导教师审核，并签署意见。],
  [《同济大学本科生毕业设计（论文）中期检查报告》将作为答辩资格审查的主要材料之一。],
)

#pagebreak()

#form-section[一、课题进展情况]
#form-hint[是否按开题报告的内容及进度安排进行]
#form-hint[请在此处填写课题进展情况。]

#form-section[二、课题研究已取得的阶段性成果：]
#form-hint[已完成的研究工作及成果]
#form-hint[请在此处填写已取得的阶段性成果。]

#form-section[三、存在的问题与解决思路]
#form-hint[请在此处填写存在的问题与解决思路。]

#form-section[四、下一阶段的工作计划和研究内容]
#form-hint[请在此处填写下一阶段的工作计划和研究内容。]

#form-section[五、审核意见]

#review-box[
  #form-label[指导教师意见：]#form-hint[（建议对各项内容给与意见和评价，字数不限。）]

  #v(7 * 23.4pt)
  #form-signature([指导教师签名])
]

#review-box[
  #form-label[专业审核意见：]

  #v(1.5 * 23.4pt)
  // 默认两格均留空，供打印后手写勾选；如需提前标注，在 chapters/metadata.typ 中设置 midterm-decision
  #midterm-decision()

  #v(5 * 23.4pt)
  #form-signature([负责人签名])
]
