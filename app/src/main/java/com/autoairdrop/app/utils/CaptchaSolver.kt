package com.autoairdrop.app.utils

import android.util.Log
import java.io.IOException
import java.net.HttpURLConnection
import java.net.URL
import java.net.URLEncoder

class CaptchaSolver {
    
    // 打码平台配置 (需要替换为实际的API信息)
    private val API_KEY = "your_api_key_here"
    private val API_URL = "http://api.dama2.com:7766/d2"
    
    companion object {
        private const val TAG = "CaptchaSolver"
    }
    
    fun solveCaptcha(base64Image: String): Pair<Int, Int>? {
        return try {
            Log.d(TAG, "开始上传验证码到打码平台...")
            
            // 构建请求参数
            val postData = buildPostData(base64Image)
            
            // 创建连接
            val url = URL(API_URL)
            val connection = url.openConnection() as HttpURLConnection
            
            // 设置请求属性
            connection.requestMethod = "POST"
            connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded")
            connection.setRequestProperty("Content-Length", postData.length.toString())
            connection.doOutput = true
            connection.doInput = true
            
            // 发送请求
            connection.outputStream.use { outputStream ->
                outputStream.write(postData.toByteArray())
            }
            
            // 读取响应
            val responseCode = connection.responseCode
            if (responseCode == HttpURLConnection.HTTP_OK) {
                val responseBody = connection.inputStream.bufferedReader().use { it.readText() }
                Log.d(TAG, "打码平台响应: $responseBody")
                
                return parseResponse(responseBody)
            } else {
                Log.e(TAG, "打码平台请求失败: $responseCode")
                return null
            }
            
        } catch (e: Exception) {
            Log.e(TAG, "打码平台请求异常", e)
            return null
        }
    }
    
    private fun buildPostData(base64Image: String): String {
        val params = mutableListOf<String>()
        params.add("key=${URLEncoder.encode(API_KEY, "UTF-8")}")
        params.add("method=upload")
        params.add("file=${URLEncoder.encode(base64Image, "UTF-8")}")
        params.add("type=1") // 1表示点击验证码
        
        return params.joinToString("&")
    }
    
    private fun parseResponse(responseBody: String?): Pair<Int, Int>? {
        if (responseBody.isNullOrEmpty()) {
            return null
        }
        
        try {
            // 简单的JSON解析（实际应用中建议使用JSON库）
            if (responseBody.contains("\"result\"")) {
                val resultStart = responseBody.indexOf("\"result\":\"") + 10
                val resultEnd = responseBody.indexOf("\"", resultStart)
                val result = responseBody.substring(resultStart, resultEnd)
                
                if (result.isNotEmpty()) {
                    // 解析坐标格式: "x,y" 或 "x,y|width,height"
                    val coordinates = result.split(",")
                    if (coordinates.size >= 2) {
                        val x = coordinates[0].toIntOrNull() ?: return null
                        val y = coordinates[1].toIntOrNull() ?: return null
                        return Pair(x, y)
                    }
                }
            }
            
            Log.e(TAG, "解析坐标失败: $responseBody")
            return null
            
        } catch (e: Exception) {
            Log.e(TAG, "解析响应异常", e)
            return null
        }
    }
    
    // 本地模拟识别（用于测试）
    fun solveCaptchaLocal(base64Image: String): Pair<Int, Int>? {
        return try {
            Log.d(TAG, "使用本地模拟识别验证码...")
            
            // 模拟识别结果 (实际应用中需要替换为真实的OCR逻辑)
            // 这里返回一个随机坐标作为示例
            val x = (50..300).random()
            val y = (50..200).random()
            
            Log.d(TAG, "本地识别结果: ($x, $y)")
            return Pair(x, y)
            
        } catch (e: Exception) {
            Log.e(TAG, "本地识别异常", e)
            return null
        }
    }
}