import { statusBarUtil } from '../commons/utils';
import { HomePage } from './HomePage';
import { InterviewPage } from './InterviewPage';
import { MinePage } from './MinePage';
import { ProjectPage } from './ProjectPage';

// 数据结构定义
interface TabItem {
  icon: Resource
  activeIcon: Resource
  name: string
}

@Entry
@Component
struct Index {
  @StorageLink('topHeight') topHeight: number = 0
  @StorageLink('bottomHeight') bottomHeight: number = 0
  @State
  tabList: TabItem[] = [
    {
      icon: $r('app.media.tabbar_home'),
      activeIcon: $r('app.media.tabbar_home_fill'),
      name: '首页'
    },
    {
      icon: $r('app.media.tabbar_project'),
      activeIcon: $r('app.media.tabbar_project_fill'),
      name: '话题'
    },
    {
      icon: $r('app.media.tabbar_interview'),
      activeIcon: $r('app.media.tabbar_interview_fill'),
      name: '面经'
    },
    {
      icon: $r('app.media.tabbar_mine'),
      activeIcon: $r('app.media.tabbar_mine_fill'),
      name: '我的'
    },
  ]
  @State
  activeIndex: number = 0

  @Builder
  TabBarBuilder(item: TabItem, index: number) {
    // index是自己的索引
    Column({ space: 5 }) {
      Image(this.activeIndex === index ? item.activeIcon : item.icon)
        .width(24)
        .aspectRatio(1)
      Text(item.name)
        .fontSize(12)
        .fontColor(this.activeIndex === index ? $r('app.color.black') : $r('app.color.common_gray_01'))
    }
  }

  build() {
    Column() {
      // 放置tabs组件
      Tabs() {
        ForEach(this.tabList, (item: TabItem, index: number) => {
          TabContent() {
            // 每一页的内容
            if (index === 0) {
              HomePage()
            } else if (index === 1) {
              ProjectPage()
            } else if (index === 2) {
              InterviewPage()
            } else if (index === 3) {
              MinePage()
            }
          }.tabBar(this.TabBarBuilder(item, index))
        })
      }
      .barPosition(BarPosition.End)
      .divider({
        strokeWidth: 0.5,
        color: $r('app.color.common_gray_border')
      })
      .scrollable(false)
      // .tabIndex(this.activeIndex)
      .onTabBarClick((index: number) => {
        this.activeIndex = index
      })
    }
    .height('100%')
    .width('100%')
    .padding({
      top: this.topHeight,
      bottom: this.bottomHeight
    })
  }
}