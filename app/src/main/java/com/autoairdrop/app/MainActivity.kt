package com.autoairdrop.app

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.PixelFormat
import android.hardware.display.DisplayManager
import android.hardware.display.VirtualDisplay
import android.media.Image
import android.media.ImageReader
import android.media.projection.MediaProjection
import android.media.projection.MediaProjectionManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.util.Base64
import android.util.DisplayMetrics
import android.util.Log
import android.view.WindowManager
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.autoairdrop.app.databinding.ActivityMainBinding
import com.autoairdrop.app.service.AutoClickService
import com.autoairdrop.app.utils.CaptchaSolver
import com.autoairdrop.app.utils.ScreenCapture
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

class MainActivity : AppCompatActivity() {
    
    private lateinit var binding: ActivityMainBinding
    private var mediaProjection: MediaProjection? = null
    private var virtualDisplay: VirtualDisplay? = null
    private var imageReader: ImageReader? = null
    private val screenCapture = ScreenCapture()
    private val captchaSolver = CaptchaSolver()
    
    companion object {
        private const val REQUEST_CODE_SCREEN_CAPTURE = 1001
        private const val REQUEST_CODE_OVERLAY_PERMISSION = 1002
        private const val TAG = "AutoAirdrop"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        
        setupUI()
        checkPermissions()
    }
    
    private fun setupUI() {
        binding.btnStart.setOnClickListener {
            startAutomation()
        }
        
        binding.btnStop.setOnClickListener {
            stopAutomation()
        }
        
        binding.btnTestScreenshot.setOnClickListener {
            testScreenshot()
        }
        
        binding.btnSettings.setOnClickListener {
            openSettings()
        }
        
        binding.btnClearLog.setOnClickListener {
            binding.tvLog.text = "日志已清空\n"
        }
    }
    
    private fun checkPermissions() {
        // 检查悬浮窗权限
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (!Settings.canDrawOverlays(this)) {
                requestOverlayPermission()
            }
        }
        
        // 检查无障碍服务
        if (!isAccessibilityServiceEnabled()) {
            requestAccessibilityPermission()
        }
    }
    
    private fun requestOverlayPermission() {
        val intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION)
        intent.data = Uri.parse("package:$packageName")
        startActivityForResult(intent, REQUEST_CODE_OVERLAY_PERMISSION)
    }
    
    private fun requestAccessibilityPermission() {
        val intent = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
        startActivity(intent)
        Toast.makeText(this, "请开启无障碍服务权限", Toast.LENGTH_LONG).show()
    }
    
    private fun isAccessibilityServiceEnabled(): Boolean {
        val accessibilityEnabled = Settings.Secure.getInt(
            contentResolver,
            Settings.Secure.ACCESSIBILITY_ENABLED, 0
        )
        
        if (accessibilityEnabled == 1) {
            val settingValue = Settings.Secure.getString(
                contentResolver,
                Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES
            )
            return settingValue?.contains("$packageName/.service.AutoClickService") == true
        }
        return false
    }
    
    private fun startAutomation() {
        if (!isAccessibilityServiceEnabled()) {
            Toast.makeText(this, "请先开启无障碍服务", Toast.LENGTH_SHORT).show()
            return
        }
        
        binding.btnStart.isEnabled = false
        binding.btnStop.isEnabled = true
        
        addLog("🚀 开始自动化流程...")
        
        // 启动截图权限请求
        val mediaProjectionManager = getSystemService(Context.MEDIA_PROJECTION_SERVICE) as MediaProjectionManager
        val captureIntent = mediaProjectionManager.createScreenCaptureIntent()
        startActivityForResult(captureIntent, REQUEST_CODE_SCREEN_CAPTURE)
    }
    
    private fun stopAutomation() {
        binding.btnStart.isEnabled = true
        binding.btnStop.isEnabled = false
        
        mediaProjection?.stop()
        virtualDisplay?.release()
        imageReader?.close()
        
        addLog("⏹️ 自动化流程已停止")
    }
    
    private fun testScreenshot() {
        if (mediaProjection == null) {
            Toast.makeText(this, "请先启动自动化流程", Toast.LENGTH_SHORT).show()
            return
        }
        
        Thread {
            try {
                val bitmap = screenCapture.captureScreen(mediaProjection!!, this@MainActivity)
                if (bitmap != null) {
                    runOnUiThread {
                        addLog("📸 截图成功: ${bitmap.width}x${bitmap.height}")
                    }
                } else {
                    runOnUiThread {
                        addLog("❌ 截图失败")
                    }
                }
            } catch (e: Exception) {
                runOnUiThread {
                    addLog("❌ 截图异常: ${e.message}")
                }
            }
        }.start()
    }
    
    private fun openSettings() {
        val intent = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
        startActivity(intent)
    }
    
    private fun processCaptcha(bitmap: Bitmap) {
        Thread {
            try {
                runOnUiThread {
                    addLog("🔍 开始识别验证码...")
                }
                
                // 裁剪验证码区域 (这里需要根据实际应用调整坐标)
                val captchaBitmap = cropCaptchaRegion(bitmap)
                
                // 转换为Base64
                val base64Image = bitmapToBase64(captchaBitmap)
                
                // 上传到打码平台
                val coordinates = captchaSolver.solveCaptcha(base64Image)
                
                if (coordinates != null) {
                    runOnUiThread {
                        addLog("✅ 识别成功: ($coordinates)")
                    }
                    
                    // 转换为全局坐标并点击
                    val globalX = coordinates.first + 100 // 验证码区域起始X坐标
                    val globalY = coordinates.second + 200 // 验证码区域起始Y坐标
                    
                    // 添加随机偏移
                    val finalX = globalX + (-10..10).random()
                    val finalY = globalY + (-10..10).random()
                    
                    runOnUiThread {
                        addLog("🎯 点击坐标: ($finalX, $finalY)")
                    }
                    
                    // 通过无障碍服务执行点击
                    AutoClickService.performClick(finalX, finalY)
                    
                } else {
                    runOnUiThread {
                        addLog("❌ 验证码识别失败")
                    }
                }
                
            } catch (e: Exception) {
                runOnUiThread {
                    addLog("❌ 处理验证码异常: ${e.message}")
                }
            }
        }.start()
    }
    
    private fun cropCaptchaRegion(bitmap: Bitmap): Bitmap {
        // 这里需要根据实际应用的验证码位置调整
        // 示例：假设验证码在屏幕中央偏上位置
        val displayMetrics = DisplayMetrics()
        windowManager.defaultDisplay.getMetrics(displayMetrics)
        
        val screenWidth = displayMetrics.widthPixels
        val screenHeight = displayMetrics.heightPixels
        
        // 验证码区域 (需要根据实际情况调整)
        val left = (screenWidth * 0.2).toInt()
        val top = (screenHeight * 0.3).toInt()
        val right = (screenWidth * 0.8).toInt()
        val bottom = (screenHeight * 0.5).toInt()
        
        return Bitmap.createBitmap(bitmap, left, top, right - left, bottom - top)
    }
    
    private fun bitmapToBase64(bitmap: Bitmap): String {
        val outputStream = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, outputStream)
        val byteArray = outputStream.toByteArray()
        return Base64.encodeToString(byteArray, Base64.DEFAULT)
    }
    
    private fun addLog(message: String) {
        val timestamp = java.text.SimpleDateFormat("HH:mm:ss", java.util.Locale.getDefault())
            .format(java.util.Date())
        val logMessage = "[$timestamp] $message\n"
        binding.tvLog.append(logMessage)
        
        // 自动滚动到底部
        binding.scrollView.post {
            binding.scrollView.fullScroll(android.view.View.FOCUS_DOWN)
        }
    }
    
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        
        when (requestCode) {
            REQUEST_CODE_SCREEN_CAPTURE -> {
                if (resultCode == Activity.RESULT_OK && data != null) {
                    val mediaProjectionManager = getSystemService(Context.MEDIA_PROJECTION_SERVICE) as MediaProjectionManager
                    mediaProjection = mediaProjectionManager.getMediaProjection(resultCode, data)
                    
                    addLog("✅ 截图权限获取成功")
                    
                    // 开始自动化流程
                    startAutomationLoop()
                } else {
                    addLog("❌ 截图权限获取失败")
                    binding.btnStart.isEnabled = true
                    binding.btnStop.isEnabled = false
                }
            }
            
            REQUEST_CODE_OVERLAY_PERMISSION -> {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    if (Settings.canDrawOverlays(this)) {
                        addLog("✅ 悬浮窗权限获取成功")
                    } else {
                        addLog("❌ 悬浮窗权限获取失败")
                    }
                }
            }
        }
    }
    
    private fun startAutomationLoop() {
        Thread {
            while (binding.btnStop.isEnabled) {
                try {
                    val bitmap = screenCapture.captureScreen(mediaProjection!!, this@MainActivity)
                    if (bitmap != null) {
                        processCaptcha(bitmap)
                    }
                    
                    // 等待一段时间再继续
                    Thread.sleep(3000)
                    
                } catch (e: Exception) {
                    runOnUiThread {
                        addLog("❌ 自动化循环异常: ${e.message}")
                    }
                    break
                }
            }
        }.start()
    }
    
    override fun onDestroy() {
        super.onDestroy()
        mediaProjection?.stop()
        virtualDisplay?.release()
        imageReader?.close()
    }
}