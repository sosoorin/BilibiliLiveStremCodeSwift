# CI/CD 快速使用指南

<div align="center">

![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF)
![Xcode](https://img.shields.io/badge/Xcode-26.0-147EFB)
![Architecture](https://img.shields.io/badge/Architecture-arm64%20%2B%20x86__64-green)

**⚡ 5分钟设置完整的macOS应用自动化构建和发布流程**

</div>

## 🚀 一键开始

✨ 你的项目已经配置好完整的CI/CD流程！以下是快速开始步骤：

### 1. 首次发布

```bash
# 提交当前更改
git add .
git commit -m "feat: setup CI/CD pipeline"

# 推送到GitHub
git push origin master

# 创建首个发布版本
make release
```

### 2. 后续版本发布

```bash
# 开发完成后，增加版本号
make bump-patch   # 修复版本 (1.0.0 → 1.0.1)
make bump-minor   # 功能版本 (1.0.0 → 1.1.0)  
make bump-major   # 重大版本 (1.0.0 → 2.0.0)

# 创建发布
make release
```

### 3. 自动化流程

一旦推送标签到GitHub，Actions会自动：
- ✅ 构建macOS应用
- ✅ 生成DMG和ZIP安装包
- ✅ 创建GitHub Release
- ✅ 上传构建产物

## 📋 可用命令

```bash
make help         # 显示所有可用命令
make status       # 查看项目状态
make build        # 本地构建测试
make clean        # 清理构建产物
make validate     # 验证项目配置
```

## 🔧 手动触发发布

你也可以在GitHub仓库页面手动触发发布：

1. 进入 **Actions** 标签页
2. 选择 **Release macOS App** 工作流
3. 点击 **Run workflow** 
4. 输入版本号（如 `v1.0.1`）
5. 点击运行

## 📦 发布产物

每次成功构建会生成：
- **DMG安装包**：`BilibiliStreamHelper-v1.0.0-macos.dmg`
- **ZIP压缩包**：`BilibiliStreamHelper-v1.0.0-macos.zip`

## ⚙️ 系统要求

- **开发环境**: macOS 13.0+, Xcode 26.0+
- **CI环境**: GitHub Actions (macos-26 runner)
- **目标系统**: macOS 13.0+
- **支持架构**: Apple Silicon (arm64) + Intel (x86_64)

## 📝 版本管理

项目使用语义化版本：
- **主版本 (MAJOR)**: 不兼容的更改
- **次版本 (MINOR)**: 新增功能
- **修订版 (PATCH)**: 错误修复

## 🆘 问题排除

遇到问题？查看：
1. [详细设置文档](docs/CI_CD_SETUP.md)
2. GitHub Actions日志
3. [提出Issue](https://github.com/你的用户名/BilibiliStreamHelper/issues)

---

🎉 **你的CI/CD系统已经就绪！现在可以专注于开发，发布交给自动化处理。**
