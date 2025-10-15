# Android Studio 操作指南

## 🎯 当前状态
✅ Android Studio 已启动
✅ 项目文件完整
✅ Java环境已配置

## 📱 导入项目步骤

### 第一步：导入项目
1. **在Android Studio中**：
   - 选择 **"Open an existing Android Studio project"**
   - 浏览到项目文件夹：`G:\自动抢空投安卓`
   - 点击 **"OK"**

2. **等待同步**：
   - Android Studio会自动检测项目
   - 等待Gradle同步完成（可能需要几分钟）
   - 如果提示更新Gradle，选择 **"Update"**

### 第二步：安装SDK组件
如果提示缺少SDK组件：
1. 点击 **"Install missing SDK platform(s) and sync project"**
2. 或者手动安装：
   - **File** → **Settings** → **Appearance & Behavior** → **System Settings** → **Android SDK**
   - 安装以下组件：
     - Android SDK Platform 30-34
     - Android SDK Build-Tools
     - Android SDK Platform-Tools

### 第三步：编译APK
1. **编译Debug版本**：
   - 点击菜单 **Build** → **Build Bundle(s) / APK(s)** → **Build APK(s)**
   - 或者使用快捷键：`Ctrl + F9`

2. **等待编译完成**：
   - 编译过程约2-5分钟
   - 底部状态栏会显示进度
   - 编译成功后会显示通知

### 第四步：获取APK文件
编译完成后，APK文件位置：
```
app\build\outputs\apk\debug\app-debug.apk
```

## 📱 安装到雷电模拟器

### 方法一：直接拖拽（最简单）
1. 找到APK文件：`app\build\outputs\apk\debug\app-debug.apk`
2. 打开雷电模拟器
3. 将APK文件拖拽到模拟器窗口
4. 等待安装完成

### 方法二：使用ADB命令
1. **连接雷电模拟器**：
   ```bash
   adb connect 127.0.0.1:5555
   ```

2. **安装APK**：
   ```bash
   adb install app\build\outputs\apk\debug\app-debug.apk
   ```

## 🧪 测试应用

### 1. 启动应用
- 在雷电模拟器中找到 **"自动抢空投"** 应用
- 点击启动

### 2. 配置权限
- **无障碍服务**：
  - 设置 → 辅助功能 → 自动抢空投 → 开启
- **悬浮窗权限**：
  - 设置 → 应用 → 自动抢空投 → 权限 → 悬浮窗

### 3. 测试功能
- 点击 **"测试截图"** 按钮
- 点击 **"测试点击"** 按钮
- 观察日志输出

## 🔧 常见问题解决

### Q: Gradle同步失败
**解决方案：**
1. 检查网络连接
2. 点击 **File** → **Invalidate Caches and Restart**
3. 重新同步项目

### Q: SDK组件缺失
**解决方案：**
1. **File** → **Settings** → **Android SDK**
2. 安装缺失的SDK组件
3. 重新同步项目

### Q: 编译错误
**解决方案：**
1. 查看错误信息
2. 检查代码语法
3. 清理项目：**Build** → **Clean Project**
4. 重新编译

### Q: APK安装失败
**解决方案：**
1. 检查模拟器存储空间
2. 卸载旧版本应用
3. 重启模拟器

## 📊 编译状态检查

### 成功标志
- ✅ 底部状态栏显示 "Build completed successfully"
- ✅ 通知显示 "APK(s) generated successfully"
- ✅ 项目结构中没有红色错误标记

### 失败标志
- ❌ 底部状态栏显示错误信息
- ❌ 项目结构中有红色错误标记
- ❌ 编译过程中断

## 🎉 完成后的操作

1. **APK文件位置**：
   ```
   G:\自动抢空投安卓\app\build\outputs\apk\debug\app-debug.apk
   ```

2. **安装到模拟器**：
   - 拖拽APK到雷电模拟器
   - 或使用ADB命令安装

3. **开始测试**：
   - 启动应用
   - 配置权限
   - 测试功能

## 📞 需要帮助？

如果遇到问题：
1. 查看Android Studio底部的错误信息
2. 检查项目结构中的红色标记
3. 查看编译日志
4. 重启Android Studio

---

按照这个指南，你就可以成功编译出APK文件并安装到雷电模拟器进行测试了！
