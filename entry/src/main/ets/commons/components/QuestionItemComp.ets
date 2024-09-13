import { LevelTag } from '.'

@Preview
@Component
export struct QuestionItemComp {
  // 1.困难程度
  // 2.标题
  // 3.点赞数量
  // 4.浏览数量
  // 5.是否阅读过
  // 参数过多建议直接传递类


  build() {
    Column({ space: 10 }) {
      Row({ space: 10 }) {
        LevelTag({ difficulty: 1 })
        Text('如何进行项目介绍如何进行项目介绍如何进行项目介绍如何进行项目介绍')
          .layoutWeight(1)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }

      RowSplit() {
        Text('点赞4')
          .grayText(true)
        Text('浏览838')
          .grayText()
        Text('已看过')
          .grayText()
      }
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height(80)
  }
}

@Extend(Text)
function grayText(isStart: boolean = false) {
  .fontSize(12)
  .fontColor($r('app.color.common_gray_01'))
  .padding({
    left: isStart ? 0 : 12,
    right: 12
  })
}