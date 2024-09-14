import { QuestionItem } from '../../model'
import { QuestionItemComp } from './QuestionItemComp'

@Component
export struct QuestionListComp {
  @State
  isRefreshing: boolean = false
  @State
  isLoading: boolean = false
  @State
  isFinished: boolean = false
  @State
  list: QuestionItem[] = []

  // 下拉刷新加载
  onRefresh() {
    //模拟加载数据
    this.isLoading = false
    this.isFinished = false
    setTimeout(() => {


      this.isRefreshing = false
    }, 2000)
  }

  // 上拉滚动加载
  onLoad() {
    // 为了已经在获取数据中，不去重复拉取数据
    if (this.isLoading || this.isFinished || this.isRefreshing) {
      return
    }
    this.isLoading = true;
    setTimeout(() => {
      for (let i = 0; i < 10; i++) {
        this.list.push({} as QuestionItem)
      }
      if (this.list.length > 30) {
        this.isFinished = true

      }
      this.isLoading = false;
    }, 2000)

  }

  @Builder
  LoadMoreBuilder() {
    if (this.isLoading) {
      Row({ space: 4 }) {
        LoadingProgress()
          .width(20)
        Text('正在玩命的加载。。。')
          .textAlign(TextAlign.Center)
          .fontColor($r('app.color.common_gray_01'))
      }
      .height(80)
      .width('100%')
      .justifyContent(FlexAlign.Center)

    } else if (this.isFinished) {
      Text('我是有底线的~')
        .height(80)
        .width('100%')
        .textAlign(TextAlign.Center)
    }
  }

  build() {
    // 1.下拉刷新
    // 2.上拉加载
    Refresh({ refreshing: $$this.isRefreshing }) {
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
        //loading的展示
        this.LoadMoreBuilder()
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
        this.onLoad()
      })
      .onScrollStop(() => {

      })
    }
    .onRefreshing(() => {
      this.onRefresh()
    })

  }
}