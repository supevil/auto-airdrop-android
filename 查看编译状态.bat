@echo off
chcp 65001 >nul
echo ========================================
echo 查看GitHub Actions编译状态
echo ========================================
echo.

echo 📋 编译信息：
echo    ✅ 工作流已启动
echo    ✅ 提交ID: 341877b
echo    ✅ 提交者: supevil
echo    ✅ 工作流: Build Android APK #1
echo.

echo 📱 查看编译状态：
echo    1. 访问Actions页面: https://github.com/supevil/auto-airdrop-android/actions
echo    2. 点击 "Build Android APK #1"
echo    3. 查看编译进度
echo.

echo ⏰ 编译时间：
echo    - 通常需要5-10分钟
echo    - 请耐心等待
echo.

echo 🎯 编译状态说明：
echo    🟡 黄色圆圈 = 正在编译
echo    🟢 绿色✓ = 编译成功
echo    🔴 红色✗ = 编译失败
echo.

echo 📦 编译成功后下载APK：
echo    1. 点击编译成功的任务
echo    2. 滚动到页面底部
echo    3. 找到 "Artifacts" 部分
echo    4. 点击 "app-debug-apk"
echo    5. 下载ZIP文件
echo    6. 解压得到APK文件
echo.

echo 是否现在打开Actions页面？
set /p open_actions=
if /i "%open_actions%"=="Y" (
    start https://github.com/supevil/auto-airdrop-android/actions
    echo ✅ Actions页面已打开
)

echo.
echo 📚 详细说明请查看：
echo    - 下载APK指南.md
echo.

echo 按任意键退出...
pause >nul
