# 哔哩哔哩直播推流码获取工具 - Swift版

<div align="center">

![Platform](https://img.shields.io/badge/Platform-macOS-blue)
![Swift](https://img.shields.io/badge/Swift-6.0-orange)
![SwiftUI](https://img.shields.io/badge/SwiftUI-macOS%2013.0+-green)
![License](https://img.shields.io/badge/License-Apache%202.0-red)

一个使用 Swift 6 + SwiftUI 开发的哔哩哔哩直播推流码获取工具，帮助用户快速获取直播推流信息，方便使用 OBS 等推流软件进行直播。

</div>

## 📖 项目简介

本项目是基于 [ChaceQC/bilibili_live_stream_code](https://github.com/ChaceQC/bilibili_live_stream_code) Python版本重构的 macOS 原生应用。采用现代的 Swift 6 语言和 SwiftUI 框架，提供更流畅的用户体验和更好的系统集成。

### ✨ 主要功能

- 🔐 **双重登录方式**：支持扫码登录和手动Cookie登录
- 📺 **直播管理**：设置标题、选择分区、开启/关闭直播
- 🔄 **推流信息获取**：自动获取RTMP服务器地址和推流码
- 💬 **弹幕发送**：应用内直接发送弹幕到直播间
- 📋 **便捷操作**：一键复制、配置导出、OBS配置指导
- 🔒 **安全存储**：使用Keychain安全存储敏感信息
- 🎨 **现代界面**：原生macOS设计风格，支持深色模式

## ⚠️ 重要声明

**本程序仅用于获取推流地址以及推流码，理论上不会对账号造成风险。任何与账号相关的问题概不负责。**

## 🚀 快速开始

### 系统要求

- **macOS**: 13.0 或更高版本
- **Xcode**: 17.0 或更高版本（仅开发需要）
- **Swift**: 6.0

### 安装运行

1. 下载项目源代码
2. 使用 Xcode 打开 `BilibiliLiveStremCodeSwift.xcodeproj`
3. 选择目标设备为 macOS
4. 点击运行按钮或按 `Cmd+R`

### 使用教程

#### 1️⃣ 登录账户

**扫码登录（推荐）**
1. 启动应用，选择“二维码登录”
2. 使用哔哩哔哩手机客户端扫描二维码
3. 在手机上确认登录

**手动登录**
1. 切换到"手动输入"标签
2. 按照界面提示获取Cookie和CSRF Token：
   - 在浏览器中登录B站并进入直播间
   - 右键点击页面，选择"检查"打开开发者工具
   - 切换到"网络"标签，发送一条弹幕
   - 找到"send"请求，复制Cookie和csrf参数
3. 填入直播间ID、Cookie和CSRF Token

#### 2️⃣ 设置直播

1. 登录成功后进入"直播设置"页面
2. 输入直播标题
3. 选择合适的主分区和子分区
4. 点击"开始直播"

#### 3️⃣ 获取推流信息

1. 直播开启后，进入"推流信息"页面
2. 复制服务器地址和推流码
3. 或点击"导出配置"保存为文件

#### 4️⃣ 配置OBS

1. 打开 OBS Studio
2. 进入"设置" → "推流"
3. 服务选择"自定义"
4. 填入获取的服务器地址和推流码
5. 开始推流

## 🏗️ 项目架构

### 技术栈

- **Swift 6**: 最新的Swift语言特性，严格并发安全
- **SwiftUI**: 声明式UI框架，原生macOS体验
- **URLSession**: 现代网络请求处理
- **Keychain Services**: 安全的敏感信息存储
- **CoreImage**: 二维码生成

### 项目结构

```
BilibiliLiveStremCodeSwift/
├── Models/
│   └── BilibiliAPI.swift              # API服务和数据模型
├── Views/
│   ├── LoginView.swift                # 登录界面
│   ├── MainView.swift                 # 主界面导航
│   ├── LiveSettingsView.swift         # 直播设置
│   ├── StreamInfoView.swift           # 推流信息
│   ├── DanmakuView.swift              # 弹幕发送
│   └── UserDetailView.swift           # 用户详情
├── Assets.xcassets/                   # 应用资源
├── ContentView.swift                  # 根视图
└── BilibiliLiveStremCodeSwiftApp.swift # 应用入口
```

### 使用须知

1. **⚠️务必使用本程序停止直播⚠️**：OBS停止推流不等于B站下播！
2. **推流码一次性使用**：每次直播需要重新获取推流码
3. **遵守平台规则**：请遵守哔哩哔哩直播规范和相关法律法规

### 安全保障

- ✅ 不保存用户密码
- ✅ 仅使用官方API接口
- ✅ Cookie信息仅在本地安全存储

## 🐛 故障排除

### 常见问题

**登录相关**
- 二维码过期：重新生成二维码
- 扫码无响应：检查网络连接，确保手机和电脑在同一网络
- Cookie失效：应用会自动检测并提示重新登录

**直播相关**
- 开播失败：检查分区设置是否正确
- 推流码获取失败：确认直播已成功开启
- 人脸认证：使用手机客户端扫描应用显示的认证二维码

**应用相关**
- 网络权限问题：应用已禁用沙盒，确保网络访问正常
- 界面显示异常：重启应用或检查macOS版本兼容性

## 📝 更新日志

### v1.0.0 (2025-09-23)
- 🎉 初始版本发布
- ✨ 完整的Swift 6 + SwiftUI重构
- 🔐 支持扫码和手动Cookie双重登录
- 📺 完整的直播管理功能
- 🔒 安全的信息存储机制
- 🎨 原生macOS界面设计
- 💬 弹幕发送功能
- 📋 推流信息导出功能
- 🤖 人脸认证处理功能

## 🙏 致谢

### 原项目致谢

本项目基于以下优秀的开源项目：

- **[ChaceQC/bilibili_live_stream_code](https://github.com/ChaceQC/bilibili_live_stream_code)** - 原Python版本
  - 作者: [Chace](https://github.com/ChaceQC)
  - 特别感谢: [琴子](https://github.com/Truble-Maker)、[Roberta001](https://github.com/Roberta001)
  - 贡献者: [DarkModest](https://github.com/DarkModest)、[hxzhao527](https://github.com/hxzhao527)

### 技术依赖致谢

感谢以下技术和工具的支持：

- **Apple Developer Tools**
  - Swift 6 编程语言
  - SwiftUI 用户界面框架
  - Xcode 集成开发环境
  - URLSession 网络框架
  - Keychain Services 安全存储

- **API文档支持**
  - **[SocialSisterYi/bilibili-API-collect](https://github.com/SocialSisterYi/bilibili-API-collect)** - 哔哩哔哩API收集整理
    - 提供了详细的B站API接口文档和技术规范
    - 为本项目的API接口实现提供了重要参考

- **开源社区**
  - 感谢所有为Swift和SwiftUI生态贡献的开发者
  - 感谢提供API接口分析和技术支持的社区成员

### Swift版本开发

- **开发者**: sosoorin
- **重构时间**: 2025年9月
- **技术栈**: Swift 6 + SwiftUI + macOS 13.0+
- **开发工具**: Xcode 26，部分代码使用AI辅助生成和优化

## 🤖 AI辅助开发声明

本项目在开发过程中使用了人工智能技术辅助：

- **代码生成**: 部分代码结构和逻辑使用AI辅助生成
- **代码优化**: 使用AI协助进行代码重构和性能优化
- **文档编写**: 项目文档和注释部分使用AI辅助编写
- **问题解决**: 在开发过程中使用AI协助解决技术问题

最终的代码经过人工审核、测试，确保功能正确性和代码质量。

## 📄 版权信息

### 许可证

本项目采用 Apache License 2.0 许可证 - 详见 [LICENSE](LICENSE) 文件

### 免责声明

1. 本软件仅供学习和个人使用
2. 使用本软件所产生的任何后果由用户自行承担
3. 请遵守哔哩哔哩用户协议和相关法律法规
4. 作者不对因使用本软件而导致的任何损失承担责任

---

<div align="center">

**如果这个项目对你有帮助，请给一个 ⭐️ Star！**

[问题反馈](https://github.com/sosoorin/BilibiliLiveStremCodeSwift/issues) • 
[功能建议](https://github.com/sosoorin/BilibiliLiveStremCodeSwift/issues) • 
[贡献代码](https://github.com/sosoorin/BilibiliLiveStremCodeSwift/pulls)

</div>
