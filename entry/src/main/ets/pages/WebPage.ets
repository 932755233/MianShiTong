import { NavBar } from '../commons/components/NavBar';
import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

interface RouterParams {
  src: string
  title: string
}

@Entry
@Component
struct WebPage {
  @State message: string = 'Hello World';
  controller: WebviewController = new webview.WebviewController()
  @StorageProp('bottomHeight')
  bottomHeight: number = 0
  @State
  title: string = ''
  @State
  src: string = ''

  aboutToAppear(): void {
    const params = router.getParams() as RouterParams
    this.src = params.src
    this.title = params.title
  }

  build() {
    Column() {
      NavBar({
        title: this.title,
        showRightIcon: false
      })

      Web({
        src: this.src,
        controller: this.controller
      })
        .margin({
          bottom: 20
        })
    }
    .height('100%')
    .width('100%')
    .padding({
      bottom: this.bottomHeight
    })
  }
}