package com.autoairdrop.app.service

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.GestureDescription
import android.graphics.Path
import android.util.Log
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo

class AutoClickService : AccessibilityService() {
    
    companion object {
        private const val TAG = "AutoClickService"
        private var instance: AutoClickService? = null
        
        fun performClick(x: Int, y: Int) {
            instance?.clickAt(x, y)
        }
        
        fun performSwipe(startX: Int, startY: Int, endX: Int, endY: Int, duration: Long = 500) {
            instance?.swipeFromTo(startX, startY, endX, endY, duration)
        }
    }
    
    override fun onServiceConnected() {
        super.onServiceConnected()
        instance = this
        Log.d(TAG, "无障碍服务已连接")
    }
    
    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        // 可以在这里监听特定的无障碍事件
    }
    
    override fun onInterrupt() {
        Log.d(TAG, "无障碍服务被中断")
        instance = null
    }
    
    override fun onDestroy() {
        super.onDestroy()
        instance = null
    }
    
    fun clickAt(x: Int, y: Int) {
        try {
            Log.d(TAG, "执行点击: ($x, $y)")
            
            // 创建点击手势
            val path = Path()
            path.moveTo(x.toFloat(), y.toFloat())
            
            val gestureBuilder = GestureDescription.Builder()
            gestureBuilder.addStroke(GestureDescription.StrokeDescription(path, 0, 100))
            
            val gesture = gestureBuilder.build()
            
            // 执行手势
            val success = dispatchGesture(gesture, object : GestureResultCallback() {
                override fun onCompleted(gestureDescription: GestureDescription?) {
                    Log.d(TAG, "点击手势执行完成")
                }
                
                override fun onCancelled(gestureDescription: GestureDescription?) {
                    Log.d(TAG, "点击手势被取消")
                }
            }, null)
            
            if (!success) {
                Log.e(TAG, "点击手势执行失败")
            }
            
        } catch (e: Exception) {
            Log.e(TAG, "点击执行异常", e)
        }
    }
    
    fun swipeFromTo(startX: Int, startY: Int, endX: Int, endY: Int, duration: Long = 500) {
        try {
            Log.d(TAG, "执行滑动: ($startX, $startY) -> ($endX, $endY)")
            
            val path = Path()
            path.moveTo(startX.toFloat(), startY.toFloat())
            path.lineTo(endX.toFloat(), endY.toFloat())
            
            val gestureBuilder = GestureDescription.Builder()
            gestureBuilder.addStroke(GestureDescription.StrokeDescription(path, 0, duration))
            
            val gesture = gestureBuilder.build()
            
            dispatchGesture(gesture, object : GestureResultCallback() {
                override fun onCompleted(gestureDescription: GestureDescription?) {
                    Log.d(TAG, "滑动手势执行完成")
                }
                
                override fun onCancelled(gestureDescription: GestureDescription?) {
                    Log.d(TAG, "滑动手势被取消")
                }
            }, null)
            
        } catch (e: Exception) {
            Log.e(TAG, "滑动执行异常", e)
        }
    }
    
    // 模拟人类点击轨迹
    fun performHumanLikeClick(x: Int, y: Int) {
        try {
            // 添加随机偏移
            val offsetX = (-5..5).random()
            val offsetY = (-5..5).random()
            val finalX = x + offsetX
            val finalY = y + offsetY
            
            // 模拟按下
            val pressPath = Path()
            pressPath.moveTo(finalX.toFloat(), finalY.toFloat())
            
            val pressGesture = GestureDescription.Builder()
                .addStroke(GestureDescription.StrokeDescription(pressPath, 0, 50))
                .build()
            
            dispatchGesture(pressGesture, null, null)
            
            // 短暂延迟
            Thread.sleep(50 + (0..30).random().toLong())
            
            // 模拟释放
            val releasePath = Path()
            releasePath.moveTo(finalX.toFloat(), finalY.toFloat())
            
            val releaseGesture = GestureDescription.Builder()
                .addStroke(GestureDescription.StrokeDescription(releasePath, 0, 50))
                .build()
            
            dispatchGesture(releaseGesture, null, null)
            
            Log.d(TAG, "人类化点击完成: ($finalX, $finalY)")
            
        } catch (e: Exception) {
            Log.e(TAG, "人类化点击异常", e)
        }
    }
    
    // 查找并点击特定文本
    fun clickByText(text: String): Boolean {
        return try {
            val rootNode = rootInActiveWindow
            if (rootNode != null) {
                val nodes = rootNode.findAccessibilityNodeInfosByText(text)
                if (nodes.isNotEmpty()) {
                    val node = nodes[0]
                    if (node.isClickable) {
                        node.performAction(AccessibilityNodeInfo.ACTION_CLICK)
                        Log.d(TAG, "通过文本点击成功: $text")
                        return true
                    }
                }
            }
            false
        } catch (e: Exception) {
            Log.e(TAG, "通过文本点击异常", e)
            false
        }
    }
}