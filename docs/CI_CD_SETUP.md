# CI/CD 设置指南

<div align="center">

![Status](https://img.shields.io/badge/Status-Production%20Ready-brightgreen)
![Version](https://img.shields.io/badge/Version-v1.1.0-blue)
![Tested](https://img.shields.io/badge/Tested-✓-success)

**📚 完整的BilibiliStreamHelper项目CI/CD流程设置指南**

</div>

本文档详细说明如何为 BilibiliStreamHelper 项目设置完整的 CI/CD 流程。

> 💡 **提示**: 如果你只是想快速开始，请查看 [CI/CD 快速指南](../CICD_QUICKSTART.md)

## 📋 目录

- [快速开始](#-快速开始)
- [GitHub Actions 配置](#-github-actions-配置)
- [代码签名设置](#-代码签名设置)
- [版本管理](#-版本管理)
- [发布流程](#-发布流程)
- [故障排除](#-故障排除)

## 🚀 快速开始

### 1. 初始化版本管理

```bash
# 设置初始版本
./scripts/version_manager.sh set 1.0.0

# 查看当前状态
./scripts/version_manager.sh status
```

### 2. 测试本地构建

```bash
# 验证项目结构
./scripts/build_config.sh validate

# 清理构建产物
./scripts/build_config.sh clean
```

### 3. 创建首次发布

```bash
# 提交所有更改
git add .
git commit -m "feat: setup CI/CD pipeline"

# 创建发布标签
./scripts/version_manager.sh release
```

## 🔧 GitHub Actions 配置

### 工作流文件

CI/CD 流程由 `.github/workflows/release.yml` 定义，支持：

- **自动触发**：推送标签时自动构建
- **手动触发**：通过 GitHub Actions 界面手动运行
- **多格式输出**：生成 DMG 和 ZIP 安装包

### 触发条件

1. **标签推送触发**
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

2. **手动触发**
   - 在 GitHub 仓库的 Actions 标签页
   - 选择 "Release macOS App" 工作流
   - 点击 "Run workflow"
   - 输入版本号（如 v1.0.0）

### 环境要求

- **运行环境**: macos-26 (GitHub Actions runner)
- **Xcode 版本**: 26.0 (最新稳定版)
- **支持架构**: Apple Silicon (arm64) 和 Intel (x86_64)
- **目标系统**: macOS 13.0+

## 🔐 代码签名设置

### 开发环境（本地构建）

项目默认使用自动签名，适合本地开发：

```xml
CODE_SIGN_STYLE = Automatic
```

### CI/CD 环境（无签名）

CI 构建使用无签名模式，适合开源项目分发：

```xml
CODE_SIGN_IDENTITY = ""
CODE_SIGNING_REQUIRED = NO
CODE_SIGNING_ALLOWED = NO
```

### 生产环境（App Store 或公证）

如需 App Store 分发或公证，需要配置：

1. **创建 App Store Connect 应用**
2. **生成分发证书和配置文件**
3. **在 GitHub Secrets 中添加**：
   - `APPLE_ID`: Apple ID
   - `APPLE_PASSWORD`: 应用专用密码
   - `TEAM_ID`: 开发者团队 ID
   - `SIGNING_CERTIFICATE_P12_DATA`: Base64 编码的 P12 证书
   - `SIGNING_CERTIFICATE_PASSWORD`: P12 证书密码

## 📋 版本管理

### 版本管理脚本

使用 `scripts/version_manager.sh` 管理版本：

```bash
# 查看当前版本
./scripts/version_manager.sh current

# 增加补丁版本 (1.0.0 → 1.0.1)
./scripts/version_manager.sh bump patch

# 增加次版本 (1.0.0 → 1.1.0)
./scripts/version_manager.sh bump minor

# 增加主版本 (1.0.0 → 2.0.0)
./scripts/version_manager.sh bump major

# 设置特定版本
./scripts/version_manager.sh set 1.2.3

# 创建发布标签
./scripts/version_manager.sh release
```

### 语义化版本

项目遵循 [语义化版本](https://semver.org/) 规范：

- **主版本 (MAJOR)**: 不兼容的 API 更改
- **次版本 (MINOR)**: 向后兼容的功能添加
- **修订版本 (PATCH)**: 向后兼容的错误修复

### 变更日志

版本脚本自动维护 `CHANGELOG.md`，记录每个版本的更改。

## 🎯 发布流程

### 标准发布流程

1. **开发完成**
   ```bash
   git add .
   git commit -m "feat: 新功能描述"
   ```

2. **版本管理**
   ```bash
   # 根据更改类型选择版本增量
   ./scripts/version_manager.sh bump minor
   ```

3. **创建发布**
   ```bash
   ./scripts/version_manager.sh release
   ```

4. **自动构建**
   - GitHub Actions 自动触发
   - 构建 macOS 应用
   - 生成 DMG 和 ZIP 安装包
   - 创建 GitHub Release

### 热修复发布

```bash
# 创建热修复分支
git checkout -b hotfix/1.0.1

# 修复问题
git commit -m "fix: 修复关键问题"

# 合并到主分支
git checkout main
git merge hotfix/1.0.1

# 发布补丁版本
./scripts/version_manager.sh bump patch
./scripts/version_manager.sh release
```

### 预发布版本

```bash
# 创建预发布标签
git tag v1.1.0-beta.1
git push origin v1.1.0-beta.1

# 或手动触发 GitHub Actions
# 在版本号后添加 -beta.1 等后缀
```

## 📦 构建产物

每次成功构建会生成：

1. **DMG 安装包** (`BilibiliStreamHelper-v1.0.0-macos.dmg`)
   - 推荐的分发格式
   - 用户双击即可安装
   - 包含应用图标和拖拽安装界面

2. **ZIP 压缩包** (`BilibiliStreamHelper-v1.0.0-macos.zip`)
   - 备选分发格式
   - 用户解压后拖拽到应用程序文件夹

3. **GitHub Release**
   - 自动生成发布说明
   - 包含下载链接和系统要求
   - 支持发布草稿和预发布

## 🛠️ 故障排除

### 常见问题

#### 1. 构建失败：Swift 包依赖解析错误

```bash
# 清理并重新解析依赖
./scripts/build_config.sh clean
xcodebuild -resolvePackageDependencies
```

#### 2. 版本号不匹配

```bash
# 检查版本文件和项目设置
./scripts/version_manager.sh status
./scripts/build_config.sh validate
```

#### 3. Git 标签已存在

```bash
# 删除本地和远程标签
git tag -d v1.0.0
git push origin :refs/tags/v1.0.0

# 重新创建
./scripts/version_manager.sh release
```

#### 4. GitHub Actions 权限错误

确保 GitHub 仓库设置中：
- Settings → Actions → General → Workflow permissions
- 选择 "Read and write permissions"
- 勾选 "Allow GitHub Actions to create and approve pull requests"

### 调试技巧

1. **本地测试构建**
   ```bash
   # 模拟 CI 环境
   ./scripts/build_config.sh ci
   
   # 构建应用
   xcodebuild -project BilibiliStreamHelper.xcodeproj \
     -scheme BilibiliStreamHelper \
     -configuration Release \
     -destination "generic/platform=macOS"
   ```

2. **检查 GitHub Actions 日志**
   - 在 GitHub 仓库的 Actions 标签页
   - 点击失败的工作流查看详细日志
   - 查找红色的错误信息

3. **验证环境变量**
   ```bash
   # 在 GitHub Actions 中添加调试步骤
   - name: Debug Environment
     run: |
       echo "VERSION: $VERSION"
       echo "BUILD_NUMBER: $BUILD_NUMBER"
       printenv | grep -E "(VERSION|BUILD|APPLE)" | sort
   ```

## 🔗 相关链接

- [GitHub Actions 文档](https://docs.github.com/en/actions)
- [Xcode 命令行工具](https://developer.apple.com/xcode/)
- [语义化版本规范](https://semver.org/)
- [App Store 分发指南](https://developer.apple.com/app-store/submitting/)

---

## 📞 支持

如果遇到问题，请：

1. 查看本文档的故障排除部分
2. 检查 GitHub Issues 中的已知问题
3. 创建新的 Issue 并提供详细的错误信息

祝您使用愉快！🎉
