@echo off
chcp 65001 >nul
echo ========================================
echo 自动抢空投 - 上传到GitHub进行线上编译
echo ========================================
echo.

echo 📋 准备上传项目到GitHub...
echo.

echo [1/4] 检查Git环境...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Git未安装！
    echo.
    echo 💡 请安装Git：
    echo    1. 下载地址: https://git-scm.com/download/win
    echo    2. 安装时选择默认选项
    echo    3. 重启命令行窗口
    echo.
    pause
    exit /b 1
)
echo ✅ Git环境正常
echo.

echo [2/4] 初始化Git仓库...
if not exist ".git" (
    git init
    echo ✅ Git仓库已初始化
) else (
    echo ✅ Git仓库已存在
)
echo.

echo [3/4] 添加文件到Git...
git add .
git commit -m "AutoAirdrop Android project - ready for online build"
echo ✅ 文件已提交到Git
echo.

echo [4/4] 配置远程仓库...
echo.
echo 📝 请先在GitHub上创建仓库：
echo    1. 访问: https://github.com
echo    2. 点击 "New repository"
echo    3. 仓库名: auto-airdrop-android
echo    4. 选择 "Public"
echo    5. 点击 "Create repository"
echo.

set /p GITHUB_USERNAME=请输入你的GitHub用户名: 
if "%GITHUB_USERNAME%"=="" (
    echo ❌ 用户名不能为空！
    pause
    exit /b 1
)

echo.
echo 🔗 正在配置远程仓库...
git remote remove origin 2>nul
git remote add origin https://github.com/%GITHUB_USERNAME%/auto-airdrop-android.git
echo ✅ 远程仓库已配置
echo.

echo 🚀 正在上传到GitHub...
git branch -M main
git push -u origin main
if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo 🎉 上传成功！
    echo ========================================
    echo.
    echo 📱 下一步操作：
    echo    1. 访问: https://github.com/%GITHUB_USERNAME%/auto-airdrop-android
    echo    2. 点击 "Actions" 标签
    echo    3. 等待自动编译完成（约5-10分钟）
    echo    4. 下载编译好的APK文件
    echo    5. 安装到雷电模拟器测试
    echo.
    echo 🔧 编译状态检查：
    echo    - 绿色✓表示编译成功
    echo    - 红色✗表示编译失败
    echo    - 点击编译任务查看详细日志
    echo.
    echo 📦 APK下载位置：
    echo    - Actions页面 → 最新编译 → Artifacts → app-debug-apk
    echo    - 或者 Releases页面直接下载
    echo.
    
    echo 是否现在打开GitHub仓库页面？
    set /p open_choice=
    if /i "%open_choice%"=="Y" (
        start https://github.com/%GITHUB_USERNAME%/auto-airdrop-android
    )
    
) else (
    echo.
    echo ❌ 上传失败！
    echo.
    echo 💡 可能的原因：
    echo    1. 网络连接问题
    echo    2. GitHub仓库不存在
    echo    3. 用户名或仓库名错误
    echo    4. 需要输入GitHub用户名和密码
    echo.
    echo 🔧 解决方案：
    echo    1. 检查网络连接
    echo    2. 确认GitHub仓库已创建
    echo    3. 重新运行此脚本
    echo    4. 或手动执行Git命令
    echo.
)

echo.
echo 📚 更多帮助：
echo    - 查看 GitHub线上打包指南.md
echo    - 查看 README.md 了解项目详情
echo    - 查看 使用说明.md 了解应用使用方法
echo.

echo 按任意键退出...
pause >nul
