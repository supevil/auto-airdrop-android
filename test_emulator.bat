@echo off
chcp 65001 >nul
echo ========================================
echo 自动抢空投 - 模拟器测试脚本
echo ========================================
echo.

echo [1/5] 检查ADB连接...
adb devices
if %errorlevel% neq 0 (
    echo ❌ ADB连接失败！请确保：
    echo    1. 已安装Android Studio或ADB工具
    echo    2. 模拟器已启动
    echo    3. ADB已添加到系统PATH
    echo.
    pause
    exit /b 1
)

echo ✅ ADB连接正常
echo.

echo [2/5] 清理项目...
call gradlew clean
if %errorlevel% neq 0 (
    echo ❌ 清理失败！
    pause
    exit /b 1
)

echo ✅ 项目清理完成
echo.

echo [3/5] 编译Debug版本...
call gradlew assembleDebug
if %errorlevel% neq 0 (
    echo ❌ 编译失败！请检查：
    echo    1. 网络连接是否正常
    echo    2. Gradle配置是否正确
    echo    3. 依赖是否完整
    echo.
    pause
    exit /b 1
)

echo ✅ 编译成功
echo.

echo [4/5] 卸载旧版本（如果存在）...
adb uninstall com.autoairdrop.app >nul 2>&1
echo ✅ 旧版本清理完成
echo.

echo [5/5] 安装APK到模拟器...
adb install app/build/outputs/apk/debug/app-debug.apk
if %errorlevel% neq 0 (
    echo ❌ 安装失败！请检查：
    echo    1. 模拟器是否正常运行
    echo    2. 存储空间是否充足
    echo    3. APK文件是否完整
    echo.
    pause
    exit /b 1
)

echo ✅ APK安装成功
echo.

echo ========================================
echo 🎉 安装完成！
echo ========================================
echo.
echo 📱 下一步操作：
echo    1. 在模拟器中找到"自动抢空投"应用
echo    2. 点击启动应用
echo    3. 开启无障碍服务权限
echo    4. 开始测试功能
echo.
echo 🔧 权限设置：
echo    设置 → 辅助功能 → 自动抢空投 → 开启
echo.
echo 📊 查看日志：
echo    adb logcat ^| findstr AutoAirdrop
echo.

echo 是否现在启动应用？(Y/N)
set /p choice=
if /i "%choice%"=="Y" (
    echo 启动应用...
    adb shell am start -n com.autoairdrop.app/.MainActivity
    echo ✅ 应用已启动
)

echo.
echo 测试完成！按任意键退出...
pause >nul
