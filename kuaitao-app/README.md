# 快逃 ⚡ Kuaitao App

> 看清这世界的雷 · 炸裂吐槽风 避雷社区

基于 Flutter 3 原生实现，像素级还原 `kuaitao-ui/design-preview.html` 中 7 个核心页面：

| Flow | Page                | Path                |
| ---- | ------------------- | ------------------- |
| ⓪    | Splash 启动加载页    | `/splash`           |
| ①    | 登录页              | `/login`            |
| ②    | 注册 / 完善资料页    | `/register`         |
| ③    | 首页 · 雷区广场      | `/home`             |
| ④    | 雷帖详情             | `/thunder/:id`      |
| ⑤    | 发布避雷帖           | `/publish`          |
| ⑥    | 个人中心             | `/profile`          |

## 工程架构

```
lib/
├─ main.dart                 # 入口
├─ app/
│  ├─ theme/                 # Design Token（颜色 / 字号 / 阴影 / 圆角）
│  └─ router/                # go_router 路由配置
├─ data/
│  └─ mock/                  # Mock 数据（雷帖、用户、评论）
├─ models/                   # 数据模型（不可变 + copyWith）
├─ widgets/                  # 通用基础组件（KtTag/KtAvatar/BombRow/...）
└─ features/
   ├─ splash/                # 启动页
   ├─ auth/                  # 登录 / 注册
   ├─ home/                  # 雷区广场
   ├─ detail/                # 雷帖详情
   ├─ publish/               # 发布避雷帖
   └─ profile/               # 个人中心
```

## 运行

```bash
flutter pub get
flutter run             # 实机 / 模拟器
flutter run -d chrome   # Web
```

## 自助验证

```bash
flutter analyze
flutter test
```
