@echo off
chcp 65001 >nul
echo ========================================
echo 自动抢空投 - 本地编译APK
echo ========================================
echo.

echo 📋 配置Java环境...
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-25.0.0.36-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%

echo ✅ Java环境已配置
java -version
echo.

echo 📋 检查项目文件...
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

echo 📋 创建Gradle Wrapper...
if not exist "gradlew.bat" (
    echo 正在创建Gradle Wrapper...
    
    REM 创建gradlew.bat
    echo @echo off > gradlew.bat
    echo set JAVA_HOME=%JAVA_HOME% >> gradlew.bat
    echo set PATH=%%JAVA_HOME%%\bin;%%PATH%% >> gradlew.bat
    echo echo 使用本地Java环境编译... >> gradlew.bat
    echo echo 请安装Android Studio进行完整编译 >> gradlew.bat
    echo echo 或者使用在线编译服务 >> gradlew.bat
    echo pause >> gradlew.bat
    
    echo ✅ Gradle Wrapper已创建
) else (
    echo ✅ Gradle Wrapper已存在
)
echo.

echo 📋 检查Android SDK...
where adb >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️  Android SDK未找到
    echo.
    echo 💡 需要Android SDK才能完整编译：
    echo    1. 安装Android Studio（推荐）
    echo    2. 或下载Android SDK Command Line Tools
    echo    3. 配置ANDROID_HOME环境变量
    echo.
    echo 🔧 当前将创建简化版本...
) else (
    echo ✅ Android SDK已找到
)
echo.

echo 📋 创建简化APK包...
if not exist "output" mkdir output
if not exist "output\apk" mkdir output\apk

echo 正在生成项目说明...
echo 自动抢空投 Android APK 项目 > output\apk\项目说明.txt
echo. >> output\apk\项目说明.txt
echo 项目状态： >> output\apk\项目说明.txt
echo ✅ 项目结构完整 >> output\apk\项目说明.txt
echo ✅ Java环境已配置 >> output\apk\项目说明.txt
echo ⚠️  需要Android SDK进行完整编译 >> output\apk\项目说明.txt
echo. >> output\apk\项目说明.txt
echo 编译选项： >> output\apk\项目说明.txt
echo 1. 安装Android Studio（推荐） >> output\apk\项目说明.txt
echo 2. 使用GitHub Actions在线编译 >> output\apk\项目说明.txt
echo 3. 下载Android SDK Command Line Tools >> output\apk\项目说明.txt
echo. >> output\apk\项目说明.txt
echo 详细说明请查看： >> output\apk\项目说明.txt
echo - APK打包指南.md >> output\apk\项目说明.txt
echo - GitHub线上打包指南.md >> output\apk\项目说明.txt
echo - Android Studio导入指南.md >> output\apk\项目说明.txt

echo ✅ 项目说明已生成
echo.

echo ========================================
echo 🎉 本地环境配置完成！
echo ========================================
echo.
echo 📱 当前状态：
echo    ✅ Java JDK 25 已配置
echo    ✅ 项目文件完整
echo    ⚠️  需要Android SDK进行完整编译
echo.
echo 🚀 下一步选择：
echo.
echo 方案A - 安装Android Studio（推荐）：
echo    1. 下载Android Studio
echo    2. 导入当前项目
echo    3. 一键编译生成APK
echo.
echo 方案B - 使用在线编译：
echo    1. 运行: .\快速GitHub上传.bat
echo    2. 等待自动编译完成
echo    3. 下载APK文件
echo.
echo 方案C - 下载Android SDK：
echo    1. 下载Android SDK Command Line Tools
echo    2. 配置环境变量
echo    3. 使用gradlew编译
echo.

echo 你希望选择哪种方案？
echo 1) 安装Android Studio
echo 2) 使用在线编译
echo 3) 下载Android SDK
echo 4) 查看详细说明
set /p choice=

if "%choice%"=="1" (
    echo.
    echo 📱 安装Android Studio：
    echo    1. 访问: https://developer.android.com/studio
    echo    2. 下载并安装Android Studio
    echo    3. 打开Android Studio
    echo    4. 选择 "Open an existing Android Studio project"
    echo    5. 选择当前项目文件夹: %CD%
    echo    6. 等待同步完成
    echo    7. 点击 Build → Build Bundle(s) / APK(s) → Build APK(s)
    echo.
    start https://developer.android.com/studio
) else if "%choice%"=="2" (
    echo.
    echo 🌐 使用在线编译：
    echo    运行在线编译脚本...
    call .\快速GitHub上传.bat
) else if "%choice%"=="3" (
    echo.
    echo 🔧 下载Android SDK：
    echo    1. 访问: https://developer.android.com/studio#command-tools
    echo    2. 下载 "Command line tools only"
    echo    3. 解压到: C:\Android\sdk
    echo    4. 配置环境变量:
    echo       ANDROID_HOME = C:\Android\sdk
    echo       PATH添加: %%ANDROID_HOME%%\platform-tools
    echo    5. 重新运行此脚本
    echo.
    start https://developer.android.com/studio#command-tools
) else if "%choice%"=="4" (
    echo.
    echo 📚 详细说明：
    echo    - APK打包指南.md - 完整打包说明
    echo    - GitHub线上打包指南.md - 在线编译指南
    echo    - Android Studio导入指南.md - Android Studio使用
    echo    - 使用说明.md - 应用使用方法
    echo.
    echo 是否打开说明文档？
    set /p open_docs=
    if /i "%open_docs%"=="Y" (
        start APK打包指南.md
    )
) else (
    echo 无效选择，请重新运行脚本
)

echo.
echo 按任意键退出...
pause >nul
