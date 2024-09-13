import { QuestionItemComp } from './QuestionItemComp'

@Component
export struct QuestionListComp {
  @State
  isRefreshing: boolean = false

  // 下拉刷新加载

  // 上拉滚动加载

  build() {
    // 1.下拉刷新
    // 2.上拉加载
    Refresh({ refreshing: this.isRefreshing }) {
      List() {
        ForEach(new Array(10).fill(1), () => {
          QuestionItemComp({
            item: {
              id: '100',
              stem: '请说下ArkUI的容器组件有哪些？',
              difficulty: 3,
              likeCount: 23,
              views: 423,
              readFlag: 1
            }
          })
        })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .divider({
        strokeWidth: 0.5,
        color: $r('app.color.common_gray_bg'),
        startMargin: 16,
        endMargin: 16
      })
      .edgeEffect(EdgeEffect.None)
      .onScrollStart(() => {

      })
      .onReachEnd(() => {

      })
      .onScrollStop(() => {

      })
    }
    .onRefreshing(() => {
    })

  }
}