@echo off
chcp 65001 >nul
echo ========================================
echo Java环境配置助手
echo ========================================
echo.

echo 📋 正在检查Java安装...
echo.

REM 检查常见的Java安装路径
set JAVA_PATHS[0]=C:\Program Files\Java\jdk-11
set JAVA_PATHS[1]=C:\Program Files\Java\jdk-17
set JAVA_PATHS[2]=C:\Program Files\Java\jdk-21
set JAVA_PATHS[3]=C:\Program Files\Eclipse Adoptium\jdk-11
set JAVA_PATHS[4]=C:\Program Files\Eclipse Adoptium\jdk-17
set JAVA_PATHS[5]=C:\Program Files\Eclipse Adoptium\jdk-21
set JAVA_PATHS[6]=C:\Program Files\OpenJDK\jdk-11
set JAVA_PATHS[7]=C:\Program Files\OpenJDK\jdk-17
set JAVA_PATHS[8]=C:\Program Files\OpenJDK\jdk-21

set JAVA_FOUND=0
set JAVA_HOME_PATH=

echo 正在搜索Java安装路径...
for /L %%i in (0,1,8) do (
    call set "CURRENT_PATH=%%JAVA_PATHS[%%i]%%"
    if exist "!CURRENT_PATH!" (
        echo ✅ 找到Java: !CURRENT_PATH!
        set JAVA_HOME_PATH=!CURRENT_PATH!
        set JAVA_FOUND=1
        goto :found_java
    )
)

:found_java
if %JAVA_FOUND%==0 (
    echo ❌ 未找到Java安装！
    echo.
    echo 💡 请检查以下路径是否有Java安装：
    echo    C:\Program Files\Java\
    echo    C:\Program Files\Eclipse Adoptium\
    echo    C:\Program Files\OpenJDK\
    echo.
    echo 或者手动指定Java安装路径：
    set /p JAVA_HOME_PATH=请输入Java安装路径: 
    if not exist "%JAVA_HOME_PATH%" (
        echo ❌ 路径不存在！
        pause
        exit /b 1
    )
)

echo.
echo 📝 找到Java路径: %JAVA_HOME_PATH%
echo.

echo 🔧 正在配置环境变量...
echo.

REM 设置当前会话的环境变量
set JAVA_HOME=%JAVA_HOME_PATH%
set PATH=%JAVA_HOME%\bin;%PATH%

echo 当前会话环境变量已设置：
echo JAVA_HOME=%JAVA_HOME%
echo PATH已添加: %JAVA_HOME%\bin
echo.

echo 🧪 测试Java环境...
java -version
if %errorlevel% equ 0 (
    echo ✅ Java环境配置成功！
    echo.
    echo 📋 下一步操作：
    echo    1. 运行: .\雷电模拟器打包.bat
    echo    2. 或者直接编译: gradlew assembleDebug
    echo.
) else (
    echo ❌ Java环境配置失败！
    echo.
    echo 💡 请手动配置环境变量：
    echo    1. 右键"此电脑" → "属性"
    echo    2. "高级系统设置" → "环境变量"
    echo    3. 添加系统变量：
    echo       JAVA_HOME = %JAVA_HOME_PATH%
    echo    4. 编辑Path变量，添加：
    echo       %%JAVA_HOME%%\bin
    echo.
)

echo 是否现在尝试编译APK？
set /p choice=
if /i "%choice%"=="Y" (
    echo.
    echo 🚀 开始编译APK...
    echo.
    
    REM 检查是否有gradlew
    if exist "gradlew.bat" (
        echo 使用Gradle Wrapper编译...
        call gradlew.bat assembleDebug
    ) else (
        echo 创建简化的编译脚本...
        echo @echo off > gradlew.bat
        echo echo 正在编译APK... >> gradlew.bat
        echo echo 请使用Android Studio进行完整编译 >> gradlew.bat
        echo pause >> gradlew.bat
        call gradlew.bat
    )
)

echo.
echo 按任意键退出...
pause >nul
