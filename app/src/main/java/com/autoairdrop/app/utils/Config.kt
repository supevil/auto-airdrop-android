package com.autoairdrop.app.utils

object Config {
    
    // 打码平台配置
    object CaptchaSolver {
        // 打码2平台
        const val DAMA2_API_KEY = "your_dama2_api_key"
        const val DAMA2_API_URL = "http://api.dama2.com:7766/d2"
        
        // 超级鹰平台
        const val CHAOJIYING_USERNAME = "your_username"
        const val CHAOJIYING_PASSWORD = "your_password"
        const val CHAOJIYING_SOFT_ID = "your_soft_id"
        const val CHAOJIYING_API_URL = "http://upload.chaojiying.net/Upload/Processing.php"
        
        // 验证码类型
        const val CAPTCHA_TYPE_CLICK = "9101" // 点击验证码
        const val CAPTCHA_TYPE_SLIDE = "9102" // 滑动验证码
    }
    
    // 自动化配置
    object Automation {
        const val SCREENSHOT_INTERVAL = 3000L // 截图间隔(毫秒)
        const val CLICK_DELAY_MIN = 50 // 最小点击延迟
        const val CLICK_DELAY_MAX = 150 // 最大点击延迟
        const val RANDOM_OFFSET = 10 // 随机偏移像素
        const val MAX_RETRY_COUNT = 3 // 最大重试次数
    }
    
    // 验证码区域配置 (需要根据实际应用调整)
    object CaptchaRegion {
        const val LEFT_RATIO = 0.2f // 左边界比例
        const val TOP_RATIO = 0.3f // 上边界比例
        const val RIGHT_RATIO = 0.8f // 右边界比例
        const val BOTTOM_RATIO = 0.5f // 下边界比例
    }
    
    // 日志配置
    object Logging {
        const val MAX_LOG_LINES = 1000 // 最大日志行数
        const val LOG_TAG = "AutoAirdrop"
    }
    
    // 权限配置
    object Permissions {
        const val REQUEST_CODE_SCREEN_CAPTURE = 1001
        const val REQUEST_CODE_OVERLAY_PERMISSION = 1002
        const val REQUEST_CODE_ACCESSIBILITY = 1003
    }
}
