import { User } from "../../model"
import { router } from "@kit.ArkUI"

// 持久化标识:常量
export const UserStoreKey = 'UserStoreKey'

class Auth {
  // 声明(只需要执行一次)必须要执行一次，才能持久化
  initUser() {
    PersistentStorage.persistProp(UserStoreKey, {} as User)
  }

  // 设置
  setUser(user: User) {
    AppStorage.setOrCreate<User>(UserStoreKey, user)
  }

  // 访问
  getUser() {
    return AppStorage.get<User>(UserStoreKey) || {} as User
  }

  checkAuth(opt: router.RouterOptions) {
    const user = auth.getUser()
    if (user.token) {
      router.pushUrl(opt)
    } else {
      const params = opt.params as Record<string, string> || {}
      params.return_url = opt.url
      router.pushUrl({
        url: 'pages/LoginPage',
        params: params
      })
    }
  }
}

export const auth = new Auth()