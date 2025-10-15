@echo off
chcp 65001 >nul
echo ========================================
echo 简单编译APK - 使用Android Studio
echo ========================================
echo.

echo 📱 最简单的APK编译方法：
echo.

echo [1/3] 启动Android Studio
echo    - 正在启动Android Studio...
start "" "H:\空投相关\android-studio-2025.1.4.8-windows\android-studio\bin\studio64.exe" "%CD%"

echo ✅ Android Studio已启动
echo.

echo [2/3] 在Android Studio中操作
echo    1. 等待项目加载完成
echo    2. 如果提示JDK配置，选择 "Use Embedded JDK"
echo    3. 等待Gradle同步完成
echo    4. 按快捷键: Ctrl + F9
echo    5. 等待编译完成
echo.

echo [3/3] 获取APK文件
echo    编译成功后，APK文件位置：
echo    app\build\outputs\apk\debug\app-debug.apk
echo.

echo 🎯 这是最快的方法！
echo    不需要GitHub，不需要网络
echo    直接在本地编译APK
echo.

echo 按任意键退出...
pause >nul
