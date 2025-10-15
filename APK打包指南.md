# APK打包指南 - 使用雷电模拟器

## 🎯 环境准备

### 第一步：安装Java JDK
1. **下载Java JDK 8或11**
   - 访问：https://www.oracle.com/java/technologies/downloads/
   - 或者：https://adoptium.net/ (推荐，免费)
   - 下载Windows x64版本

2. **安装Java JDK**
   - 运行下载的安装程序
   - 记住安装路径（通常是：`C:\Program Files\Java\jdk-11.x.x`）

3. **配置环境变量**
   - 右键"此电脑" → "属性" → "高级系统设置"
   - 点击"环境变量"
   - 在"系统变量"中添加：
     - 变量名：`JAVA_HOME`
     - 变量值：`C:\Program Files\Java\jdk-11.x.x`（你的JDK安装路径）
   - 编辑"Path"变量，添加：`%JAVA_HOME%\bin`

4. **验证安装**
   ```cmd
   java -version
   javac -version
   ```

### 第二步：安装Android SDK
1. **下载Android SDK Command Line Tools**
   - 访问：https://developer.android.com/studio#command-tools
   - 下载"Command line tools only"
   - 解压到：`C:\Android\sdk`

2. **配置环境变量**
   - 添加系统变量：
     - 变量名：`ANDROID_HOME`
     - 变量值：`C:\Android\sdk`
   - 编辑"Path"变量，添加：
     - `%ANDROID_HOME%\platform-tools`
     - `%ANDROID_HOME%\tools`
     - `%ANDROID_HOME%\tools\bin`

3. **安装SDK组件**
   ```cmd
   sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3"
   ```

## 🚀 快速打包方案（推荐）

### 方案A：使用在线编译服务

1. **GitHub Actions（免费）**
   - 将项目上传到GitHub
   - 创建`.github/workflows/build.yml`文件
   - 自动编译生成APK

2. **GitLab CI/CD（免费）**
   - 将项目上传到GitLab
   - 配置CI/CD流水线
   - 自动编译生成APK

### 方案B：使用预编译APK

我可以为你创建一个简化版本，直接生成APK文件。

## 🔧 手动编译步骤

### 第一步：创建Gradle Wrapper
```cmd
# 在项目根目录执行
gradle wrapper --gradle-version 7.5
```

### 第二步：编译APK
```cmd
# 编译Debug版本
gradlew assembleDebug

# 编译Release版本
gradlew assembleRelease
```

### 第三步：查找APK文件
编译完成后，APK文件位置：
- Debug版本：`app\build\outputs\apk\debug\app-debug.apk`
- Release版本：`app\build\outputs\apk\release\app-release.apk`

## 📱 安装到雷电模拟器

### 方法一：拖拽安装
1. 找到编译好的APK文件
2. 直接拖拽到雷电模拟器窗口
3. 等待安装完成

### 方法二：使用ADB安装
1. **启用ADB调试**
   - 打开雷电模拟器
   - 点击设置 → 关于平板电脑
   - 连续点击"版本号"7次开启开发者选项
   - 返回设置 → 开发者选项 → 开启"USB调试"

2. **连接ADB**
   ```cmd
   adb connect 127.0.0.1:5555
   adb devices
   ```

3. **安装APK**
   ```cmd
   adb install app\build\outputs\apk\debug\app-debug.apk
   ```

## 🎯 简化方案：直接提供APK

由于环境配置比较复杂，我可以为你创建一个简化版本的项目，直接生成可用的APK文件。

### 创建简化版APK
1. 移除复杂的依赖
2. 使用基础的Android功能
3. 生成可直接安装的APK

## 📋 检查清单

### 环境检查
- [ ] Java JDK已安装
- [ ] Android SDK已安装
- [ ] 环境变量已配置
- [ ] Gradle可用

### 编译检查
- [ ] 项目结构完整
- [ ] 依赖配置正确
- [ ] 编译无错误
- [ ] APK文件生成

### 安装检查
- [ ] 雷电模拟器已启动
- [ ] ADB连接正常
- [ ] APK安装成功
- [ ] 应用可正常启动

## 🆘 遇到问题？

### 常见问题解决
1. **Java版本问题**
   - 确保使用JDK 8或11
   - 检查JAVA_HOME配置

2. **SDK问题**
   - 确保SDK路径正确
   - 检查平台工具版本

3. **编译错误**
   - 检查网络连接
   - 更新Gradle版本
   - 清理项目重新编译

4. **安装失败**
   - 检查模拟器状态
   - 确认APK文件完整
   - 重启模拟器

## 💡 建议

考虑到环境配置的复杂性，我建议：

1. **使用在线编译服务**（最简单）
2. **安装Android Studio**（最完整）
3. **使用预编译APK**（最快速）

你希望选择哪种方案？我可以为你提供具体的操作步骤。
