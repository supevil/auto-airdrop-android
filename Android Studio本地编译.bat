@echo off
chcp 65001 >nul
echo ========================================
echo 使用Android Studio本地编译APK
echo ========================================
echo.

echo 📋 检测到Android Studio路径：
echo    H:\空投相关\android-studio-2025.1.4.8-windows\android-studio
echo.

echo 📱 使用Android Studio编译步骤：
echo.
echo [1/4] 启动Android Studio
echo    1. 打开Android Studio
echo    2. 选择 "Open an existing Android Studio project"
echo    3. 选择项目文件夹: %CD%
echo    4. 等待Gradle同步完成
echo.

echo [2/4] 配置项目
echo    1. 如果提示更新Gradle，选择更新
echo    2. 如果提示安装SDK组件，选择安装
echo    3. 等待所有依赖下载完成
echo.

echo [3/4] 编译APK
echo    1. 点击菜单 Build → Build Bundle(s) / APK(s) → Build APK(s)
echo    2. 或者使用快捷键: Ctrl + F9
echo    3. 等待编译完成（约2-5分钟）
echo.

echo [4/4] 获取APK文件
echo    编译完成后，APK文件位置：
echo    app\build\outputs\apk\debug\app-debug.apk
echo.

echo 🚀 是否现在启动Android Studio？
set /p start_as=
if /i "%start_as%"=="Y" (
    echo 正在启动Android Studio...
    start "" "H:\空投相关\android-studio-2025.1.4.8-windows\android-studio\bin\studio64.exe"
    echo.
    echo ✅ Android Studio已启动
    echo.
    echo 📋 接下来请：
    echo    1. 选择 "Open an existing Android Studio project"
    echo    2. 选择当前项目文件夹: %CD%
    echo    3. 等待同步完成
    echo    4. 点击 Build → Build Bundle(s) / APK(s) → Build APK(s)
    echo.
) else (
    echo.
    echo 📚 手动启动Android Studio：
    echo    1. 打开文件夹: H:\空投相关\android-studio-2025.1.4.8-windows\android-studio
    echo    2. 运行: bin\studio64.exe
    echo    3. 按照上述步骤操作
    echo.
)

echo 📱 编译完成后安装到雷电模拟器：
echo.
echo 方法1 - 直接拖拽：
echo    1. 找到APK文件: app\build\outputs\apk\debug\app-debug.apk
echo    2. 拖拽到雷电模拟器窗口
echo    3. 等待安装完成
echo.

echo 方法2 - 使用ADB：
echo    1. 连接雷电模拟器: adb connect 127.0.0.1:5555
echo    2. 安装APK: adb install app\build\outputs\apk\debug\app-debug.apk
echo.

echo 🎯 测试应用：
echo    1. 在模拟器中找到"自动抢空投"应用
echo    2. 点击启动
echo    3. 开启无障碍服务权限
echo    4. 开始测试功能
echo.

echo 按任意键退出...
pause >nul
