import { LevelTag } from '../commons/components'
import { NavBar } from '../commons/components/NavBar'
import { promptAction, router } from '@kit.ArkUI'
import { QuestionDetail, QuestionItem, QuestionPageParams } from '../model'
import { http } from '../commons/utils'
import { webview } from '@kit.ArkWeb'

@Entry
@Component
struct QuestionPage {
  @StorageProp('bottomHeight')
  bottomHeight: number = 0
  @State
  item: QuestionDetail = {} as QuestionDetail
  list: QuestionDetail[] = []
  @State
  activeIndex: number = 0
  controller: WebviewController = new webview.WebviewController()

  async aboutToAppear() {
    const params = router.getParams() as QuestionPageParams
    this.item = params.item as QuestionDetail
    this.list = params.list as QuestionDetail[]
    this.activeIndex = this.list.findIndex(item => item.id === this.item.id)

    this.item = await this.getQuestionDetail(this.item.id)
    //必须等数据拿到之后再加载一次数据
    this.controller.loadUrl($rawfile('question.html'))
  }

  // 题目切换
  async toggleQuestion(step: number) {
    const index = this.activeIndex + step
    if (index < 0 || index >= this.list.length) {
      promptAction.showToast({
        message: '没有更多试题了'
      })
      return
    }
    const item = this.list[index]
    this.item = await this.getQuestionDetail(item.id)
    this.controller.runJavaScript(`writeHtml(\`${this.item.answer}\`)`)

  }

  async getQuestionDetail(id: string) {
    const result = await http.request<QuestionDetail>({
      url: 'question/' + id
    })
    return result
  }

  @Builder
  TitleBuilder(text: string) {
    Row() {
      Text()
        .width(2)
        .height(12)
        .backgroundColor($r('app.color.black'))
        .margin({ right: 13 })
      Text(text)
        .fontWeight(700)
    }
    .width('100%')
    .padding({ top: 10 })
    .height(32)
  }

  @Builder
  MenuBuilder() {
    Menu() {
      MenuItem({ content: '点赞' })
      MenuItem({ content: '收藏' })
      MenuItem({ content: '点我反馈' })
      MenuItem({ content: '试题分享' })
    }
    .width(108)
  }

  build() {
    Column() {
      NavBar({ title: '试题详情', showRightIcon: false })

      this.TitleBuilder('题目：')
      Text(this.item.stem)
        .width('100%')
        .padding(16)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      Row({ space: 12 }) {
        ForEach(this.item.stage, (item: string) => {
          LevelTag({ text: item, color: '#ff6600' })
        })
        Blank()
        Image($r('app.media.ic_home_more'))
          .width(20)
          .aspectRatio(1)
          .bindMenu(this.MenuBuilder())
      }
      .width('100%')
      .padding({ bottom: 16, left: 16, right: 16 })

      Divider()
        .strokeWidth(8)
        .color($r('app.color.common_gray_bg'))

      this.TitleBuilder('答案：')

      Web({
        src: $rawfile('question.html'),
        controller: this.controller
      })
        .width('100%')
        .layoutWeight(1)
        .padding(6)
        .onPageEnd(() => {
          //调用html提供的方法
          this.controller.runJavaScript(`writeHtml(\`${this.item.answer}\`)`)
        })

      Row({ space: 80 }) {
        Row() {
          Image($r('sys.media.ohos_ic_public_arrow_left'))
            .width(20)
            .aspectRatio(1)
            .fillColor($r('app.color.common_gray_01'))
          Text('上一题')
            .fontColor($r('app.color.common_gray_01'))
        }

        Row() {
          Text('下一题')
            .fontColor($r('app.color.common_gray_03'))
          Image($r('sys.media.ohos_ic_public_arrow_right'))
            .width(20)
            .aspectRatio(1)
            .fillColor($r('app.color.common_gray_03'))
        }
      }
      .height(44)
      .width('100%')
      .justifyContent(FlexAlign.Center)

    }
    .height('100%')
    .width('100%')
    .padding({ bottom: this.bottomHeight })
  }
}