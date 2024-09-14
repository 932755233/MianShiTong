import axios from '@ohos/axios'

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

class Http {
  request() {

  }
}


export const http = new Http()