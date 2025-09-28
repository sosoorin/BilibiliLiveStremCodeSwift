#!/bin/bash

# Version Manager Script for BilibiliStreamHelper
# Manages semantic versioning and automatic releases

set -e

PROJECT_NAME="BilibiliStreamHelper"
VERSION_FILE="VERSION"
CHANGELOG_FILE="CHANGELOG.md"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_color() {
    printf "${1}${2}${NC}\n"
}

# Function to get current version
get_current_version() {
    if [ -f "$VERSION_FILE" ]; then
        cat "$VERSION_FILE"
    else
        echo "0.0.0"
    fi
}

# Function to validate version format
validate_version() {
    local version=$1
    if [[ ! $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        print_color $RED "❌ Error: Invalid version format. Use semantic versioning (e.g., 1.0.0)"
        exit 1
    fi
}

# Function to compare versions
version_gt() {
    test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1"
}

# Function to increment version
increment_version() {
    local version=$1
    local type=$2
    
    IFS='.' read -ra PARTS <<< "$version"
    local major=${PARTS[0]}
    local minor=${PARTS[1]}
    local patch=${PARTS[2]}
    
    case $type in
        "major")
            major=$((major + 1))
            minor=0
            patch=0
            ;;
        "minor")
            minor=$((minor + 1))
            patch=0
            ;;
        "patch")
            patch=$((patch + 1))
            ;;
        *)
            print_color $RED "❌ Error: Invalid increment type. Use: major, minor, or patch"
            exit 1
            ;;
    esac
    
    echo "$major.$minor.$patch"
}

# Function to update version file
update_version_file() {
    local version=$1
    echo "$version" > "$VERSION_FILE"
    print_color $GREEN "✅ Updated $VERSION_FILE to $version"
}

# Function to update project version
update_project_version() {
    local version=$1
    local build_number=$(date +%Y%m%d%H%M%S)
    
    # Update project.pbxproj
    sed -i '' "s/MARKETING_VERSION = [^;]*/MARKETING_VERSION = $version/" "${PROJECT_NAME}.xcodeproj/project.pbxproj"
    sed -i '' "s/CURRENT_PROJECT_VERSION = [^;]*/CURRENT_PROJECT_VERSION = $build_number/" "${PROJECT_NAME}.xcodeproj/project.pbxproj"
    
    print_color $GREEN "✅ Updated project version to $version (build: $build_number)"
}

# Function to create or update changelog
update_changelog() {
    local version=$1
    local date=$(date +%Y-%m-%d)
    
    if [ ! -f "$CHANGELOG_FILE" ]; then
        cat > "$CHANGELOG_FILE" << EOF
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [$version] - $date

### Added
- Initial release
- 双重登录方式：扫码登录 / 手动Cookie登录
- 直播管理：设置标题、选择分区、开启/关闭直播
- 推流信息获取：自动获取RTMP服务器地址和推流码
- 弹幕发送：应用内直接发送弹幕
- 便捷操作：一键复制、配置导出
- 安全存储：使用Keychain安全存储敏感信息

EOF
    else
        # Insert new version entry after the [Unreleased] section
        local temp_file=$(mktemp)
        awk -v version="$version" -v date="$date" '
        /## \[Unreleased\]/ {
            print $0
            print ""
            print "## [" version "] - " date
            print ""
            print "### Added"
            print "- Version " version " release"
            print ""
            next
        }
        { print }
        ' "$CHANGELOG_FILE" > "$temp_file"
        mv "$temp_file" "$CHANGELOG_FILE"
    fi
    
    print_color $GREEN "✅ Updated $CHANGELOG_FILE"
}

# Function to create git tag and push
create_release() {
    local version=$1
    local tag="v$version"
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_color $RED "❌ Error: Not in a git repository"
        exit 1
    fi
    
    # Check if there are uncommitted changes
    if ! git diff-index --quiet HEAD --; then
        print_color $YELLOW "⚠️  Warning: There are uncommitted changes"
        read -p "Do you want to commit all changes? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git add .
            git commit -m "chore: bump version to $version"
        else
            print_color $RED "❌ Please commit your changes first"
            exit 1
        fi
    fi
    
    # Check if tag already exists
    if git tag -l | grep -q "^$tag$"; then
        print_color $RED "❌ Error: Tag $tag already exists"
        exit 1
    fi
    
    # Create and push tag
    git tag -a "$tag" -m "Release $tag"
    git push origin "$tag"
    git push origin main 2>/dev/null || git push origin master 2>/dev/null || print_color $YELLOW "⚠️  Could not push to remote"
    
    print_color $GREEN "🚀 Created and pushed tag $tag"
    print_color $BLUE "🔗 GitHub Actions will automatically create a release"
}

# Function to show current status
show_status() {
    local current_version=$(get_current_version)
    print_color $BLUE "📦 Project: $PROJECT_NAME"
    print_color $BLUE "📋 Current version: $current_version"
    
    if git rev-parse --git-dir > /dev/null 2>&1; then
        local latest_tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "No tags")
        print_color $BLUE "🏷️  Latest tag: $latest_tag"
        
        local branch=$(git branch --show-current)
        print_color $BLUE "🌿 Current branch: $branch"
        
        local commits_ahead=$(git rev-list --count HEAD ^origin/main 2>/dev/null || echo "0")
        if [ "$commits_ahead" -gt 0 ]; then
            print_color $YELLOW "⚠️  $commits_ahead commits ahead of origin/main"
        fi
    fi
}

# Main execution
case "${1:-help}" in
    "current")
        echo $(get_current_version)
        ;;
    "status")
        show_status
        ;;
    "bump")
        if [ -z "$2" ]; then
            print_color $RED "❌ Error: Please specify increment type (major|minor|patch)"
            exit 1
        fi
        
        current_version=$(get_current_version)
        new_version=$(increment_version "$current_version" "$2")
        
        print_color $YELLOW "🔄 Bumping version from $current_version to $new_version"
        
        update_version_file "$new_version"
        update_project_version "$new_version"
        update_changelog "$new_version"
        
        print_color $GREEN "✅ Version bump completed!"
        print_color $BLUE "💡 Run '$0 release' to create a git tag and trigger release"
        ;;
    "set")
        if [ -z "$2" ]; then
            print_color $RED "❌ Error: Please specify version (e.g., 1.0.0)"
            exit 1
        fi
        
        validate_version "$2"
        current_version=$(get_current_version)
        
        if ! version_gt "$2" "$current_version"; then
            print_color $RED "❌ Error: New version ($2) must be greater than current version ($current_version)"
            exit 1
        fi
        
        print_color $YELLOW "🔄 Setting version to $2"
        
        update_version_file "$2"
        update_project_version "$2"
        update_changelog "$2"
        
        print_color $GREEN "✅ Version set successfully!"
        ;;
    "release")
        current_version=$(get_current_version)
        create_release "$current_version"
        ;;
    "help"|*)
        print_color $BLUE "🔧 Version Manager for $PROJECT_NAME"
        echo ""
        echo "Usage: $0 {current|status|bump|set|release|help}"
        echo ""
        echo "Commands:"
        echo "  current           - Show current version"
        echo "  status            - Show project status"
        echo "  bump <type>       - Bump version (major|minor|patch)"
        echo "  set <version>     - Set specific version (e.g., 1.0.0)"
        echo "  release           - Create git tag and trigger release"
        echo "  help              - Show this help message"
        echo ""
        echo "Examples:"
        echo "  $0 bump patch     - Increment patch version (1.0.0 → 1.0.1)"
        echo "  $0 bump minor     - Increment minor version (1.0.0 → 1.1.0)"
        echo "  $0 bump major     - Increment major version (1.0.0 → 2.0.0)"
        echo "  $0 set 1.2.3      - Set version to 1.2.3"
        echo "  $0 release        - Create release from current version"
        ;;
esac
