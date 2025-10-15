@echo off
chcp 65001 >nul
echo ========================================
echo 自动抢空投 - 一键打包APK
echo ========================================
echo.

echo 📋 配置环境...
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-25.0.0.36-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%

echo ✅ Java环境已配置
echo.

echo 📋 检查Android Studio...
set ANDROID_STUDIO_PATH=H:\空投相关\android-studio-2025.1.4.8-windows\android-studio
if exist "%ANDROID_STUDIO_PATH%\bin\studio64.exe" (
    echo ✅ Android Studio已找到
) else (
    echo ❌ Android Studio未找到，请检查路径
    pause
    exit /b 1
)
echo.

echo 📋 启动Android Studio并自动编译...
echo.
echo 🚀 正在启动Android Studio...
start "" "%ANDROID_STUDIO_PATH%\bin\studio64.exe" "%CD%"

echo.
echo ⏳ 等待Android Studio启动...
timeout /t 10 /nobreak >nul

echo.
echo 📱 请按照以下步骤操作：
echo.
echo [1/4] 等待项目加载完成
echo    - Android Studio会自动打开项目
echo    - 等待Gradle同步完成
echo    - 如果提示JDK配置，选择 "Use Embedded JDK"
echo.

echo [2/4] 编译APK
echo    - 按快捷键: Ctrl + F9
echo    - 或点击菜单: Build → Build Bundle(s) / APK(s) → Build APK(s)
echo    - 等待编译完成（约2-5分钟）
echo.

echo [3/4] 获取APK文件
echo    - 编译成功后会弹出通知
echo    - 点击通知中的 "locate" 查看APK
echo    - APK文件位置: app\build\outputs\apk\debug\app-debug.apk
echo.

echo [4/4] 安装到雷电模拟器
echo    - 找到APK文件
echo    - 拖拽到雷电模拟器窗口
echo    - 等待安装完成
echo.

echo 🎯 自动化脚本已启动！
echo.
echo 📚 如果需要帮助，请查看：
echo    - APK导出指南.md
echo    - 解决JDK配置问题.md
echo.

echo 按任意键退出...
pause >nul
