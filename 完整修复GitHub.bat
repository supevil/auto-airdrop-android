@echo off
chcp 65001 >nul
echo ========================================
echo 完整修复GitHub上传问题
echo ========================================
echo.

echo 📋 问题分析：
echo    ❌ Git用户身份未配置
echo    ❌ GitHub仓库不存在
echo    ❌ 提交失败
echo.

echo 🔧 开始修复...
echo.

echo [1/6] 配置Git用户身份...
git config --global user.name "supevil"
git config --global user.email "supevil@example.com"
echo ✅ Git用户身份已配置
echo.

echo [2/6] 重新初始化Git仓库...
if exist ".git" rmdir /s /q ".git"
git init
echo ✅ Git仓库已重新初始化
echo.

echo [3/6] 添加所有文件...
git add .
echo ✅ 文件已添加到暂存区
echo.

echo [4/6] 提交文件...
git commit -m "Initial commit: AutoAirdrop Android project"
echo ✅ 文件已提交
echo.

echo [5/6] 设置主分支...
git branch -M main
echo ✅ 主分支已设置
echo.

echo [6/6] 配置远程仓库...
echo.
echo 📝 请先在GitHub上创建仓库：
echo    1. 访问: https://github.com/supevil
echo    2. 点击 "New repository"
echo    3. 仓库名: auto-airdrop-android
echo    4. 选择 "Public"
echo    5. 点击 "Create repository"
echo.

set /p REPO_NAME=仓库名称 (默认: auto-airdrop-android): 
if "%REPO_NAME%"=="" set REPO_NAME=auto-airdrop-android

echo.
echo 🔗 配置远程仓库: https://github.com/supevil/%REPO_NAME%.git
git remote remove origin 2>nul
git remote add origin https://github.com/supevil/%REPO_NAME%.git
echo ✅ 远程仓库已配置
echo.

echo 🚀 推送到GitHub...
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
    echo    仓库页面: https://github.com/supevil/%REPO_NAME%
    echo    Actions页面: https://github.com/supevil/%REPO_NAME%/actions
    echo.
    
    echo 是否现在打开Actions页面？
    set /p open_actions=
    if /i "%open_actions%"=="Y" (
        start https://github.com/supevil/%REPO_NAME%/actions
    )
    
) else (
    echo.
    echo ❌ 推送失败！
    echo.
    echo 💡 请确保：
    echo    1. GitHub仓库已创建: %REPO_NAME%
    echo    2. 仓库是公开的（Public）
    echo    3. 网络连接正常
    echo.
    echo 🔧 手动操作：
    echo    1. 在GitHub创建仓库: %REPO_NAME%
    echo    2. 重新运行此脚本
    echo    3. 或手动执行Git命令
    echo.
)

echo.
echo 按任意键退出...
pause >nul
