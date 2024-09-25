import { NavBar } from '../commons/components/NavBar'

@Entry
@Component
struct LoginPage {
  @StorageProp('topHeight')
  topHeight: number = 0
  @State
  mobile: string = 'hmheima'
  @State
  code: string = 'Hmheima%123'
  @State
  isAgree: boolean = false
  @State
  loading: boolean = false

  build() {
    Column() {
      NavBar({ showRightIcon: false })

    }
    .height('100%')
    .width('100%')
  }
}