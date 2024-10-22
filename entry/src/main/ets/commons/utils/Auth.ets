import { User } from "../../model"

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
}

export const auth = new Auth()