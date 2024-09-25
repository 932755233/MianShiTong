@Component
export struct Skeleton {
  @State
  opacityValue: number = 1

  @Builder
  defaultBuilder() {
  }

  @BuilderParam
  defaultParam: () => void = this.defaultBuilder

  build() {
    Row({ space: 6 }) {
      // 占位的结构
      this.defaultParam()
    }
    .height(50)
    .width('100%')
    .opacity(this.opacityValue)
    .animation({
      duration: 600,
      iterations: -1,
      playMode: PlayMode.Alternate,
      curve: Curve.EaseInOut
    })
    .onAppear(() => {
      this.opacityValue = 0.5
    })
  }
}