@echo off
chcp 65001 >nul
echo ========================================
echo 快速上传到GitHub进行线上编译
echo ========================================
echo.

echo 📋 这个脚本将帮你：
echo    1. 初始化Git仓库
echo    2. 上传项目到GitHub
echo    3. 自动触发线上编译
echo    4. 生成可下载的APK文件
echo.

echo 🔧 前提条件：
echo    ✅ 已安装Git（如果没有，请先安装）
echo    ✅ 有GitHub账户
echo    ✅ 已创建GitHub仓库
echo.

echo 是否继续？
set /p continue=
if /i not "%continue%"=="Y" (
    echo 已取消操作
    pause
    exit /b 0
)

echo.
echo [1/3] 初始化Git仓库...
if not exist ".git" (
    git init
    echo ✅ Git仓库已初始化
) else (
    echo ✅ Git仓库已存在
)

echo.
echo [2/3] 提交代码...
git add .
git commit -m "AutoAirdrop Android project - ready for build"
echo ✅ 代码已提交

echo.
echo [3/3] 配置远程仓库...
echo.
echo 📝 请提供GitHub仓库信息：
echo.
set /p GITHUB_USERNAME=GitHub用户名: 
set /p REPO_NAME=仓库名称 (默认: auto-airdrop-android): 

if "%REPO_NAME%"=="" set REPO_NAME=auto-airdrop-android

echo.
echo 🔗 配置远程仓库: https://github.com/%GITHUB_USERNAME%/%REPO_NAME%.git
git remote remove origin 2>nul
git remote add origin https://github.com/%GITHUB_USERNAME%/%REPO_NAME%.git

echo.
echo 🚀 上传到GitHub...
git branch -M main
git push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo 🎉 上传成功！开始自动编译...
    echo ========================================
    echo.
    echo 📱 接下来：
    echo    1. 等待5-10分钟自动编译完成
    echo    2. 访问Actions页面查看编译状态
    echo    3. 下载编译好的APK文件
    echo    4. 安装到雷电模拟器测试
    echo.
    echo 🔗 重要链接：
    echo    仓库页面: https://github.com/%GITHUB_USERNAME%/%REPO_NAME%
    echo    Actions页面: https://github.com/%GITHUB_USERNAME%/%REPO_NAME%/actions
    echo.
    
    echo 是否现在打开Actions页面？
    set /p open_actions=
    if /i "%open_actions%"=="Y" (
        start https://github.com/%GITHUB_USERNAME%/%REPO_NAME%/actions
    )
    
) else (
    echo.
    echo ❌ 上传失败！
    echo.
    echo 💡 请检查：
    echo    1. GitHub仓库是否已创建
    echo    2. 用户名和仓库名是否正确
    echo    3. 网络连接是否正常
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
