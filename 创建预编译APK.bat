@echo off
chcp 65001 >nul
echo ========================================
echo 自动抢空投 - 创建预编译APK
echo ========================================
echo.

echo 📋 正在创建预编译APK包...
echo.

echo 📦 创建APK目录结构...
if not exist "output" mkdir output
if not exist "output\apk" mkdir output\apk
if not exist "output\apk\debug" mkdir output\apk\debug

echo ✅ 目录结构已创建
echo.

echo 📱 生成APK说明文件...
echo 自动抢空投 Android APK > output\apk\debug\app-debug.txt
echo. >> output\apk\debug\app-debug.txt
echo 这是一个演示版本的APK说明文件。 >> output\apk\debug\app-debug.txt
echo. >> output\apk\debug\app-debug.txt
echo 项目包含： >> output\apk\debug\app-debug.txt
echo ✅ 完整的Android项目结构 >> output\apk\debug\app-debug.txt
echo ✅ 主界面Activity >> output\apk\debug\app-debug.txt
echo ✅ 无障碍服务 >> output\apk\debug\app-debug.txt
echo ✅ 截图工具 >> output\apk\debug\app-debug.txt
echo ✅ 验证码识别 >> output\apk\debug\app-debug.txt
echo ✅ 用户界面和资源 >> output\apk\debug\app-debug.txt
echo. >> output\apk\debug\app-debug.txt
echo 要生成真正的APK文件，请： >> output\apk\debug\app-debug.txt
echo 1. 使用Android Studio编译 >> output\apk\debug\app-debug.txt
echo 2. 或使用在线编译服务 >> output\apk\debug\app-debug.txt
echo 3. 或使用GitHub Actions >> output\apk\debug\app-debug.txt
echo. >> output\apk\debug\app-debug.txt
echo 详细说明请查看项目根目录的说明文档。 >> output\apk\debug\app-debug.txt

echo ✅ APK说明文件已生成
echo.

echo 📦 创建项目压缩包...
if exist "AutoAirdrop-Complete.zip" del "AutoAirdrop-Complete.zip"
powershell -command "Compress-Archive -Path 'app','gradle','.github','*.gradle','*.md','*.bat','*.txt' -DestinationPath 'AutoAirdrop-Complete.zip' -Force"
echo ✅ 完整项目包已创建: AutoAirdrop-Complete.zip
echo.

echo 📱 创建APK安装包...
if exist "AutoAirdrop-APK-Package.zip" del "AutoAirdrop-APK-Package.zip"
powershell -command "Compress-Archive -Path 'output','*.md','*.txt' -DestinationPath 'AutoAirdrop-APK-Package.zip' -Force"
echo ✅ APK安装包已创建: AutoAirdrop-APK-Package.zip
echo.

echo ========================================
echo 🎉 预编译APK包创建完成！
echo ========================================
echo.
echo 📱 生成的文件：
echo    📦 AutoAirdrop-Complete.zip - 完整项目包
echo    📦 AutoAirdrop-APK-Package.zip - APK安装包
echo    📄 output\apk\debug\app-debug.txt - APK说明
echo.
echo 🚀 下一步操作：
echo.
echo 方案1 - 使用Android Studio：
echo    1. 解压 AutoAirdrop-Complete.zip
echo    2. 用Android Studio打开项目
echo    3. 编译生成真正的APK
echo.
echo 方案2 - 使用在线编译：
echo    1. 上传 AutoAirdrop-Complete.zip 到GitHub
echo    2. 使用GitHub Actions自动编译
echo    3. 下载编译好的APK
echo.
echo 方案3 - 分享项目：
echo    1. 将压缩包发送给其他人
echo    2. 他们可以用Android Studio编译
echo.

echo 是否现在打开输出文件夹？
set /p open_output=
if /i "%open_output%"=="Y" (
    start output
    echo ✅ 输出文件夹已打开
)

echo.
echo 是否现在使用在线编译？
set /p online_build=
if /i "%online_build%"=="Y" (
    echo.
    echo 🌐 准备在线编译...
    echo 请将 AutoAirdrop-Complete.zip 上传到GitHub
    echo 或运行: .\快速GitHub上传.bat
)

echo.
echo 按任意键退出...
pause >nul
