@echo off
echo ========================================
echo 自动抢空投 Android APK 构建脚本
echo ========================================
echo.

echo [1/4] 清理项目...
call gradlew clean
if %errorlevel% neq 0 (
    echo 清理失败！
    pause
    exit /b 1
)

echo.
echo [2/4] 检查依赖...
call gradlew dependencies
if %errorlevel% neq 0 (
    echo 依赖检查失败！
    pause
    exit /b 1
)

echo.
echo [3/4] 编译Debug版本...
call gradlew assembleDebug
if %errorlevel% neq 0 (
    echo Debug编译失败！
    pause
    exit /b 1
)

echo.
echo [4/4] 编译Release版本...
call gradlew assembleRelease
if %errorlevel% neq 0 (
    echo Release编译失败！
    pause
    exit /b 1
)

echo.
echo ========================================
echo 构建完成！
echo ========================================
echo.
echo APK文件位置：
echo Debug版本:   app\build\outputs\apk\debug\app-debug.apk
echo Release版本: app\build\outputs\apk\release\app-release.apk
echo.
echo 安装命令：
echo adb install app\build\outputs\apk\release\app-release.apk
echo.
pause
