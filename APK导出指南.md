# APK导出完整指南

## 🎯 当前状态
✅ Android Studio已启动
✅ 项目已导入
✅ JDK配置已解决

## 📱 导出APK的步骤

### 第一步：等待项目同步完成
1. **检查同步状态**：
   - 底部状态栏应该显示 "Gradle sync finished"
   - 如果没有错误提示，说明同步成功

2. **如果同步失败**：
   - 点击 "Try Again" 或 "Sync Now"
   - 等待同步完成

### 第二步：编译APK
1. **点击菜单**：
   - **Build** → **Build Bundle(s) / APK(s)** → **Build APK(s)**

2. **或者使用快捷键**：
   - 按 `Ctrl + F9`

3. **等待编译**：
   - 底部会显示编译进度
   - 通常需要2-5分钟

### 第三步：查看编译结果
1. **编译成功**：
   - 会弹出通知 "APK(s) generated successfully"
   - 点击通知中的 "locate" 查看APK文件

2. **APK文件位置**：
   ```
   G:\自动抢空投安卓\app\build\outputs\apk\debug\app-debug.apk
   ```

### 第四步：安装到雷电模拟器
1. **方法一 - 直接拖拽**：
   - 找到APK文件
   - 拖拽到雷电模拟器窗口
   - 等待安装完成

2. **方法二 - 使用ADB**：
   ```bash
   adb install app\build\outputs\apk\debug\app-debug.apk
   ```

## 🔧 如果编译失败

### 常见问题解决：
1. **Gradle同步失败**：
   - 点击 "Try Again"
   - 或 File → Invalidate Caches and Restart

2. **SDK组件缺失**：
   - 按照提示安装缺失的SDK组件
   - 或 File → Settings → Android SDK

3. **编译错误**：
   - 查看错误信息
   - 检查代码语法
   - 清理项目：Build → Clean Project

## 🚀 快速操作

### 一键编译：
1. 按 `Ctrl + F9`
2. 等待完成
3. 点击通知中的 "locate"

### 查看APK：
1. 在项目窗口中展开：`app` → `build` → `outputs` → `apk` → `debug`
2. 找到 `app-debug.apk` 文件

## 📱 测试APK

### 安装到雷电模拟器：
1. 打开雷电模拟器
2. 将APK文件拖拽到模拟器
3. 等待安装完成
4. 启动应用

### 配置权限：
1. **无障碍服务**：
   - 设置 → 辅助功能 → 自动抢空投 → 开启

2. **悬浮窗权限**：
   - 设置 → 应用 → 自动抢空投 → 权限 → 悬浮窗

## 🎉 完成！

导出APK后，你就可以：
1. 安装到任何Android设备
2. 分享给其他人使用
3. 进行功能测试

如果遇到任何问题，请告诉我具体的错误信息！
