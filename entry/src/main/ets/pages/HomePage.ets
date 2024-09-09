import { ClockIn, SearchBox } from '../commons/components'

@Component
export struct HomePage {
  @StorageProp('topHeight') topHeight: number = 0

  build() {
    Column() {
      // 头部
      Row({ space: 16 }) {
        // 扫码
        Image($r('app.media.ic_home_scan'))
          .width(24)
          .aspectRatio(1)

        // 搜索框
        SearchBox({
          layoutValue: 1,
          placeHolderText: '搜索关键字'
        })

        // 打卡
        ClockIn()
      }
      .width('100%')
      .padding({
        left: 16,
        right: 16
      })

    }
    .width('100%')
    .height('100%')
    .padding({
      top: this.topHeight
    })
    .backgroundColor($r('app.color.common_gray_bg'))
  }
}