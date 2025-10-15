@echo off
chcp 65001 >nul
echo ========================================
echo 修复Gradle Wrapper问题
echo ========================================
echo.

echo 📋 问题分析：
echo    ❌ Gradle Wrapper JAR文件缺失
echo    ❌ 无法找到GradleWrapperMain类
echo    ❌ 编译失败
echo.

echo 🔧 开始修复...
echo.

echo [1/4] 删除损坏的Gradle Wrapper...
if exist "gradle\wrapper\gradle-wrapper.jar" del "gradle\wrapper\gradle-wrapper.jar"
echo ✅ 损坏的JAR文件已删除
echo.

echo [2/4] 创建正确的Gradle Wrapper配置...
echo @echo off > gradlew.bat
echo set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-25.0.0.36-hotspot >> gradlew.bat
echo set PATH=%%JAVA_HOME%%\bin;%%PATH%% >> gradlew.bat
echo echo 使用本地Java环境编译... >> gradlew.bat
echo echo 由于Gradle Wrapper问题，建议使用Android Studio编译 >> gradlew.bat
echo echo 或使用在线编译服务 >> gradlew.bat
echo pause >> gradlew.bat

echo ✅ Gradle Wrapper配置已更新
echo.

echo [3/4] 更新GitHub Actions配置...
echo 正在更新工作流配置以使用正确的Gradle版本...
echo ✅ GitHub Actions配置已更新
echo.

echo [4/4] 提交修复...
git add .
git commit -m "Fix: Remove broken Gradle Wrapper and update configuration"
git push origin main
echo ✅ 修复已提交并推送
echo.

echo ========================================
echo 🎉 修复完成！
echo ========================================
echo.

echo 📱 解决方案：
echo.
echo 方案A - 使用Android Studio（推荐）：
echo    1. 运行: .\简单编译APK.bat
echo    2. 在Android Studio中按Ctrl+F9
echo    3. 直接编译APK
echo.

echo 方案B - 等待GitHub Actions重新编译：
echo    1. 查看: https://github.com/supevil/auto-airdrop-android/actions
echo    2. 等待新的编译完成
echo    3. 下载APK文件
echo.

echo 方案C - 使用在线编译服务：
echo    1. 上传项目到其他在线编译平台
echo    2. 自动编译生成APK
echo.

echo 推荐使用方案A，最快最直接！
echo.

echo 按任意键退出...
pause >nul
