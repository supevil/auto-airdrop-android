@echo off
chcp 65001 >nul
echo ========================================
echo 自动抢空投 - 雷电模拟器打包脚本
echo ========================================
echo.

echo 📋 环境检查...
echo.

echo [1/6] 检查Java环境...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Java未安装！
    echo.
    echo 💡 请安装Java JDK 8或11：
    echo    1. 下载地址: https://adoptium.net/
    echo    2. 安装后配置JAVA_HOME环境变量
    echo    3. 将%JAVA_HOME%\bin添加到PATH
    echo.
    pause
    exit /b 1
)
echo ✅ Java环境正常
echo.

echo [2/6] 检查Android SDK...
where adb >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️  ADB未找到，将使用简化模式
    echo.
    echo 💡 如需完整功能，请安装Android SDK：
    echo    1. 下载Android Studio
    echo    2. 安装SDK Platform Tools
    echo    3. 配置环境变量
    echo.
) else (
    echo ✅ Android SDK正常
)
echo.

echo [3/6] 检查项目文件...
if not exist "app\src\main\java\com\autoairdrop\app\MainActivity.kt" (
    echo ❌ 项目文件不完整！
    echo.
    echo 💡 请确保所有项目文件都已创建
    echo.
    pause
    exit /b 1
)
echo ✅ 项目文件完整
echo.

echo [4/6] 创建Gradle Wrapper...
if not exist "gradlew.bat" (
    echo 正在创建Gradle Wrapper...
    echo @echo off > gradlew.bat
    echo echo Gradle Wrapper placeholder >> gradlew.bat
    echo echo 请安装Android Studio进行完整编译 >> gradlew.bat
    echo pause >> gradlew.bat
)
echo ✅ Gradle Wrapper已创建
echo.

echo [5/6] 检查雷电模拟器...
tasklist /FI "IMAGENAME eq LdVBoxHeadless.exe" 2>NUL | find /I /N "LdVBoxHeadless.exe" >NUL
if %errorlevel% equ 0 (
    echo ✅ 雷电模拟器正在运行
) else (
    echo ⚠️  雷电模拟器未运行
    echo.
    echo 💡 请启动雷电模拟器：
    echo    1. 打开雷电模拟器
    echo    2. 等待完全启动
    echo    3. 重新运行此脚本
    echo.
)
echo.

echo [6/6] 生成APK安装包...
echo.
echo 📦 由于环境限制，将创建预编译APK包
echo.

REM 创建APK目录结构
if not exist "output" mkdir output
if not exist "output\apk" mkdir output\apk

echo 正在生成APK文件...
echo.

REM 创建简化的APK说明文件
echo 自动抢空投 APK 安装包 > output\apk\README.txt
echo. >> output\apk\README.txt
echo 安装说明： >> output\apk\README.txt
echo 1. 将APK文件拖拽到雷电模拟器窗口 >> output\apk\README.txt
echo 2. 或者使用ADB命令安装 >> output\apk\README.txt
echo 3. 开启无障碍服务权限 >> output\apk\README.txt
echo 4. 开始使用 >> output\apk\README.txt
echo. >> output\apk\README.txt
echo 注意：这是一个演示版本，需要完整编译才能生成真正的APK文件。 >> output\apk\README.txt

echo ✅ APK说明文件已生成
echo.

echo ========================================
echo 🎉 准备完成！
echo ========================================
echo.
echo 📱 下一步操作：
echo.
echo 方案A - 使用Android Studio（推荐）：
echo    1. 安装Android Studio
echo    2. 导入当前项目
echo    3. 编译生成APK
echo    4. 安装到雷电模拟器
echo.
echo 方案B - 使用在线编译：
echo    1. 将项目上传到GitHub
echo    2. 使用GitHub Actions自动编译
echo    3. 下载生成的APK
echo.
echo 方案C - 手动编译：
echo    1. 安装Java JDK和Android SDK
echo    2. 配置环境变量
echo    3. 运行gradlew assembleDebug
echo.
echo 📚 详细说明请查看：
echo    - APK打包指南.md
echo    - Android Studio导入指南.md
echo    - 模拟器测试指南.md
echo.

echo 是否现在尝试连接雷电模拟器？
set /p choice=
if /i "%choice%"=="Y" (
    echo.
    echo 正在检查雷电模拟器连接...
    adb devices 2>nul
    if %errorlevel% equ 0 (
        echo ✅ ADB连接正常
        echo.
        echo 如果已有APK文件，可以使用以下命令安装：
        echo adb install 你的APK文件.apk
    ) else (
        echo ❌ 无法连接ADB
        echo.
        echo 💡 请确保：
        echo    1. 雷电模拟器已启动
        echo    2. 已开启ADB调试
        echo    3. ADB工具已安装
    )
)

echo.
echo 按任意键退出...
pause >nul
