import { window } from '@kit.ArkUI'
import { logger } from './LoggerUtil'

/**
 * 用来设置状态栏文字颜色的工具类
 */
class StatusBarUtil {
  // 深色 - 文字颜色
  setDarkBar() {
    this.setBar({
      statusBarContentColor: '#000000'
    })
  }

  // 浅色
  setLightBar() {
    this.setBar({
      statusBarContentColor: '#ffffff'
    })

  }

  // 自定义颜色(颜色配置)
  async setBar(systemBar: window.SystemBarProperties) {
    try {
      const context = AppStorage.get<Context>('context')
      if (context) {
        const win = await window.getLastWindow(context)
        //核心：设置状态栏的方法
        win.setWindowSystemBarProperties(systemBar)
      }
    } catch (err) {
      logger.error('StatusBarUtil Error:', JSON.stringify(err))
    }
  }
}

export const statusBarUtil = new StatusBarUtil()