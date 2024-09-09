import { logger } from '../utils'

@Component
export struct MyCalendar {
  //枚举，数组
  monthArr: string[] = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC']
  @State //month 0-11为了匹配数组
  month: number = 0
  @State
  date: number = 1
  @State
  totalDate: number = 0
  @State
  offsetDay: number = 0

  aboutToAppear(): void {
    // 获取当前的月，日
    const dateObj = new Date()
    this.month = dateObj.getMonth();
    this.date = dateObj.getDate()

    const newDate = new Date()
    newDate.setMonth(new Date().getMonth() + 1)
    newDate.setDate(0)

    //获取一个月一共多少天
    this.totalDate = newDate.getDate()

    // 获取日历偏移天数
    newDate.setDate(1)
    let day = newDate.getDay();
    if (day === 0) {
      this.offsetDay = 6
    } else {
      this.offsetDay = day - 1
    }

  }

  build() {
    Row() {
      // 文字日历
      Column({ space: 6 }) {
        Text(this.monthArr[this.month])
          .fontColor('#ffff3838')
        Text(this.date.toString().padStart(2, '0'))
          .fontWeight(FontWeight.Bold)
          .fontSize(28)
      }
      .padding(12)
      .backgroundColor($r('app.color.white'))
      .borderRadius(12)
      .position({
        x: 16,
        y: -16
      })
      .shadow({
        radius: 4,
        color: '#ff696969'
      })

      // 每日推荐文字
      Column({ space: 6 }) {
        Text('每日一题')
          .fontSize(12)
        Text('ArkTS 有哪些装饰器？')
          .fontWeight(FontWeight.Bold)
          .fontSize(14)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({
        left: 100
      })

      // 日历图表
      Column() {
        GridRow({ columns: 7, gutter: 6 }) {
          ForEach(Array(this.offsetDay).fill(() => 1), (item: number, index: number) => {
            GridCol() {
              Row()
                .width(6)
                .aspectRatio(1)// .backgroundColor(this.date === index ? '#ff35ff05' : '#ccc')
                .borderRadius(3)
            }
          })

          ForEach(Array(this.totalDate).fill(() => 1), (item: number, index: number) => {
            GridCol() {
              Row()
                .width(6)
                .aspectRatio(1)
                .backgroundColor(this.date === (index + 1) ? '#ff35ff05' : '#ccc')
                .borderRadius(3)
            }
          })
        }
      }
      .width(120)
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .margin({
        right: 10
      })

    }
    .width('100%')
    .height(80)
    .borderRadius(8)
    .backgroundColor('#edecf2')
  }
}