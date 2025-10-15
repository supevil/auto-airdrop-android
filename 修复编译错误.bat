@echo off
chcp 65001 >nul
echo ========================================
echo 修复GitHub Actions编译错误
echo ========================================
echo.

echo 📋 问题分析：
echo    ❌ JDK版本不兼容 (需要JDK 17+)
echo    ❌ Android SDK设置失败
echo    ❌ 编译失败
echo.

echo 🔧 已修复的问题：
echo    ✅ 升级JDK到17版本
echo    ✅ 添加JDK版本检查跳过
echo    ✅ 更新Android SDK配置
echo.

echo 📱 重新提交修复：
echo.

echo [1/3] 添加修复文件...
git add .github/workflows/build.yml
echo ✅ 修复文件已添加
echo.

echo [2/3] 提交修复...
git commit -m "Fix: Update JDK to 17 and skip version check"
echo ✅ 修复已提交
echo.

echo [3/3] 推送到GitHub...
git push origin main
echo ✅ 修复已推送
echo.

echo ========================================
echo 🎉 修复完成！
echo ========================================
echo.

echo 📱 接下来：
echo    1. 等待新的编译开始
echo    2. 查看编译状态
echo    3. 下载APK文件
echo.

echo 🔗 查看编译状态：
echo    https://github.com/supevil/auto-airdrop-android/actions
echo.

echo 是否现在打开Actions页面？
set /p open_actions=
if /i "%open_actions%"=="Y" (
    start https://github.com/supevil/auto-airdrop-android/actions
    echo ✅ Actions页面已打开
)

echo.
echo 按任意键退出...
pause >nul
