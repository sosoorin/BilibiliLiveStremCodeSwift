# CI/CD 快速指南

⚡ **3分钟设置自动化构建发布流程**

## 🚀 快速开始

### 发布新版本
```bash
# 增加版本号
make bump-patch   # 1.0.0 → 1.0.1 (修复)
make bump-minor   # 1.0.0 → 1.1.0 (功能)
make bump-major   # 1.0.0 → 2.0.0 (重大更新)

# 创建发布 (自动触发GitHub Actions)
make release
```

### 手动触发
GitHub仓库 → **Actions** → **Release macOS App** → **Run workflow**

## 📦 自动生成
- **DMG安装包** (推荐)
- **ZIP压缩包** (备选)
- **GitHub Release** (自动发布说明)

## 🔧 常用命令
```bash
make status       # 查看项目状态
make build        # 本地构建测试
make help         # 显示所有命令
```

## 📝 版本说明
- **PATCH**: 错误修复
- **MINOR**: 新增功能  
- **MAJOR**: 重大更改

**注意**: CHANGELOG.md 会自动更新版本信息

---
**问题反馈**: [GitHub Issues](https://github.com/sosoorin/BilibiliStreamHelper/issues)
