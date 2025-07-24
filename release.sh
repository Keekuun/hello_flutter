#!/bin/bash

# Flutter 项目发布脚本
# 功能：选择发布平台、可选更新版本号、执行构建命令

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # 无颜色

# 检查是否在Flutter项目目录
if [ ! -f "pubspec.yaml" ]; then
    echo -e "${RED}错误：当前目录不是Flutter项目，请在项目根目录执行此脚本${NC}"
    exit 1
fi

# 获取当前版本号
current_version=$(grep 'version: ' pubspec.yaml | sed 's/version: //')
echo -e "当前版本号: ${YELLOW}$current_version${NC}"

# 询问是否需要更新版本号
echo -e "\n是否需要更新版本号？"
echo "1. 是的，更新版本号"
echo "2. 不需要，直接使用当前版本构建"
read -p "请选择 [1-2]: " update_choice

new_version=$current_version  # 默认使用当前版本

if [ $update_choice -eq 1 ]; then
    # 解析版本号
    IFS='+'; read -ra version_parts <<< "$current_version"
    base_version=${version_parts[0]}
    build_number=${version_parts[1]}

    # 询问版本更新方式
    echo -e "\n请选择版本更新方式："
    echo "1. 仅更新构建号 (${base_version}+${build_number} → ${base_version}+$((build_number + 1)))"
    echo "2. 更新补丁版本 (${base_version} → 增加最后一位数字)"
    echo "3. 更新次要版本 (${base_version} → 增加中间数字)"
    echo "4. 更新主要版本 (${base_version} → 增加第一位数字)"
    echo "5. 手动输入版本号"
    read -p "请选择 [1-5]: " version_choice

    # 根据选择计算新版本号
    case $version_choice in
        1)
            new_build=$((build_number + 1))
            new_version="${base_version}+${new_build}"
            ;;
        2)
            IFS='.'; read -ra base_parts <<< "$base_version"
            major=${base_parts[0]}
            minor=${base_parts[1]}
            patch=${base_parts[2]}
            new_patch=$((patch + 1))
            new_base="${major}.${minor}.${new_patch}"
            new_version="${new_base}+1"
            ;;
        3)
            IFS='.'; read -ra base_parts <<< "$base_version"
            major=${base_parts[0]}
            minor=${base_parts[1]}
            new_minor=$((minor + 1))
            new_base="${major}.${new_minor}.0"
            new_version="${new_base}+1"
            ;;
        4)
            IFS='.'; read -ra base_parts <<< "$base_version"
            major=${base_parts[0]}
            new_major=$((major + 1))
            new_base="${new_major}.0.0"
            new_version="${new_base}+1"
            ;;
        5)
            read -p "请输入新版本号 (格式: x.y.z+b): " new_version
            # 简单验证版本号格式
            if ! [[ $new_version =~ ^[0-9]+\.[0-9]+\.[0-9]+\+[0-9]+$ ]]; then
                echo -e "${RED}错误：版本号格式不正确，请使用 x.y.z+b 格式${NC}"
                exit 1
            fi
            ;;
        *)
            echo -e "${RED}错误：无效选择${NC}"
            exit 1
            ;;
    esac

    # 确认版本更新
    echo -e "\n即将更新版本号：${YELLOW}$current_version${NC} → ${GREEN}$new_version${NC}"
    read -p "确认更新? [y/n] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "已取消版本更新"
        exit 1
    fi

    # 更新pubspec.yaml中的版本号
    # 兼容不同系统的sed语法
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i.bak "s/version: .*/version: $new_version/" pubspec.yaml
    else
        # Linux/Windows (WSL)
        sed -i "s/version: .*/version: $new_version/" pubspec.yaml
    fi
    rm -f pubspec.yaml.bak # 删除备份文件
    echo -e "${GREEN}版本号已更新为: $new_version${NC}"
else
    echo -e "\n${YELLOW}将使用当前版本号构建: $current_version${NC}"
fi

# 选择发布平台
echo -e "\n请选择发布平台："
echo "1. Android (App Bundle)"
echo "2. Android (APK)"
echo "3. iOS (IPA)"
echo "4. macOS (应用)"
echo "5. Linux (应用)"
echo "6. Windows (应用)"
echo "7. Web (静态文件)"
echo "8. 全部平台 (根据当前系统)"
read -p "请选择 [1-8]: " platform_choice

# 执行flutter pub get
echo -e "\n${YELLOW}正在获取依赖...${NC}"
flutter pub get
if [ $? -ne 0 ]; then
    echo -e "${RED}获取依赖失败，请检查依赖配置${NC}"
    exit 1
fi

# 构建命令定义
build_android_appbundle() {
    echo -e "\n${YELLOW}正在构建Android App Bundle...${NC}"
    flutter build appbundle --release
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Android App Bundle构建成功！${NC}"
        echo -e "输出路径: ${YELLOW}build/app/outputs/bundle/release/app-release.aab${NC}"
    else
        echo -e "${RED}Android App Bundle构建失败${NC}"
        exit 1
    fi
}

build_android_apk() {
    echo -e "\n${YELLOW}正在构建Android APK...${NC}"
    flutter build apk --release
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Android APK构建成功！${NC}"
        echo -e "输出路径: ${YELLOW}build/app/outputs/flutter-apk/app-release.apk${NC}"
    else
        echo -e "${RED}Android APK构建失败${NC}"
        exit 1
    fi
}

build_ios() {
    echo -e "\n${YELLOW}正在构建iOS IPA...${NC}"
    # 确保在macOS环境
    if [ "$(uname -s)" != "Darwin" ]; then
        echo -e "${YELLOW}警告：iOS构建只能在macOS上进行，已跳过${NC}"
        return 1
    fi
    flutter build ipa --release
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}iOS IPA构建成功！${NC}"
        echo -e "输出路径: ${YELLOW}build/ios/ipa/*.ipa${NC}"
    else
        echo -e "${RED}iOS IPA构建失败${NC}"
        exit 1
    fi
}

build_macos() {
    echo -e "\n${YELLOW}正在构建macOS应用...${NC}"
    # 确保在macOS环境
    if [ "$(uname -s)" != "Darwin" ]; then
        echo -e "${YELLOW}警告：macOS构建只能在macOS上进行，已跳过${NC}"
        return 1
    fi
    flutter build macos --release
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}macOS应用构建成功！${NC}"
        echo -e "输出路径: ${YELLOW}build/macos/Build/Products/Release/${NC}"
    else
        echo -e "${RED}macOS应用构建失败${NC}"
        exit 1
    fi
}

build_linux() {
    echo -e "\n${YELLOW}正在构建Linux应用...${NC}"
    # 检查是否已安装Linux构建依赖
    if ! command -v cmake &> /dev/null || ! command -v ninja-build &> /dev/null; then
        echo -e "${YELLOW}警告：未检测到Linux构建依赖，已跳过${NC}"
        return 1
    fi
    flutter build linux --release
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Linux应用构建成功！${NC}"
        echo -e "输出路径: ${YELLOW}build/linux/x64/release/bundle/${NC}"
    else
        echo -e "${RED}Linux应用构建失败${NC}"
        exit 1
    fi
}

build_windows() {
    echo -e "\n${YELLOW}正在构建Windows应用...${NC}"
    # 确保在Windows环境(WSL或原生Windows)
    if [[ "$OSTYPE" != "msys" && "$OSTYPE" != "cygwin" && ! "$(uname -r)" =~ Microsoft$ ]]; then
        echo -e "${YELLOW}警告：Windows构建建议在Windows环境进行，已尝试构建${NC}"
    fi
    flutter build windows --release
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Windows应用构建成功！${NC}"
        echo -e "输出路径: ${YELLOW}build/windows/runner/Release/${NC}"
    else
        echo -e "${RED}Windows应用构建失败${NC}"
        exit 1
    fi
}

build_web() {
    echo -e "\n${YELLOW}正在构建Web应用...${NC}"
    flutter build web --release
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Web应用构建成功！${NC}"
        echo -e "输出路径: ${YELLOW}build/web/${NC}"
    else
        echo -e "${RED}Web应用构建失败${NC}"
        exit 1
    fi
}

# 根据选择执行构建
case $platform_choice in
    1)
        build_android_appbundle
        ;;
    2)
        build_android_apk
        ;;
    3)
        build_ios
        ;;
    4)
        build_macos
        ;;
    5)
        build_linux
        ;;
    6)
        build_windows
        ;;
    7)
        build_web
        ;;
    8)
        echo -e "\n${YELLOW}正在构建所有支持的平台...${NC}"
        build_android_appbundle
        build_android_apk
        build_ios
        build_macos
        build_linux
        build_windows
        build_web
        ;;
    *)
        echo -e "${RED}错误：无效选择${NC}"
        exit 1
        ;;
esac

echo -e "\n${GREEN}发布流程完成！${NC}"
