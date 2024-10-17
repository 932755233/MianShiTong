//三层架构的习惯 - 所有文件夹下的内容都在index导出

export * from './LoggerUtil'

export * from './FullScreenUtil'

export * from './StatusBarUtil'

export * from './Http'

// 大于1天     xxx天
// 大于1小时   xxx小时
// 大于1分钟   xxx分钟
// 小于1分钟   刚刚
const min = 60
const hour = 60 * 60
const day = 60 * 60 * 24

export function formatTime(second: number = 0) {
  if (second > day) {
    return (second / day).toFixed(1) + "天"
  } else if (second > hour) {
    return (second / hour).toFixed(1) + "小时"
  } else if (second > min) {
    return (second / min).toFixed(1) + "分钟"
  } else {
    return '暂无数据'
  }
}