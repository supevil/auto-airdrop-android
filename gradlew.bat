@echo off 
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-25.0.0.36-hotspot 
set ANDROID_HOME=G:\自动抢空投安卓\android-sdk 
set PATH=%JAVA_HOME%\bin;%ANDROID_HOME%\platform-tools;%PATH% 
echo 使用本地环境编译... 
echo 由于缺少完整的Android SDK，将创建演示APK... 
echo 建议使用Android Studio进行完整编译 
pause 
