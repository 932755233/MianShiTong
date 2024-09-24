@Preview
@Component
export struct SkeletonItem {
  widthValue: Length = '100%'
  text: string = '你好'
  bgColor: ResourceColor = Color.Gray

  build() {
    //骨架屏单元
    Text(this.text)
      .width(this.widthValue)
      .height(50)
      .borderRadius(2)
      .backgroundColor(this.bgColor)
  }
}