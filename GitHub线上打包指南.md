# GitHub Actions 线上打包指南

## 🎯 使用GitHub Actions自动编译APK

### 第一步：创建GitHub仓库

1. **登录GitHub**
   - 访问：https://github.com
   - 登录你的账户

2. **创建新仓库**
   - 点击右上角的 "+" → "New repository"
   - 仓库名称：`auto-airdrop-android`
   - 选择 "Public"（公开，免费使用Actions）
   - 勾选 "Add a README file"
   - 点击 "Create repository"

### 第二步：上传项目代码

#### 方法A：使用Git命令（推荐）
```bash
# 在项目根目录执行
git init
git add .
git commit -m "Initial commit: AutoAirdrop Android project"
git branch -M main
git remote add origin https://github.com/你的用户名/auto-airdrop-android.git
git push -u origin main
```

#### 方法B：使用GitHub网页上传
1. 在GitHub仓库页面点击 "uploading an existing file"
2. 将整个项目文件夹拖拽到网页
3. 填写提交信息，点击 "Commit changes"

### 第三步：触发自动编译

1. **自动触发**
   - 每次推送代码到main分支时自动编译
   - 每次创建Pull Request时自动编译

2. **手动触发**
   - 进入仓库页面
   - 点击 "Actions" 标签
   - 选择 "Build Android APK" 工作流
   - 点击 "Run workflow" 按钮

### 第四步：下载APK

1. **查看编译状态**
   - 进入 "Actions" 页面
   - 点击最新的编译任务
   - 等待编译完成（绿色✓表示成功）

2. **下载APK文件**
   - 编译成功后，在页面底部找到 "Artifacts"
   - 点击 "app-debug-apk" 下载APK文件
   - 解压后得到 `app-debug.apk`

3. **自动发布（可选）**
   - 如果推送到main分支，会自动创建Release
   - 在 "Releases" 页面可以下载APK

## 🔧 配置说明

### 工作流文件说明
- **触发条件**：推送到main/master分支、PR、手动触发
- **运行环境**：Ubuntu最新版
- **Java版本**：JDK 11
- **编译命令**：`./gradlew assembleDebug`
- **输出文件**：`app-debug.apk`

### 自定义配置
你可以修改 `.github/workflows/build.yml` 文件：

```yaml
# 修改Java版本
java-version: '17'  # 或 '11', '21'

# 修改编译类型
run: ./gradlew assembleRelease  # 编译Release版本

# 添加签名（需要配置密钥）
# 在仓库Settings → Secrets中添加：
# KEYSTORE_PASSWORD
# KEY_ALIAS
# KEY_PASSWORD
```

## 📱 安装到雷电模拟器

### 方法一：直接拖拽
1. 下载APK文件到电脑
2. 打开雷电模拟器
3. 将APK文件拖拽到模拟器窗口
4. 等待安装完成

### 方法二：使用ADB
```bash
# 连接雷电模拟器
adb connect 127.0.0.1:5555

# 安装APK
adb install app-debug.apk
```

## 🎉 优势

### ✅ 优点
- **免费**：GitHub Actions免费额度足够使用
- **自动化**：代码推送后自动编译
- **跨平台**：不依赖本地环境
- **版本管理**：每次编译都有版本记录
- **分享方便**：可以直接分享APK下载链接

### ⚠️ 注意事项
- 需要公开仓库才能免费使用Actions
- 编译时间约5-10分钟
- 需要网络连接上传代码

## 🚀 快速开始

1. **5分钟设置**：
   - 创建GitHub仓库
   - 上传项目代码
   - 等待自动编译

2. **下载APK**：
   - 进入Actions页面
   - 下载编译好的APK
   - 安装到雷电模拟器

3. **开始测试**：
   - 开启无障碍服务
   - 配置打码平台API
   - 开始自动化测试

## 📞 遇到问题？

### 常见问题
1. **编译失败**：检查代码是否有语法错误
2. **权限问题**：确保仓库是公开的
3. **下载失败**：检查网络连接

### 获取帮助
- 查看Actions页面的错误日志
- 检查项目代码是否完整
- 确保所有依赖文件都已上传

---

按照这个指南，你就可以在5分钟内设置好线上自动编译，每次代码更新都会自动生成新的APK文件！
