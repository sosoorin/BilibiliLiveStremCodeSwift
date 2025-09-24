# BilibiliStreamHelper for macOS

<div align="center">

![Platform](https://img.shields.io/badge/Platform-macOS-blue)
![Swift](https://img.shields.io/badge/Swift-6.0-orange)
![SwiftUI](https://img.shields.io/badge/macOS-13.0+-green)
![License](https://img.shields.io/badge/License-Apache%202.0-red)

使用 Swift 6 + SwiftUI 开发的哔哩哔哩直播推流码获取工具。

</div>

> 不能获取推流码后，官方提供的Mac开播方法实在是太难用了！！

## ✨ 主要功能

- 🔐 **双重登录方式**：扫码登录 / 手动Cookie登录
- 📺 **直播管理**：设置标题、选择分区、开启/关闭直播
- 🔄 **推流信息获取**：自动获取RTMP服务器地址和推流码
- 💬 **弹幕发送**：应用内直接发送弹幕
- 📋 **便捷操作**：一键复制、配置导出
- 🔒 **安全存储**：使用Keychain安全存储敏感信息

## ⚠️ 重要提醒

- 本程序仅获取推流信息，使用官方API接口，**理论上**正常使用不会影响账号安全。
- 使用前请确保遵守B站相关条款，使用风险由用户自行承担。
- **请务必使用本程序停止直播**（OBS停止推流≠B站下播）。
- 推流码一次性使用，每次直播需重新获取。

## 🚀 快速开始

### 系统要求
- macOS 13.0+ 
- Xcode 17.0+（开发）

### 运行
1. 下载源代码
2. 用 Xcode 打开 `BilibiliLiveStremCodeSwift.xcodeproj`
3. 选择 macOS 目标，运行

### 使用流程
1. **登录** → 扫码或手动输入Cookie
2. **设置** → 输入标题，选择分区
3. **开播** → 获取推流信息
4. **OBS** → 配置服务器地址和推流码

## 🏗️ 技术栈

- **Swift 6** + **SwiftUI**
- **URLSession** 网络请求
- **Keychain Services** 安全存储
- **CoreImage** 二维码生成

## 🐛 常见问题

- **二维码过期** → 重新生成
- **Cookie失效** → 重新登录
- **开播失败** → 检查分区设置
- **人脸认证** → 用手机客户端扫码

## 📄 许可证

 [Apache License 2.0](./LICENSE)

## 🙏 致谢

**功能思路参考**
- [ChaceQC/bilibili_live_stream_code](https://github.com/ChaceQC/bilibili_live_stream_code)

**技术依赖**
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) - JSON解析
- [Apple CryptoKit](https://developer.apple.com/documentation/cryptokit) - 加密算法
- [SocialSisterYi/bilibili-API-collect](https://github.com/SocialSisterYi/bilibili-API-collect) - API文档参考

---

<div align="center">

**如果有帮助请给个 ⭐️ Star！**

[问题反馈](https://github.com/sosoorin/BilibiliStreamHelper/issues) • [功能建议](https://github.com/sosoorin/BilibiliStreamHelper/issues)

</div>