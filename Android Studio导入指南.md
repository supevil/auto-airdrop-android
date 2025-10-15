# Android Studio 导入指南

## 🎯 使用Android Studio编译和测试

### 第一步：安装Android Studio

1. **下载Android Studio**
   - 访问：https://developer.android.com/studio
   - 下载最新版本
   - 安装时选择包含Android SDK和模拟器

2. **安装SDK组件**
   - 打开Android Studio
   - 选择 **Configure** → **SDK Manager**
   - 安装以下组件：
     - Android SDK Platform 30-34
     - Android SDK Build-Tools
     - Android SDK Platform-Tools
     - Android Emulator

### 第二步：导入项目

1. **打开项目**
   - 启动Android Studio
   - 选择 **Open an existing Android Studio project**
   - 选择项目文件夹：`G:\自动抢空投安卓`

2. **等待同步**
   - Android Studio会自动检测项目
   - 等待Gradle同步完成
   - 如果提示更新Gradle，选择更新

3. **检查配置**
   - 确保SDK版本正确
   - 检查依赖是否完整

### 第三步：创建模拟器

1. **打开AVD Manager**
   - 点击 **Tools** → **AVD Manager**
   - 或者点击工具栏的模拟器图标

2. **创建虚拟设备**
   - 点击 **Create Virtual Device**
   - 选择设备：**Pixel 4** 或 **Pixel 6**
   - 选择系统镜像：**API 30-34** (Android 11-14)
   - 点击 **Next** → **Finish**

3. **启动模拟器**
   - 在AVD Manager中点击 **▶️** 启动
   - 等待模拟器完全启动

### 第四步：编译APK

1. **编译Debug版本**
   - 点击 **Build** → **Build Bundle(s) / APK(s)** → **Build APK(s)**
   - 或者使用快捷键：`Ctrl + F9`

2. **查看编译结果**
   - 编译完成后会显示通知
   - APK文件位置：`app/build/outputs/apk/debug/app-debug.apk`

3. **编译Release版本**（可选）
   - 点击 **Build** → **Generate Signed Bundle / APK**
   - 选择 **APK** → **Next**
   - 创建新的密钥库或使用现有密钥库

### 第五步：安装到模拟器

#### 方法一：通过Android Studio安装
1. 确保模拟器已启动
2. 点击 **Run** → **Run 'app'**
3. 选择目标设备（模拟器）
4. 应用会自动安装并启动

#### 方法二：通过ADB命令安装
1. 打开终端（Terminal）
2. 执行命令：
   ```bash
   adb install app/build/outputs/apk/debug/app-debug.apk
   ```

### 第六步：测试应用

1. **启动应用**
   - 在模拟器中找到 **自动抢空投** 应用
   - 点击启动

2. **配置权限**
   - **无障碍服务**：
     - 设置 → 辅助功能 → 自动抢空投 → 开启
   - **悬浮窗权限**：
     - 设置 → 应用 → 自动抢空投 → 权限 → 悬浮窗

3. **测试功能**
   - 点击 **测试截图** 按钮
   - 点击 **测试点击** 按钮
   - 观察日志输出

## 🔧 常见问题解决

### Q: Gradle同步失败
**解决方案：**
1. 检查网络连接
2. 更新Gradle版本
3. 清理项目：**Build** → **Clean Project**
4. 重新同步：**File** → **Sync Project with Gradle Files**

### Q: 模拟器启动失败
**解决方案：**
1. 检查系统虚拟化是否开启
2. 增加模拟器内存分配
3. 尝试不同的系统镜像
4. 重启Android Studio

### Q: 应用安装失败
**解决方案：**
1. 检查模拟器存储空间
2. 卸载旧版本应用
3. 重启模拟器
4. 检查APK文件完整性

### Q: 权限无法开启
**解决方案：**
1. 确保模拟器系统版本支持
2. 重启模拟器
3. 检查应用是否正确安装
4. 手动在设置中开启权限

## 📊 测试检查清单

### 基础功能测试
- [ ] 应用正常启动
- [ ] 界面显示正常
- [ ] 按钮点击响应
- [ ] 日志显示正常

### 权限测试
- [ ] 无障碍服务可以开启
- [ ] 截图权限可以获取
- [ ] 悬浮窗权限可以开启

### 功能测试
- [ ] 截图功能正常
- [ ] 点击功能正常
- [ ] 日志记录正常
- [ ] 状态指示正常

## 🚀 快速测试命令

在Android Studio的Terminal中执行：

```bash
# 检查设备连接
adb devices

# 安装APK
adb install app/build/outputs/apk/debug/app-debug.apk

# 启动应用
adb shell am start -n com.autoairdrop.app/.MainActivity

# 查看日志
adb logcat | findstr AutoAirdrop

# 卸载应用
adb uninstall com.autoairdrop.app
```

## 📱 模拟器推荐配置

### 推荐设备配置
- **设备**: Pixel 4 或 Pixel 6
- **系统**: Android 11 (API 30) 或更高
- **内存**: 4GB RAM
- **存储**: 8GB 内部存储

### 性能优化
- 开启硬件加速
- 分配足够的内存
- 使用x86_64系统镜像
- 关闭不必要的后台应用

## 📝 测试报告模板

```
测试环境：
- Android Studio版本: 2023.1.1
- 模拟器: Pixel 4 API 30
- 系统版本: Android 11
- 测试时间: 2024-01-01

测试结果：
✅ 项目导入成功
✅ 编译无错误
✅ 应用安装成功
✅ 界面显示正常
✅ 无障碍服务可开启
✅ 截图功能正常
❌ 网络连接失败（需要配置打码平台）

问题记录：
1. 需要配置真实的打码平台API
2. 验证码区域需要根据实际应用调整
3. 部分权限在模拟器中表现不同

建议：
1. 在真机上测试最终功能
2. 配置真实的打码平台API
3. 根据目标应用调整参数
```

---

按照这个指南，你就可以在Android Studio中完整地编译、安装和测试自动抢空投APK了！
