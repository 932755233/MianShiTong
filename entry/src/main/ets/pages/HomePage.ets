import { ClockIn, SearchBox } from '../commons/components'

@Component
export struct HomePage {
  @StorageProp('topHeight') topHeight: number = 0

  @Builder
  swiperItemBuilder(src: ResourceStr) {
    Row() {
      Image(src)
        .width('100%')
        .aspectRatio(2.65)
        .objectFit(ImageFit.Fill)
    }
    .width('100%')
    .padding({
      left: 16,
      right: 16
    })
  }

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
        ClockIn({
          clockCount: 1
        })
          .onClick(() => {

          })
      }
      .width('100%')
      .padding({
        left: 16,
        right: 16
      })

      // 轮播图
      Swiper() {
        //抽离组件
        ForEach([
          $r('app.media.banner_qa'),
          $r('app.media.banner_pj'),
          $r('app.media.banner_ai')
        ], (src: ResourceStr) => {
          this.swiperItemBuilder(src)
        })
      }
      .margin({
        top: 16,
        bottom: 16
      })
      .indicator(
        DotIndicator.dot()
          .bottom(4)
          .itemHeight(4)
          .selectedColor($r('app.color.white'))
          .selectedItemHeight(4)
      )

      //日历


    }
    .width('100%')
    .height('100%')
    .padding({
      top: this.topHeight
    })
    .backgroundColor($r('app.color.common_gray_bg'))
  }
}