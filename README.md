# BilibiliStreamHelper for macOS

<div align="center">

![Platform](https://img.shields.io/badge/Platform-macOS-blue)
![Swift](https://img.shields.io/badge/Swift-6.0-orange)
![SwiftUI](https://img.shields.io/badge/macOS-13.0+-green)
![License](https://img.shields.io/badge/License-Apache%202.0-red)
![Version](https://img.shields.io/badge/Version-v1.1.0-brightgreen)
![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF)

使用 Swift 6 + SwiftUI 开发的哔哩哔哩直播推流码获取工具。

**✨ 具备完整的 CI/CD 自动化流程，支持一键构建和发布！**

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

### 📦 下载使用

#### 方式一：下载预编译版本（推荐）
1. 访问 [Releases 页面](https://github.com/sosoorin/BilibiliStreamHelper/releases)
2. 下载最新的 `BilibiliStreamHelper-v1.1.0-macos.dmg`
3. 双击安装，拖拽到应用程序文件夹

#### 方式二：从源码构建
```bash
# 克隆仓库
git clone https://github.com/sosoorin/BilibiliStreamHelper.git
cd BilibiliStreamHelper

# 安装依赖并构建
make dev-setup
make build

# 或直接用 Xcode 打开
make open
```

### 系统要求
- **运行**: macOS 13.0+
- **开发**: macOS 13.0+ + Xcode 26.0+

### 使用流程
1. **登录** → 扫码或手动输入Cookie
2. **设置** → 输入标题，选择分区
3. **开播** → 获取推流信息
4. **OBS** → 配置服务器地址和推流码

## 🏗️ 技术栈

### 核心技术
- **Swift 6** + **SwiftUI** - 现代化的用户界面
- **URLSession** - 网络请求处理
- **Keychain Services** - 安全存储敏感信息
- **CoreImage** - 二维码生成和处理

### 开发工具链
- **Xcode 26.0** - 最新开发环境
- **GitHub Actions** - 自动化CI/CD流程
- **SwiftyJSON** - JSON数据解析
- **语义化版本管理** - 规范的版本控制

## 🛠️ 开发者指南

### 快速开发环境设置
```bash
# 完整的开发环境设置
make dev-setup

# 查看项目状态
make status

# 运行构建
make build

# 查看所有可用命令
make help
```

### CI/CD 流程
项目配备完整的自动化流程：
- **自动构建**: 推送标签时自动触发
- **多架构支持**: arm64 + x86_64
- **自动发布**: 生成DMG和ZIP安装包
- **版本管理**: 语义化版本控制

详细说明请参考：
- [CI/CD 快速指南](CICD_QUICKSTART.md)
- [完整CI/CD文档](docs/CI_CD_SETUP.md)

### 版本发布
```bash
# 增加版本号
make bump-patch   # 1.0.0 → 1.0.1
make bump-minor   # 1.0.0 → 1.1.0  
make bump-major   # 1.0.0 → 2.0.0

# 创建发布
make release
```

## 🐛 常见问题

- **二维码过期** → 重新生成
- **Cookie失效** → 重新登录
- **开播失败** → 检查分区设置
- **人脸认证** → 用手机客户端扫码
- **构建失败** → 检查Xcode版本和依赖

## 🤝 贡献指南

欢迎贡献代码！请遵循以下步骤：

1. Fork 本仓库
2. 创建功能分支: `git checkout -b feature/amazing-feature`
3. 提交更改: `git commit -m 'Add some amazing feature'`
4. 推送分支: `git push origin feature/amazing-feature`
5. 提交 Pull Request

## 贡献者

![cr](https://contrib.rocks/image?repo=sosoorin/BilibiliStreamHelper)

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