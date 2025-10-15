# 自动抢空投 Android APK

一个功能完整的Android自动化应用，可以实现截图、验证码识别、自动点击等功能。

## 🚀 功能特性

### ✅ 核心功能
- **截图权限管理**: 自动请求和管理Android 10+的截图权限
- **屏幕截图**: 实时截取屏幕内容
- **验证码识别**: 集成多个打码平台API
- **自动点击**: 通过无障碍服务实现精确点击
- **坐标转换**: 自动转换验证码坐标到屏幕坐标
- **随机偏移**: 添加±10px随机偏移防止检测

### ✅ 高级功能
- **多点识别**: 支持多个验证码点位的识别和点击
- **轨迹模拟**: 模拟人类点击轨迹，增加随机性
- **日志系统**: 完整的运行日志和状态显示
- **悬浮窗**: 显示服务运行状态
- **权限管理**: 自动检查和请求必要权限

## 📦 项目结构

```
app/
├── src/main/
│   ├── java/com/autoairdrop/app/
│   │   ├── MainActivity.kt              # 主界面
│   │   ├── service/
│   │   │   └── AutoClickService.kt      # 无障碍服务
│   │   └── utils/
│   │       ├── ScreenCapture.kt         # 截图工具
│   │       ├── CaptchaSolver.kt         # 验证码识别
│   │       ├── Config.kt                # 配置管理
│   │       └── LogUtils.kt              # 日志工具
│   ├── res/
│   │   ├── layout/                      # 界面布局
│   │   ├── drawable/                    # 图标和背景
│   │   ├── values/                      # 颜色、字符串等资源
│   │   └── xml/                         # 配置文件
│   └── AndroidManifest.xml              # 应用清单
├── build.gradle                         # 应用构建配置
└── proguard-rules.pro                   # 代码混淆规则
```

## 🛠️ 安装和使用

### 1. 编译APK
```bash
# 克隆项目
git clone <repository-url>
cd 自动抢空投安卓

# 编译APK
./gradlew assembleRelease
```

### 2. 安装应用
```bash
# 安装到设备
adb install app/build/outputs/apk/release/app-release.apk
```

### 3. 配置权限
1. **无障碍服务**: 设置 → 无障碍 → 自动抢空投 → 开启
2. **悬浮窗权限**: 设置 → 应用管理 → 自动抢空投 → 权限 → 悬浮窗
3. **截图权限**: 首次启动时会自动请求

### 4. 配置打码平台
在 `Config.kt` 中配置你的打码平台API信息：
```kotlin
object CaptchaSolver {
    const val DAMA2_API_KEY = "your_api_key_here"
    const val CHAOJIYING_USERNAME = "your_username"
    const val CHAOJIYING_PASSWORD = "your_password"
}
```

## ⚙️ 配置说明

### 验证码区域配置
在 `Config.kt` 中调整验证码识别区域：
```kotlin
object CaptchaRegion {
    const val LEFT_RATIO = 0.2f   // 左边界比例
    const val TOP_RATIO = 0.3f    // 上边界比例
    const val RIGHT_RATIO = 0.8f  // 右边界比例
    const val BOTTOM_RATIO = 0.5f // 下边界比例
}
```

### 自动化参数
```kotlin
object Automation {
    const val SCREENSHOT_INTERVAL = 3000L // 截图间隔
    const val CLICK_DELAY_MIN = 50        // 最小点击延迟
    const val CLICK_DELAY_MAX = 150       // 最大点击延迟
    const val RANDOM_OFFSET = 10          // 随机偏移像素
}
```

## 🔧 支持的打码平台

### 1. 打码2平台
- API地址: `http://api.dama2.com:7766/d2`
- 支持类型: 点击验证码、滑动验证码
- 配置: 需要API Key

### 2. 超级鹰平台
- API地址: `http://upload.chaojiying.net/Upload/Processing.php`
- 支持类型: 多种验证码类型
- 配置: 需要用户名、密码、软件ID

### 3. 本地OCR (扩展)
- 可集成Tesseract或ML Kit
- 适合离线使用场景

## 📱 界面说明

### 主界面功能
- **开始自动化**: 启动整个自动化流程
- **停止**: 停止当前运行的自动化
- **测试截图**: 测试截图功能是否正常
- **测试点击**: 测试点击功能是否正常
- **清空日志**: 清空运行日志
- **设置**: 跳转到无障碍设置页面

### 状态指示
- 🔴 红色圆点: 服务未启动
- 🟢 绿色圆点: 服务运行中
- 实时日志显示运行状态和错误信息

## ⚠️ 注意事项

### 权限要求
- **无障碍服务**: 必需，用于执行点击操作
- **悬浮窗权限**: 可选，用于显示状态
- **截图权限**: 必需，用于截取屏幕内容
- **网络权限**: 必需，用于上传验证码

### 使用限制
- 仅支持Android 5.0+ (API 21+)
- 需要手动开启无障碍服务
- 部分设备可能需要额外权限设置

### 安全提醒
- 请遵守相关法律法规
- 仅用于学习和研究目的
- 不要用于恶意用途

## 🐛 常见问题

### Q: 无障碍服务无法启动
A: 请检查是否已正确开启无障碍服务权限，并重启应用。

### Q: 截图失败
A: 请确保已授予截图权限，部分设备需要手动在设置中开启。

### Q: 验证码识别失败
A: 请检查网络连接和打码平台API配置是否正确。

### Q: 点击位置不准确
A: 请根据实际应用调整验证码区域配置参数。

## 📄 许可证

本项目仅供学习和研究使用，请勿用于商业用途。

## 🤝 贡献

欢迎提交Issue和Pull Request来改进这个项目。

---

**免责声明**: 本工具仅供学习和研究使用，使用者需自行承担使用风险，开发者不承担任何责任。
