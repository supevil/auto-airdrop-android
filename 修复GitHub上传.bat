@echo off
chcp 65001 >nul
echo ========================================
echo 修复GitHub上传问题
echo ========================================
echo.

echo 📋 问题分析：
echo    ❌ Git仓库未正确初始化
echo    ❌ 没有提交文件
echo    ❌ 无法推送到GitHub
echo.

echo 🔧 开始修复...
echo.

echo [1/5] 初始化Git仓库...
git init
echo ✅ Git仓库已初始化
echo.

echo [2/5] 添加所有文件...
git add .
echo ✅ 文件已添加到暂存区
echo.

echo [3/5] 提交文件...
git commit -m "Initial commit: AutoAirdrop Android project"
echo ✅ 文件已提交
echo.

echo [4/5] 设置主分支...
git branch -M main
echo ✅ 主分支已设置
echo.

echo [5/5] 配置远程仓库...
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
    echo ❌ 推送失败！
    echo.
    echo 💡 可能的原因：
    echo    1. GitHub仓库不存在
    echo    2. 用户名或仓库名错误
    echo    3. 需要输入GitHub用户名和密码
    echo    4. 网络连接问题
    echo.
    echo 🔧 解决方案：
    echo    1. 在GitHub上创建仓库: %REPO_NAME%
    echo    2. 确保仓库是公开的（Public）
    echo    3. 重新运行此脚本
    echo    4. 或手动执行Git命令
    echo.
)

echo.
echo 按任意键退出...
pause >nul
