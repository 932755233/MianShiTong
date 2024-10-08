import { LevelTag } from '.'
import { QuestionItem } from '../../model'

@Preview
@Component
export struct QuestionItemComp {
  // 1.困难程度
  // 2.标题
  // 3.点赞数量
  // 4.浏览数量
  // 5.是否阅读过
  // 参数过多建议直接传递类
  @Require
  @Prop
  item: QuestionItem = {} as QuestionItem

  build() {
    Column({ space: 10 }) {
      Row({ space: 10 }) {
        LevelTag({ difficulty: this.item.difficulty })
        Text(this.item.stem)
          .layoutWeight(1)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }

      RowSplit() {
        Text('点赞' + this.item.likeCount)
          .grayText(true)
        Text('浏览' + this.item.views)
          .grayText()
        if (this.item.readFlag === 1) {
          Text('已看过')
            .grayText()
        }
      }
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height(80)
    .padding({
      left: 16,
      right: 16
    })
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