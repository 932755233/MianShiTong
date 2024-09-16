import axios, { AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import { promptAction } from '@kit.ArkUI'
import { QuestionItem } from '../../model'

interface Res<T> {
  success: boolean
  code: number
  message: string
  data: T
}

export const baseURL = 'https://api-harmony-teach.itheima.net/hm/'

export const timeout = 10 * 1000

const instance = axios.create({
  baseURL,
  timeout
})
// 拦截器：
//   请求发送到服务器之前的一次拦截 - 设置请求配置信息               请求拦截器
//   收到服务器响应结果响应之前的一次拦截 - 数据的处理，异常处理       响应拦截器
// instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
//   //业务处理位置
//   return config
// }, (err: Error) => {
//   promptAction.showToast({
//     message: '请求参数错误'
//   })
//   return Promise.reject(err)
// })

instance.interceptors.response.use((res: AxiosResponse) => {
  //todo: 返回数据的加工

  return res
}, (err: Error) => {
  promptAction.showToast({
    message: '响应错误：' + err.message
  })
  return Promise.reject(err)
})


class Http {
  request<ResponseData, RequestData>(config: AxiosRequestConfig<RequestData>) {
    //二次封装的核心思想是传递参数
    // 1.只需要传递响应结果的类型即可
    return instance<null, ResponseData, RequestData>(config)
  }
}


export const http = new Http()