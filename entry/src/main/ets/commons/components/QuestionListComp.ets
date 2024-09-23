import { PageData, QuestionItem, QuestionListParams, SortType } from '../../model'
import { http } from '../utils'
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
  // 获取列表的参数
  @Prop
  typeId: number
  @Prop
  activeIndex: number
  @Prop
  index: number
  @Prop
  @Watch('onChangeSort')
  sort: SortType = SortType.Default
  @State
  page: number = 1

  onChangeSort() {
    if (this.activeIndex === this.index) {
      this.isRefreshing = true
    }
  }

  // 下拉刷新加载
  async onRefresh() {
    //模拟加载数据
    this.isLoading = false
    this.isFinished = false
    this.isRefreshing = true
    // setTimeout(() => {
    //
    //
    //   this.isRefreshing = false
    // }, 2000)
    this.page = 1
    const res = await this.getQuestionList()
    this.list = res.rows
    this.isRefreshing = false

    if (this.page >= res.pageTotal) {
      this.isFinished = true
    } else {
      this.isFinished = false
      this.page++
    }

  }

  //list第一次出现的是会跑一下onload，还没加载数据的时候list会认为已经触底了，所以会调用一下这个onload
  // 上拉滚动加载
  async onLoad() {
    // 为了已经在获取数据中，不去重复拉取数据
    if (this.isLoading || this.isFinished || this.isRefreshing) {
      return
    }
    this.isLoading = true;
    // setTimeout(() => {
    //   for (let i = 0; i < 10; i++) {
    //     this.list.push({} as QuestionItem)
    //   }
    //   if (this.list.length > 30) {
    //     this.isFinished = true
    //
    //   }
    //   this.isLoading = false;
    // }, 2000)

    const res = await this.getQuestionList()
    this.list.push(...res.rows)
    this.isLoading = false;
    if (this.page >= res.pageTotal) {
      this.isFinished = true
    } else {
      this.isFinished = false
      this.page++
    }
  }

  // 获取列表的方法
  getQuestionList(): Promise<PageData<QuestionItem>> {
    return http.request<PageData<QuestionItem>>({
      url: 'question/list',
      params: {
        type: this.typeId,
        questionBankType: 10,
        sort: this.sort,
        page: this.page,
        pageSize: 10
      } as QuestionListParams
    })
  }

  async aboutToAppear() {
    const res = await this.getQuestionList()


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
    Refresh({ refreshing: this.isRefreshing }) {
      List() {
        ForEach(this.list, (item: QuestionItem) => {
          ListItem() {
            QuestionItemComp({
              item
            })
          }
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