// 覆盖各个页面的数据类型
// interface不需要new创建对象，只是对字面量对象类型的限制（如果已经有对象了，不用创建对象，那就用interface）
// class适合new创建对象（通过构造函数定义不同的对象），包括objectLink限制时使用，其他情况可以用interface

export interface QuestionItem {
  id: string;

  /* 题干 */
  stem: string;

  /* 难度 */
  difficulty: number;

  /* 点赞数 */
  likeCount: number;

  /* 浏览数 */
  views: number;

  /* 是否已看 */
  readFlag: 0 | 1;
}

export interface PageData<T> {
  total: number
  pageTotal: number
  rows: T[]
}

export enum SortType {
  Default = 0,
  DifficultyLow = 10,
  DifficultyHigh = 11,
  ViewLow = 20,
  ViewHigh = 21,
  Commend = 30
}

export interface QuestionListParams {
  type: number
  questionBankType: 9 | 10
  sort?: SortType
  page?: number
  pageSize?: number
}