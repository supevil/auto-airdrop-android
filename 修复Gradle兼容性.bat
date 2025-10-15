@echo off
chcp 65001 >nul
echo ========================================
echo 修复Gradle和Java兼容性问题
echo ========================================
echo.

echo 📋 问题分析：
echo    ❌ Java版本: 25 (太新)
echo    ❌ Gradle版本: 7.5 (太旧)
echo    ❌ 不兼容
echo.

echo 🔧 解决方案：
echo    ✅ 已升级Gradle到8.5
echo    ✅ 已升级Android Gradle Plugin到8.1.4
echo    ✅ 已升级Kotlin到1.9.10
echo.

echo 📱 现在请执行以下操作：
echo.
echo [1/3] 在Android Studio中：
echo    1. 点击 "Sync Now" 或 "Try Again"
echo    2. 等待Gradle同步完成
echo    3. 如果还有错误，继续下一步
echo.

echo [2/3] 如果同步仍然失败：
echo    1. 点击 File → Invalidate Caches and Restart
echo    2. 选择 "Invalidate and Restart"
echo    3. 等待Android Studio重启
echo    4. 重新打开项目
echo.

echo [3/3] 如果仍有问题：
echo    1. 删除 .gradle 文件夹
echo    2. 删除 app/build 文件夹
echo    3. 重新同步项目
echo.

echo 🚀 同步成功后：
echo    1. 点击 Build → Build Bundle(s) / APK(s) → Build APK(s)
echo    2. 等待编译完成
echo    3. APK文件位置: app\build\outputs\apk\debug\app-debug.apk
echo.

echo 是否现在清理缓存文件夹？
set /p clean_cache=
if /i "%clean_cache%"=="Y" (
    echo.
    echo 🧹 正在清理缓存...
    if exist ".gradle" (
        rmdir /s /q ".gradle"
        echo ✅ 已删除 .gradle 文件夹
    )
    if exist "app\build" (
        rmdir /s /q "app\build"
        echo ✅ 已删除 app\build 文件夹
    )
    echo.
    echo ✅ 缓存清理完成
    echo.
    echo 📱 现在请：
    echo    1. 在Android Studio中点击 "Sync Now"
    echo    2. 等待同步完成
    echo    3. 开始编译APK
    echo.
)

echo.
echo 📚 如果还有问题，请查看：
echo    - Android Studio操作指南.md
echo    - 或告诉我具体的错误信息
echo.

echo 按任意键退出...
pause >nul
