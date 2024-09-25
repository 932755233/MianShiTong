import { QuestionListComp } from '../../commons/components'
import { Skeleton } from '../../commons/components/Skeleton'
import { SkeletonItem } from '../../commons/components/SkeletonItem'
import { http } from '../../commons/utils'
import { SortType } from '../../model'

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
  @State //当前显示的分类
  activeIndex: number = 0
  @State //当前默认的排序
  sort: SortType = SortType.Default
  @State //排序的索引
  filterIndex: number = 0
  @State //排序的索引
  filterSort: number = 0
  @State
  isShow: boolean = false
  @State
  loading: boolean = false
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
    this.loading = true
    const res = await http.request<QuestionType[], string>({
      url: 'question/type',
      method: 'get',
      data: '123'
    })

    this.questionTypeList = res
    setTimeout(() => {
      this.loading = false
    }, 5000)
  }

  aboutToAppear() {
    this.getQuestionTypeList()
  }

  @Builder
  SkeletonBuilder() {
    Skeleton() {
      Column() {
        Row({ space: 16 }) {
          SkeletonItem({ widthValue: 60 })
          SkeletonItem({ widthValue: 100 })
          SkeletonItem({ widthValue: 80 })
          SkeletonItem({ widthValue: 40 })
        }
        .height(44)
        .width('100%')

        ForEach([1, 2, 3, 4, 5, 6], () => {
          Column({ space: 10 }) {
            SkeletonItem({ widthValue: '90%' })
            SkeletonItem({ widthValue: '45%' })
          }
          .height(80)
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Center)
        })
      }
      .padding({ left: 16, right: 16 })
    }
  }

  @Builder
  FilterSheetBuilder() {
    Column() {
      Row() {
        Text('重置')
          .fontSize(16)
          .fontWeight(500)
          .fontColor($r('app.color.common_gray_03'))
          .onClick(() => {
            this.filterSort = SortType.Default
            this.filterIndex = 0
          })
        Text('筛选题目')
          .layoutWeight(1)
          .fontSize(18)
          .fontWeight(500)
          .fontColor($r('app.color.black'))
          .textAlign(TextAlign.Center)
        Text('完成')
          .fontWeight(500)
          .fontSize(16)
          .fontColor($r('app.color.common_main_color'))
          .onClick(() => {
            this.isShow = false
            this.activeIndex = this.filterIndex
            this.controller.changeIndex(this.activeIndex)
            this.sort = this.filterSort
          })
      }
      .margin({
        bottom: 4,
        top: 4
      })

      Text('题目排序')
        .textTitle()
      Flex({ wrap: FlexWrap.Wrap }) {
        FilterButton({
          text: '默认',
          isSelected: this.filterSort === SortType.Default,
          sort: this.filterSort
        })
          .onClick(() => {
            this.filterSort = SortType.Default
          })

        FilterButton({
          text: '浏览量',
          isSort: true,
          isSelected: this.filterSort === SortType.ViewLow || this.filterSort === SortType.ViewHigh,
          sort: this.filterSort
        })
          .onClick(() => {
            this.filterSort = this.filterSort === SortType.ViewLow ? SortType.ViewHigh : SortType.ViewLow
          })

        FilterButton({
          text: '难度',
          isSort: true,
          isSelected: this.filterSort === SortType.DifficultyLow || this.filterSort === SortType.DifficultyHigh,
          sort: this.filterSort
        })
          .onClick(() => {
            this.filterSort =
              this.filterSort === SortType.DifficultyLow ? SortType.DifficultyHigh : SortType.DifficultyLow
          })

        FilterButton({
          text: '推荐',
          isSelected: this.filterSort === SortType.Commend,
          sort: this.filterSort
        })
          .onClick(() => {
            this.filterSort = SortType.Commend
          })

      }

      Text('选择分类')
        .textTitle()
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.questionTypeList, (item: QuestionType, i: number) => {
          FilterButton({
            text: item.name,
            isNew: item.displayNewestFlag === 1,
            isSelected: i === this.filterIndex
          })
            .onClick(() => {
              this.filterIndex = i
            })
        })
      }

    }
    .padding(16)
    .backgroundColor($r('app.color.white'))
    .height('100%')
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
    if (this.loading) {
      this.SkeletonBuilder()
    } else {
      Stack({ alignContent: Alignment.TopEnd }) {
        Tabs({ controller: this.controller }) {
          ForEach(this.questionTypeList, (item: QuestionType, index: number) => {
            TabContent() {
              QuestionListComp({
                typeId: item.id,
                sort: this.sort,
                activeIndex: this.activeIndex,
                index: index
              })
            }.tabBar(this.TabBarBuilder(item, index))
          })
        }
        .onTabBarClick((index: number) => {
          this.activeIndex = index;
          this.filterIndex = index;
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
        .bindSheet($$this.isShow, this.FilterSheetBuilder(), {
          showClose: false,
          height: 400
        })
        .onClick(() => {
          this.isShow = true;
        })
      }
    }
  }
}

@Extend(Text)
function textTitle() {
  .fontSize(14)
  .fontWeight(500)
  .fontColor($r('app.color.black'))
  .width('100%')
  .margin({ top: 20 })
}

@Component
struct FilterButton {
  text: string = ''
  isNew: boolean = false
  isSort: boolean = false
  @Prop isSelected: boolean = false
  @Prop sort: SortType = SortType.Default

  build() {
    Row() {
      Text(this.text)
        .fontSize(12)
        .fontColor(this.isSelected ? $r('app.color.common_main_color') : $r('app.color.black'))
      if (this.isNew) {
        Image($r('app.media.ic_home_new'))
          .width(32)
          .height(14)
          .objectFit(ImageFit.Contain)
          .position({ right: -26, top: -7 })
      }
      if (this.isSort) {
        Column() {
          Image($r('sys.media.ohos_ic_public_arrow_up'))
            .size({ width: 12, height: 6 })
            .fillColor(this.isSelected && this.sort % 2 === 0 ? $r('app.color.common_main_color') :
            $r('app.color.black'))
          Image($r('sys.media.ohos_ic_public_arrow_down'))
            .size({ width: 12, height: 6 })
            .fillColor(this.isSelected && this.sort % 2 === 1 ? $r('app.color.common_main_color') :
            $r('app.color.black'))
        }
        .margin({ top: -0.5, left: 2 })
      }
    }
    .height(30)
    .padding({ left: 10, right: 10 })
    .backgroundColor($r('app.color.common_gray_bg'))
    .borderRadius(4)
    .margin({ top: 12, right: this.isNew ? 26 : 10 })
  }
}