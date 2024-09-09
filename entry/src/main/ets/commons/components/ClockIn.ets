@Component
export struct ClockIn {
  clockCount: number = 0

  build() {
    Row() {
      if (this.clockCount === 0) {
        Column() {

        }
      } else {
        Column() {

        }
      }
    }
    .width(74)
    .height(28)
    .backgroundImage($r('app.media.ic_common_unclock'))
    .backgroundImageSize(ImageSize.Contain)
  }
}