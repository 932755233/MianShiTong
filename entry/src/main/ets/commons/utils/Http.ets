import axios, { AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import { promptAction } from '@kit.ArkUI'
import { logger } from '.'

interface Res<T> {
  success: boolean
  code: number
  message: string
  data: T
}

//请求跟地址和超时时长
export const baseURL = 'https://api-harmony-teach.itheima.net/hm/'

export const timeout = 10 * 1000

const instance = axios.create({
  baseURL,
  timeout
})
// 拦截器：
//   请求发送到服务器之前的一次拦截 - 设置请求配置信息               请求拦截器
//   收到服务器响应结果响应之前的一次拦截 - 数据的处理，异常处理       响应拦截器
instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  //TODO:携带登录信息
  return config
}, (err: Error) => {
  promptAction.showToast({
    message: '请求参数错误'
  })
  return Promise.reject(err)
})

instance.interceptors.response.use((res: AxiosResponse) => {
  //todo: 返回数据的加工
  // 1.接口调通了
  // 业务成功/业务失败
  // 返回成功结果 - 返回错误结果
  // 2.接口没调通
  // 错误信息

  // 返回成功结果
  if (res.data.code === 10000) {
    return res.data.data
  }

  return Promise.reject(new Error(JSON.stringify(res.data) + '---zzy'))
}, (err: Error) => {
  promptAction.showToast({
    message: '响应错误：' + err.message
  })
  logger.debug('响应错误：' + err.message)
  return Promise.reject(err)
})


class Http {
  //ResponseData是调用时候传递的类型，他表示返回值的类型
  async request<ResponseData, RequestData = Object>(config: AxiosRequestConfig<RequestData>) {
    //二次封装的核心思想是传递参数
    // 1.只需要传递响应结果的类型即可
    return await instance<null, ResponseData, RequestData>(config)
  }
}

export const http = new Http()