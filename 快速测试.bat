@echo off
chcp 65001 >nul
echo ========================================
echo 自动抢空投 - 快速测试脚本
echo ========================================
echo.

echo 📋 测试前准备清单：
echo.
echo 1. 确保已安装以下工具：
echo    ✅ Android Studio (包含SDK和模拟器)
echo    ✅ Java JDK 8+
echo    ✅ ADB工具
echo.
echo 2. 启动Android模拟器：
echo    - 打开Android Studio
echo    - 点击 AVD Manager
echo    - 启动一个虚拟设备
echo.
echo 3. 验证ADB连接：
echo.

echo 正在检查ADB连接...
adb devices
if %errorlevel% neq 0 (
    echo.
    echo ❌ ADB未找到！请确保：
    echo    1. 已安装Android Studio
    echo    2. ADB已添加到系统PATH
    echo    3. 模拟器已启动
    echo.
    echo 💡 解决方案：
    echo    1. 安装Android Studio: https://developer.android.com/studio
    echo    2. 将以下路径添加到系统PATH:
    echo       C:\Users\%USERNAME%\AppData\Local\Android\Sdk\platform-tools
    echo.
    pause
    exit /b 1
)

echo ✅ ADB连接正常
echo.

echo 📱 当前连接的设备：
adb devices
echo.

echo 🔧 手动编译步骤：
echo.
echo 1. 打开Android Studio
echo 2. 选择 "Open an existing Android Studio project"
echo 3. 选择当前项目文件夹: %CD%
echo 4. 等待Gradle同步完成
echo 5. 点击 Build → Build Bundle(s) / APK(s) → Build APK(s)
echo 6. 等待编译完成
echo.

echo 📦 编译完成后，APK文件位置：
echo    app\build\outputs\apk\debug\app-debug.apk
echo.

echo 🚀 安装命令：
echo    adb install app\build\outputs\apk\debug\app-debug.apk
echo.

echo 是否现在尝试安装APK？(如果已编译完成)
set /p choice=
if /i "%choice%"=="Y" (
    if exist "app\build\outputs\apk\debug\app-debug.apk" (
        echo 正在安装APK...
        adb install -r app\build\outputs\apk\debug\app-debug.apk
        if %errorlevel% equ 0 (
            echo ✅ APK安装成功！
            echo.
            echo 📱 下一步：
            echo    1. 在模拟器中找到"自动抢空投"应用
            echo    2. 点击启动应用
            echo    3. 开启无障碍服务权限
            echo    4. 开始测试功能
            echo.
            echo 是否现在启动应用？
            set /p start_choice=
            if /i "%start_choice%"=="Y" (
                adb shell am start -n com.autoairdrop.app/.MainActivity
                echo ✅ 应用已启动
            )
        ) else (
            echo ❌ APK安装失败！
        )
    ) else (
        echo ❌ 未找到APK文件，请先编译项目
    )
)

echo.
echo 📚 更多帮助：
echo    - 查看 README.md 了解详细说明
echo    - 查看 模拟器测试指南.md 了解完整测试流程
echo    - 查看 使用说明.md 了解应用使用方法
echo.

echo 按任意键退出...
pause >nul
