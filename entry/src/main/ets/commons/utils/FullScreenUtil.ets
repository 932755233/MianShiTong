import { window } from '@kit.ArkUI'
import { logger } from './LoggerUtil'
import { JSON } from '@kit.ArkTS'

/**
 * 用来开启关闭沉浸式的工具类
 */
class FullScreenUtil {
  //开启全屏
  async enable() {
    try {
      const context = AppStorage.get<Context>('context')
      if (context) {
        const win = await window.getLastWindow(context)
        // 设置沉浸式
        await win.setWindowLayoutFullScreen(true)

        //获取屏幕上下方安全区的高度并存储到AppStorage中
        const topArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
        AppStorage.setOrCreate('topHeight', px2vp(topArea.topRect.height))
        const bottomArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
        AppStorage.setOrCreate('bottomHeight', px2vp(bottomArea.bottomRect.height))

      }
    } catch (err) {
      logger.error('FullScreenUtrl Error:', JSON.stringify(err))
    }
  }

  // 关闭全屏
  async disable() {
    try {
      const context = AppStorage.get<Context>('context')
      if (context) {
        const win = await window.getLastWindow(context)
        await win.setWindowLayoutFullScreen(false)

        AppStorage.setOrCreate('topHeight', 0)
        AppStorage.setOrCreate('bottomHeight', 0)

      }
    } catch (e) {
      logger.error("CloseFullScreen Error:", JSON.stringify(e))
    }
  }
}

export const fullScreenUtil = new FullScreenUtil()