#!/bin/bash

# Build Configuration Script for BilibiliStreamHelper
# This script prepares the project for CI/CD builds

set -e

PROJECT_NAME="BilibiliStreamHelper"
PROJECT_FILE="${PROJECT_NAME}.xcodeproj"
PLIST_FILE="${PROJECT_NAME}/Info.plist"

echo "🔧 Configuring build settings for ${PROJECT_NAME}..."

# Function to update plist if it exists
update_plist_if_exists() {
    if [ -f "$PLIST_FILE" ]; then
        echo "📝 Updating Info.plist..."
        
        # Update CFBundleShortVersionString if VERSION is set
        if [ ! -z "$VERSION" ]; then
            /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString ${VERSION#v}" "$PLIST_FILE" 2>/dev/null || \
            /usr/libexec/PlistBuddy -c "Add :CFBundleShortVersionString string ${VERSION#v}" "$PLIST_FILE"
        fi
        
        # Update CFBundleVersion if BUILD_NUMBER is set
        if [ ! -z "$BUILD_NUMBER" ]; then
            /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $BUILD_NUMBER" "$PLIST_FILE" 2>/dev/null || \
            /usr/libexec/PlistBuddy -c "Add :CFBundleVersion string $BUILD_NUMBER" "$PLIST_FILE"
        fi
    else
        echo "ℹ️  Info.plist not found - using project.pbxproj settings"
    fi
}

# Function to clean build artifacts
clean_build() {
    echo "🧹 Cleaning build artifacts..."
    rm -rf build/
    rm -rf DerivedData/
    xcodebuild clean -project "$PROJECT_FILE" -scheme "$PROJECT_NAME" -configuration Release
}

# Function to validate project settings
validate_project() {
    echo "✅ Validating project settings..."
    
    # Check if project file exists
    if [ ! -f "$PROJECT_FILE/project.pbxproj" ]; then
        echo "❌ Error: Project file not found!"
        exit 1
    fi
    
    # Check if all source files exist
    local missing_files=0
    for swift_file in "${PROJECT_NAME}"/*.swift "${PROJECT_NAME}"/**/*.swift; do
        if [ -f "$swift_file" ]; then
            echo "✓ Found: $swift_file"
        else
            echo "⚠️  Missing: $swift_file"
            missing_files=$((missing_files + 1))
        fi
    done
    
    if [ $missing_files -gt 0 ]; then
        echo "⚠️  Warning: $missing_files source files not found"
    fi
    
    echo "✅ Project validation completed"
}

# Function to setup for CI
setup_ci() {
    echo "🚀 Setting up for CI environment..."
    
    # Disable automatic signing for CI
    sed -i '' 's/CODE_SIGN_STYLE = Automatic;/CODE_SIGN_STYLE = Manual;/g' "$PROJECT_FILE/project.pbxproj"
    
    # Set development team to empty for CI
    sed -i '' 's/DEVELOPMENT_TEAM = [^;]*/DEVELOPMENT_TEAM = "";/g' "$PROJECT_FILE/project.pbxproj"
    
    # Disable app sandbox for easier distribution
    sed -i '' 's/ENABLE_APP_SANDBOX = YES;/ENABLE_APP_SANDBOX = NO;/g' "$PROJECT_FILE/project.pbxproj"
    
    echo "✅ CI setup completed"
}

# Function to restore local development settings
restore_local() {
    echo "🔄 Restoring local development settings..."
    
    # Reset to automatic signing
    sed -i '' 's/CODE_SIGN_STYLE = Manual;/CODE_SIGN_STYLE = Automatic;/g' "$PROJECT_FILE/project.pbxproj"
    
    echo "✅ Local settings restored"
}

# Main execution
case "${1:-help}" in
    "clean")
        clean_build
        ;;
    "validate")
        validate_project
        ;;
    "ci")
        setup_ci
        update_plist_if_exists
        ;;
    "local")
        restore_local
        ;;
    "help"|*)
        echo "Usage: $0 {clean|validate|ci|local|help}"
        echo ""
        echo "Commands:"
        echo "  clean     - Clean build artifacts"
        echo "  validate  - Validate project structure"
        echo "  ci        - Setup for CI environment"
        echo "  local     - Restore local development settings"
        echo "  help      - Show this help message"
        echo ""
        echo "Environment variables:"
        echo "  VERSION      - App version (e.g., v1.0.0)"
        echo "  BUILD_NUMBER - Build number (e.g., 20231201123456)"
        ;;
esac

echo "🎉 Build configuration completed!"
