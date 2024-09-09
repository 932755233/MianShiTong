export interface QuestionType {
  id: number
  name: string
  displayNewestFlag: 0 | 1
}

@Component
export struct HomeCategroy {
  @State
  questionTypeList: QuestionType[] = mockData
  @State
  activeIndex: number = 0

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
    Tabs() {
      ForEach(this.questionTypeList, (item: QuestionType, index: number) => {
        TabContent() {
          //todo: 列表代码



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
  }
}

const mockData: QuestionType[] = [
  { id: 1, name: 'ArkTS', displayNewestFlag: 0 },
  { id: 2, name: 'ArkUI', displayNewestFlag: 1 },
  { id: 3, name: 'Hap', displayNewestFlag: 1 },
  { id: 4, name: 'Hsp', displayNewestFlag: 0 },
  { id: 5, name: 'Har', displayNewestFlag: 0 },
  { id: 6, name: 'Ability', displayNewestFlag: 0 },
  { id: 7, name: 'Stage', displayNewestFlag: 0 },
  { id: 8, name: 'Kit', displayNewestFlag: 0 }
]