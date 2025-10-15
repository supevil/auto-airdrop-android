package com.autoairdrop.app.utils

import android.app.Activity
import android.graphics.Bitmap
import android.graphics.PixelFormat
import android.hardware.display.DisplayManager
import android.hardware.display.VirtualDisplay
import android.media.Image
import android.media.ImageReader
import android.media.projection.MediaProjection
import android.util.DisplayMetrics
import android.util.Log
import android.view.WindowManager
import java.nio.ByteBuffer

class ScreenCapture {
    
    private var virtualDisplay: VirtualDisplay? = null
    private var imageReader: ImageReader? = null
    
    companion object {
        private const val TAG = "ScreenCapture"
    }
    
    fun captureScreen(mediaProjection: MediaProjection, activity: Activity): Bitmap? {
        return try {
            val windowManager = activity.getSystemService(Activity.WINDOW_SERVICE) as WindowManager
            val displayMetrics = DisplayMetrics()
            windowManager.defaultDisplay.getMetrics(displayMetrics)
            
            val width = displayMetrics.widthPixels
            val height = displayMetrics.heightPixels
            val density = displayMetrics.densityDpi
            
            // 创建ImageReader
            imageReader = ImageReader.newInstance(width, height, PixelFormat.RGBA_8888, 1)
            
            // 创建VirtualDisplay
            virtualDisplay = mediaProjection.createVirtualDisplay(
                "ScreenCapture",
                width, height, density,
                DisplayManager.VIRTUAL_DISPLAY_FLAG_AUTO_MIRROR,
                imageReader?.surface, null, null
            )
            
            // 等待一帧
            Thread.sleep(100)
            
            // 获取图像
            val image = imageReader?.acquireLatestImage()
            if (image != null) {
                val bitmap = imageToBitmap(image)
                image.close()
                bitmap
            } else {
                null
            }
            
        } catch (e: Exception) {
            Log.e(TAG, "截图失败", e)
            null
        } finally {
            // 清理资源
            virtualDisplay?.release()
            imageReader?.close()
        }
    }
    
    private fun imageToBitmap(image: Image): Bitmap {
        val planes = image.planes
        val buffer = planes[0].buffer
        val pixelStride = planes[0].pixelStride
        val rowStride = planes[0].rowStride
        val rowPadding = rowStride - pixelStride * image.width
        
        val bitmap = Bitmap.createBitmap(
            image.width + rowPadding / pixelStride,
            image.height,
            Bitmap.Config.ARGB_8888
        )
        bitmap.copyPixelsFromBuffer(buffer)
        
        return if (rowPadding == 0) {
            bitmap
        } else {
            Bitmap.createBitmap(bitmap, 0, 0, image.width, image.height)
        }
    }
}