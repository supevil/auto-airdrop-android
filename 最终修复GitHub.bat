@echo off
chcp 65001 >nul
echo ========================================
echo 最终修复GitHub上传问题
echo ========================================
echo.

echo 📋 问题分析：
echo    ❌ 仓库名称错误 (应该是 auto-airdrop-android)
echo    ❌ 网络连接问题
echo    ❌ 需要先创建GitHub仓库
echo.

echo 🔧 解决方案：
echo.

echo [1/4] 请先在GitHub上创建仓库：
echo    1. 访问: https://github.com/supevil
echo    2. 点击 "New repository" (绿色按钮)
echo    3. 仓库名: auto-airdrop-android
echo    4. 描述: AutoAirdrop Android APK Project
echo    5. 选择 "Public" (重要！)
echo    6. 不要勾选任何选项
echo    7. 点击 "Create repository"
echo.

echo [2/4] 修复远程仓库配置...
git remote remove origin 2>nul
git remote add origin https://github.com/supevil/auto-airdrop-android.git
echo ✅ 远程仓库已修复
echo.

echo [3/4] 检查网络连接...
ping github.com -n 1 >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ 网络连接正常
) else (
    echo ❌ 网络连接有问题
    echo 💡 请检查网络连接或使用VPN
)
echo.

echo [4/4] 推送到GitHub...
echo 🚀 正在推送...
git push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo 🎉 上传成功！
    echo ========================================
    echo.
    echo 📱 接下来：
    echo    1. 等待5-10分钟自动编译完成
    echo    2. 访问Actions页面查看编译状态
    echo    3. 下载编译好的APK文件
    echo.
    echo 🔗 重要链接：
    echo    仓库页面: https://github.com/supevil/auto-airdrop-android
    echo    Actions页面: https://github.com/supevil/auto-airdrop-android/actions
    echo.
    
    echo 是否现在打开Actions页面？
    set /p open_actions=
    if /i "%open_actions%"=="Y" (
        start https://github.com/supevil/auto-airdrop-android/actions
    )
    
) else (
    echo.
    echo ❌ 推送失败！
    echo.
    echo 💡 可能的原因：
    echo    1. GitHub仓库未创建
    echo    2. 仓库名称错误
    echo    3. 网络连接问题
    echo    4. 需要输入GitHub用户名和密码
    echo.
    echo 🔧 解决方案：
    echo    1. 确保已创建仓库: auto-airdrop-android
    echo    2. 检查网络连接
    echo    3. 重新运行此脚本
    echo    4. 或使用Android Studio编译
    echo.
)

echo.
echo 按任意键退出...
pause >nul
