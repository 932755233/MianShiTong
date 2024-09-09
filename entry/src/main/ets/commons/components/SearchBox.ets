@Component
export struct SearchBox {


  @Prop
  placeHolderColor: ResourceColor = '#ffbebbbb'
  @Prop
  placeHolderText: string = '搜索题目'
  @Prop
  layoutValue: number = 0
  @Prop
  searchWidth: number = 100
  @Prop
  searchHeight: number = 32
  @Prop
  searchBgColor: ResourceColor = '#e8e7ed'

  // 需求：既可以制定大小，又可以自适应
  //   1.传递宽高，就用宽高，默认不会自适应
  //   2.不传递宽高，就用自适应，会覆盖宽高
  build() {
    Row({ space: 4 }) {
      Image($r('app.media.ic_common_search'))
        .width(14)
        .aspectRatio(1)
        .fillColor(this.placeHolderColor)
      Text(this.placeHolderText)
        .fontColor(this.placeHolderColor)
        .fontSize(14)
    }
    .width(this.searchWidth)
    .height(this.searchHeight)
    .layoutWeight(this.layoutValue)
    .justifyContent(FlexAlign.Center)
    .borderRadius(this.searchHeight / 2)
    .backgroundColor(this.searchBgColor)
  }
}