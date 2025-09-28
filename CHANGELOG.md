# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.1.0] - 2025-09-28

### 🚀 Major Features
- **完整的CI/CD流程**: 基于GitHub Actions的自动化构建和发布
- **使用Xcode 26.0构建**
- **多架构支持**: 同时支持Apple Silicon (arm64) 和 Intel (x86_64)
- **自动化包管理**: 自动生成DMG和ZIP安装包

## [1.0.0] - 2025-09-24

### 🎉 Initial Release
- **双重登录方式**: 扫码登录 / 手动Cookie登录
- **直播管理**: 设置标题、选择分区、开启/关闭直播  
- **推流信息获取**: 自动获取RTMP服务器地址和推流码
- **弹幕发送**: 应用内直接发送弹幕
- **便捷操作**: 一键复制、配置导出
- **安全存储**: 使用Keychain安全存储敏感信息
- **SwiftUI界面**: 现代化的macOS原生界面
- **Swift 6支持**: 使用最新的Swift语言特性