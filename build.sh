#!/bin/bash

echo "========================================"
echo "自动抢空投 Android APK 构建脚本"
echo "========================================"
echo

echo "[1/4] 清理项目..."
./gradlew clean
if [ $? -ne 0 ]; then
    echo "清理失败！"
    exit 1
fi

echo
echo "[2/4] 检查依赖..."
./gradlew dependencies
if [ $? -ne 0 ]; then
    echo "依赖检查失败！"
    exit 1
fi

echo
echo "[3/4] 编译Debug版本..."
./gradlew assembleDebug
if [ $? -ne 0 ]; then
    echo "Debug编译失败！"
    exit 1
fi

echo
echo "[4/4] 编译Release版本..."
./gradlew assembleRelease
if [ $? -ne 0 ]; then
    echo "Release编译失败！"
    exit 1
fi

echo
echo "========================================"
echo "构建完成！"
echo "========================================"
echo
echo "APK文件位置："
echo "Debug版本:   app/build/outputs/apk/debug/app-debug.apk"
echo "Release版本: app/build/outputs/apk/release/app-release.apk"
echo
echo "安装命令："
echo "adb install app/build/outputs/apk/release/app-release.apk"
echo
