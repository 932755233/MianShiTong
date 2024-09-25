@Component
export struct SkeletonItem {
  widthValue: Length = '100%'
  text: string = ''
  bgColor: ResourceColor = Color.Gray

  build() {
    //骨架屏单元
    Text(this.text)
      .height(16)
      .width(this.widthValue)
      .borderRadius(2)
      // .backgroundColor($r('app.color.common_gray_bg'))
      .backgroundColor(this.bgColor)
  }
}