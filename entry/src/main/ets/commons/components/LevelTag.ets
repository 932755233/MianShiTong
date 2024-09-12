interface TagInfo {
  text: string
  color: ResourceStr
}

// 描述tag标签配置信息的对象
const infoMap: Record<number, TagInfo> = {
  1: { text: '简单', color: $r('app.color.common_green') },
  2: { text: '简单', color: $r('app.color.common_green') },
  3: { text: '一般', color: $r('app.color.common_blue') },
  4: { text: '一般', color: $r('app.color.common_blue') },
  5: { text: '困难', color: $r('app.color.common_main_color') }
}

@Component
export struct LevelTag {
  // 1-2 简单 - 文字，颜色
  // 3-4 一般
  // 5   困难
  @Prop
  difficulty: number = 1
  // 为了兼容自定义文字和颜色
  @Prop
  text: string = ''
  @Prop
  color: ResourceColor = ''

  build() {
    // 新建tag文件
    Row() {
      Text(infoMap[this.difficulty].text)
        .fontColor(infoMap[this.difficulty].color)
        .fontSize(10)
        .padding({
          right: 6,
          left: 6
        })
        .height(18)
        .borderRadius(2)
        .textAlign(TextAlign.Center)
        .constraintSize({
          //最小宽度
          minWidth: 34
        })
        .backgroundColor($r('app.color.common_gray_bg'))
    }
  }
}