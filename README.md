# 发境 (ReHair) - iOS应用

一个帮助用户模拟不同发型效果的iOS应用。用户可以上传自己的照片,应用会生成不同发型的效果图。

## 功能特性

### 核心功能
- 📸 **照片上传**: 支持拍照或从相册选择照片
- ✨ **发型生成**: AI生成多种发型效果
- 👀 **前后对比**: 滑动对比原始照片与生成效果
- 💾 **保存收藏**: 保存喜欢的发型到本地
- 📤 **分享功能**: 分享发型效果到社交媒体

### 四大模块
1. **首页** - 发型模拟入口,快速上传照片
2. **发型图库** - 浏览各种发型风格的案例
3. **我的发型** - 查看保存的发型历史记录
4. **我的** - 个人中心,账号管理和设置

## 技术栈

- **开发语言**: Swift 5.0+
- **UI框架**: SwiftUI
- **最低支持**: iOS 15.0+
- **架构模式**: MVVM

## 项目结构

```
ReHair/
├── ReHair/
│   ├── App/                      # 应用入口
│   │   ├── ReHairApp.swift      # App主入口
│   │   └── MainTabView.swift    # 主导航视图(TabView)
│   │
│   ├── Models/                   # 数据模型
│   │   ├── User.swift           # 用户模型
│   │   └── HairstyleResult.swift # 发型结果模型
│   │
│   ├── ViewModels/              # 视图模型
│   │   ├── HairstyleGenerationViewModel.swift # 发型生成逻辑
│   │   └── PhotoPickerViewModel.swift         # 照片选择逻辑
│   │
│   ├── Views/                   # 视图层
│   │   ├── Home/               # 首页模块
│   │   │   └── HomeView.swift
│   │   ├── Gallery/            # 图库模块
│   │   │   └── HairstyleGalleryView.swift
│   │   ├── MyHairstyles/       # 我的发型模块
│   │   │   └── MyHairstylesView.swift
│   │   ├── Profile/            # 个人中心模块
│   │   │   └── ProfileView.swift
│   │   └── HairstyleGeneration/ # 发型生成流程
│   │       ├── PhotoPreprocessView.swift      # 照片预处理
│   │       ├── HairstyleGenerationView.swift  # 生成加载页
│   │       └── HairstyleResultView.swift      # 结果展示页
│   │
│   ├── Services/               # 服务层(网络请求等)
│   ├── Utils/                  # 工具类
│   │   ├── ImagePicker.swift   # 图片选择器
│   │   └── Extensions.swift    # Swift扩展
│   │
│   ├── Resources/              # 资源文件
│   ├── Assets.xcassets/        # 图片资源
│   └── Info.plist             # 应用配置
│
└── ReHair.xcodeproj/          # Xcode项目文件
```

## 快速开始

### 环境要求
- macOS 13.0+
- Xcode 15.0+
- iOS 15.0+ 设备或模拟器

### 安装步骤

1. **克隆项目**
```bash
git clone https://github.com/yourusername/ReHair.git
cd ReHair
```

2. **打开项目**
```bash
open ReHair.xcodeproj
```

3. **运行应用**
- 在Xcode中选择目标设备(模拟器或真机)
- 点击运行按钮(⌘ + R)

## 主要页面流程

### 1. 首页 (HomeView)
- 展示欢迎信息和价值主张
- 提供"拍照上传"按钮
- 展示效果案例

### 2. 照片预处理 (PhotoPreprocessView)
- 显示选择的照片
- 自动裁剪和优化提示
- 确认或重新上传

### 3. 发型生成 (HairstyleGenerationView)
- 显示生成进度
- 阶段提示:分析发际线 → 生成发型 → 处理图片
- 进度条和百分比显示

### 4. 结果展示 (HairstyleResultView)
- 轮播展示多个发型效果
- 前后对比功能(滑动查看)
- 保存、分享按钮

### 5. 我的发型 (MyHairstylesView)
- 网格展示保存的发型
- 查看详情和删除功能
- 清空所有记录

### 6. 个人中心 (ProfileView)
- 登录/注册(手机号或Apple ID)
- 隐私政策
- 意见反馈
- 清理缓存

## UI设计规范

### 颜色主题
- **主色调**: 浅蓝色 (`Color.primaryBlue`)
- **辅助色**: 灰色 (`Color.secondaryGray`)
- **文字主色**: 深灰 (`Color.textPrimary`)
- **文字辅色**: 灰色 (`Color.textSecondary`)

### 设计风格
- 简洁现代的卡片式布局
- 圆角设计(12px)
- 柔和的阴影效果
- 流畅的动画过渡

## 数据模型

### User (用户)
```swift
struct User {
    let id: UUID
    var name: String
    var email: String?
    var phone: String?
    var loginMethod: LoginMethod // phone, appleID, guest
}
```

### HairstyleResult (发型结果)
```swift
struct HairstyleResult {
    let id: UUID
    let originalImageURL: String
    let generatedImageURL: String
    let style: HairstyleStyle
    let tags: [String]
    let createdAt: Date
    var isFavorite: Bool
}
```

### HairstyleStyle (发型风格)
- 短发
- 中长发
- 长发
- 卷发
- 直发
- 韩系
- 自然发际线
- 商务休闲

## 后续开发计划

### Phase 1 (当前版本 1.0)
- ✅ 基础UI框架
- ✅ 照片上传和预处理
- ✅ 发型生成模拟
- ✅ 结果展示和对比
- ✅ 本地存储

### Phase 2 (v1.1)
- [ ] 接入真实AI发型生成API
- [ ] 完善用户登录系统
- [ ] 实现云端数据同步
- [ ] 添加社交分享功能

### Phase 3 (v1.2)
- [ ] AR实时试发功能(ARKit)
- [ ] 发型风格推荐系统
- [ ] PDF报告生成
- [ ] 用户评价系统

### Phase 4 (v2.0)
- [ ] 发型历史图表
- [ ] 多语言支持
- [ ] iPad适配
- [ ] Apple Watch配套应用

## 权限说明

应用需要以下权限:
- **相机权限** (`NSCameraUsageDescription`): 用于拍摄照片
- **相册权限** (`NSPhotoLibraryUsageDescription`): 用于选择照片
- **保存照片权限** (`NSPhotoLibraryAddUsageDescription`): 用于保存生成的发型照片

## 注意事项

### 当前限制
1. 发型生成功能目前为模拟实现,需要接入真实AI API
2. 图片展示使用占位符,需要替换为真实图片
3. 数据持久化仅在内存中,需要实现本地存储(CoreData或UserDefaults)
4. 网络请求服务层需要完善

### TODO列表
- [ ] 实现真实的AI发型生成API集成
- [ ] 添加CoreData数据持久化
- [ ] 实现图片缓存机制
- [ ] 添加错误处理和用户提示
- [ ] 实现分享功能
- [ ] 添加单元测试
- [ ] 性能优化和内存管理

## 贡献指南

欢迎提交Issue和Pull Request!

1. Fork本项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启Pull Request

## 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

## 联系方式

- 项目主页: [https://github.com/yourusername/ReHair](https://github.com/yourusername/ReHair)
- 问题反馈: [https://github.com/yourusername/ReHair/issues](https://github.com/yourusername/ReHair/issues)
- 邮箱: support@rehair.app

---

**发境** - 让每个人都能找到最适合自己的发型 💇‍♂️✨
