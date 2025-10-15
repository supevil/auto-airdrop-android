package com.autoairdrop.app.utils

import android.util.Log
import java.text.SimpleDateFormat
import java.util.*

object LogUtils {
    
    private const val TAG = Config.Logging.LOG_TAG
    private val dateFormat = SimpleDateFormat("HH:mm:ss", Locale.getDefault())
    
    fun d(message: String) {
        Log.d(TAG, message)
    }
    
    fun i(message: String) {
        Log.i(TAG, message)
    }
    
    fun w(message: String) {
        Log.w(TAG, message)
    }
    
    fun e(message: String, throwable: Throwable? = null) {
        Log.e(TAG, message, throwable)
    }
    
    fun formatLogMessage(level: String, message: String): String {
        val timestamp = dateFormat.format(Date())
        return "[$timestamp] [$level] $message"
    }
    
    fun getLogLevelEmoji(level: String): String {
        return when (level.uppercase()) {
            "DEBUG" -> "🔍"
            "INFO" -> "ℹ️"
            "WARN" -> "⚠️"
            "ERROR" -> "❌"
            "SUCCESS" -> "✅"
            else -> "📝"
        }
    }
}
