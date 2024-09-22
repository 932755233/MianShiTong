import { QuestionListComp } from '../../commons/components'
import { http } from '../../commons/utils'

export interface QuestionType {
  id: number
  name: string
  displayNewestFlag: 0 | 1
}

@Preview
@Component
export struct HomeCategroy {
  @State
  questionTypeList: QuestionType[] = []
  @State
  activeIndex: number = 0
  @State
  isShow: boolean = false
  controller: TabsController = new TabsController()

  // 这样写比较符合规范
  async getQuestionTypeList() {
    // http是自己的工具
    // request是自己封装的方法
    // <QuestionType[]>是响应结果的类型
    // string请求参数的类型
    // method是请求类型，不写默认是get请求
    // data是post请求时候携带的参数（不出现在url）
    // param是get请求中拼接到url中的
    const res = await http.request<QuestionType[], string>({
      url: 'question/type',
      method: 'get',
      data: '123'
    })

    this.questionTypeList = res
  }

  aboutToAppear() {
    this.getQuestionTypeList()


  }

  @Builder
  TabBarBuilder(item: QuestionType, index: number) {
    Row() {
      Stack({ alignContent: Alignment.Bottom }) {
        Text(item.name)
          .fontSize(14)
          .fontColor(this.activeIndex === index ? $r('app.color.black') : $r('app.color.common_gray_01'))
        Row()
          .height(2)
          .width(this.activeIndex === index ? 25 : 0)
          .backgroundColor($r('app.color.black'))
          .animation({ duration: this.activeIndex === index ? 300 : 0 })
      }

      if (item.displayNewestFlag === 1) {
        Image($r('app.media.ic_home_new'))
          .width(32)
          .height(14)
          .objectFit(ImageFit.Contain)
          .margin({
            left: 4
          })
      }
    }
    .margin({
      left: 16,
      right: 16
    })
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Tabs({ controller: this.controller }) {
        ForEach(this.questionTypeList, (item: QuestionType, index: number) => {
          TabContent() {
            QuestionListComp({
              typeId: item.id
            })
          }.tabBar(this.TabBarBuilder(item, index))
        })
      }
      .onTabBarClick((index: number) => {
        this.activeIndex = index;
      })
      .barMode(BarMode.Scrollable)
      .barHeight(44)
      .scrollable(false)
      .divider({ strokeWidth: 0.5, color: $r('app.color.common_gray_border') })

      Row() {
        Image($r('app.media.ic_home_filter'))
          .width(24)
          .aspectRatio(1)
      }
      .width(56)
      .height(44)
      .justifyContent(FlexAlign.Center)
      .linearGradient({ angle: 90, colors: [['#00ffffff', 0], ['#ffffff', 0.285]] })
      // .bindSheet($$this.isShow)
    }
  }
}