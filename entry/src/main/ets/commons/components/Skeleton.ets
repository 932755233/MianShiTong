@Preview
@Component
export struct Skeleton {
  @Builder
  defaultBuilder() {
  }

  @BuilderParam
  defaultParam: () => void = this.defaultBuilder
  @State
  opacityValue: number = 1

  build() {
    Row({ space: 6 }) {
      // 占位的结构
      this.defaultParam
    }
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