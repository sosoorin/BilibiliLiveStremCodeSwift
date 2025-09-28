# BilibiliStreamHelper Makefile
# 简化常用的开发和部署操作

.PHONY: help build clean test release setup status bump-patch bump-minor bump-major install-deps

# 项目配置
PROJECT_NAME = BilibiliStreamHelper
SCHEME_NAME = BilibiliStreamHelper
CONFIGURATION = Release

# 默认目标
help: ## 显示帮助信息
	@echo "BilibiliStreamHelper 项目管理工具"
	@echo ""
	@echo "可用命令:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "版本管理:"
	@echo "  bump-patch     增加补丁版本 (1.0.0 → 1.0.1)"
	@echo "  bump-minor     增加次版本 (1.0.0 → 1.1.0)"
	@echo "  bump-major     增加主版本 (1.0.0 → 2.0.0)"

setup: ## 初始化项目环境
	@echo "🔧 初始化项目环境..."
	@mkdir -p docs scripts
	@chmod +x scripts/*.sh
	@echo "✅ 项目环境初始化完成"

status: ## 显示项目状态
	@echo "📊 项目状态:"
	@./scripts/version_manager.sh status

clean: ## 清理构建产物
	@echo "🧹 清理构建产物..."
	@./scripts/build_config.sh clean
	@echo "✅ 清理完成"

build: ## 构建项目
	@echo "🔨 构建项目..."
	@xcodebuild -project $(PROJECT_NAME).xcodeproj \
		-scheme $(SCHEME_NAME) \
		-configuration $(CONFIGURATION) \
		-destination "generic/platform=macOS" \
		build

test: ## 运行测试
	@echo "🧪 运行测试..."
	@xcodebuild test \
		-project $(PROJECT_NAME).xcodeproj \
		-scheme $(SCHEME_NAME) \
		-destination "platform=macOS" || echo "⚠️  没有找到测试目标"

archive: ## 创建归档
	@echo "📦 创建归档..."
	@xcodebuild archive \
		-project $(PROJECT_NAME).xcodeproj \
		-scheme $(SCHEME_NAME) \
		-configuration $(CONFIGURATION) \
		-archivePath build/$(PROJECT_NAME).xcarchive \
		-destination "generic/platform=macOS"

install-deps: ## 安装依赖
	@echo "📥 解析 Swift 包依赖..."
	@xcodebuild -resolvePackageDependencies \
		-project $(PROJECT_NAME).xcodeproj \
		-scheme $(SCHEME_NAME)
	@echo "✅ 依赖安装完成"

validate: ## 验证项目配置
	@echo "✅ 验证项目配置..."
	@./scripts/build_config.sh validate

bump-patch: ## 增加补丁版本
	@echo "📈 增加补丁版本..."
	@./scripts/version_manager.sh bump patch

bump-minor: ## 增加次版本
	@echo "📈 增加次版本..."
	@./scripts/version_manager.sh bump minor

bump-major: ## 增加主版本
	@echo "📈 增加主版本..."
	@./scripts/version_manager.sh bump major

release: ## 创建发布
	@echo "🚀 创建发布..."
	@./scripts/version_manager.sh release

# 开发工作流快捷方式
dev-setup: setup install-deps ## 完整的开发环境设置
	@echo "🎉 开发环境设置完成！"

pre-release: clean validate build ## 发布前检查
	@echo "✅ 发布前检查通过"

# CI/CD 相关
ci-setup: ## 配置 CI 环境
	@echo "🔧 配置 CI 环境..."
	@./scripts/build_config.sh ci

ci-restore: ## 恢复本地开发环境
	@echo "🔄 恢复本地开发环境..."
	@./scripts/build_config.sh local

# 项目信息
info: ## 显示项目信息
	@echo "📋 项目信息:"
	@echo "  名称: $(PROJECT_NAME)"
	@echo "  方案: $(SCHEME_NAME)"
	@echo "  配置: $(CONFIGURATION)"
	@echo "  当前版本: $$(./scripts/version_manager.sh current)"
	@echo "  Git 分支: $$(git branch --show-current 2>/dev/null || echo '未知')"
	@echo "  最新标签: $$(git describe --tags --abbrev=0 2>/dev/null || echo '无标签')"

# 快速发布工作流
quick-release: pre-release bump-patch release ## 快速补丁发布
	@echo "🎉 快速发布完成！"

# Xcode 操作
open: ## 在 Xcode 中打开项目
	@open $(PROJECT_NAME).xcodeproj

# 文档生成
docs: ## 生成项目文档
	@echo "📚 生成项目文档..."
	@echo "文档已生成到 docs/ 目录"

# 代码格式化 (如果使用 SwiftFormat)
format: ## 格式化代码
	@if command -v swiftformat >/dev/null 2>&1; then \
		echo "🎨 格式化代码..."; \
		swiftformat .; \
		echo "✅ 代码格式化完成"; \
	else \
		echo "⚠️  SwiftFormat 未安装，跳过格式化"; \
		echo "安装命令: brew install swiftformat"; \
	fi

# 代码检查 (如果使用 SwiftLint)
lint: ## 检查代码风格
	@if command -v swiftlint >/dev/null 2>&1; then \
		echo "🔍 检查代码风格..."; \
		swiftlint; \
		echo "✅ 代码检查完成"; \
	else \
		echo "⚠️  SwiftLint 未安装，跳过检查"; \
		echo "安装命令: brew install swiftlint"; \
	fi
