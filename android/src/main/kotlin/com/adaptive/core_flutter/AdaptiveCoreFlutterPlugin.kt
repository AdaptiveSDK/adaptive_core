package com.adaptive.core_flutter

import android.content.Context
import android.os.Handler
import android.os.Looper
import com.adaptive.core.AdaptiveCore
import com.adaptive.core.AdaptiveUser
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch

/** Flutter plugin that bridges the Adaptive Core Android SDK. */
class AdaptiveCoreFlutterPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private val scope = CoroutineScope(Dispatchers.IO + SupervisorJob())
    private val mainHandler = Handler(Looper.getMainLooper())

    // ── FlutterPlugin ─────────────────────────────────────────────────────────

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "adaptive_core")
        channel.setMethodCallHandler(this)
        context = binding.applicationContext
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    // ── MethodCallHandler ─────────────────────────────────────────────────────

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {

            "initialize" -> {
                val clientId = call.argument<String>("clientId")
                    ?: return result.error("INVALID_ARGUMENT", "clientId is required", null)
                val debug = call.argument<Boolean>("debug") ?: false
                try {
                    AdaptiveCore.initialize(context, clientId, debug)
                    result.success(null)
                } catch (e: Exception) {
                    result.error("INITIALIZATION_ERROR", e.message, null)
                }
            }

            "login" -> {
                val userId = call.argument<String>("userId")
                    ?: return result.error("INVALID_ARGUMENT", "userId is required", null)
                val userName = call.argument<String>("userName")
                    ?: return result.error("INVALID_ARGUMENT", "userName is required", null)
                val userEmail = call.argument<String>("userEmail")
                    ?: return result.error("INVALID_ARGUMENT", "userEmail is required", null)
                try {
                    AdaptiveCore.login(
                        AdaptiveUser(
                            userName = userName,
                            userID = userId,
                            userEmail = userEmail,
                        )
                    )
                    result.success(null)
                } catch (e: Exception) {
                    result.error("LOGIN_ERROR", e.message, null)
                }
            }

            "logout" -> {
                try {
                    AdaptiveCore.logout()
                    result.success(null)
                } catch (e: Exception) {
                    result.error("LOGOUT_ERROR", e.message, null)
                }
            }

            "post" -> {
                val path = call.argument<String>("path")
                    ?: return result.error("INVALID_ARGUMENT", "path is required", null)
                val body = call.argument<String>("body")
                    ?: return result.error("INVALID_ARGUMENT", "body is required", null)
                scope.launch {
                    try {
                        AdaptiveCore.post(path, body)
                        mainHandler.post { result.success(null) }
                    } catch (e: Exception) {
                        mainHandler.post { result.error("POST_ERROR", e.message, null) }
                    }
                }
            }

            "get" -> {
                val path = call.argument<String>("path")
                    ?: return result.error("INVALID_ARGUMENT", "path is required", null)
                scope.launch {
                    try {
                        AdaptiveCore.get(path)
                        mainHandler.post { result.success(null) }
                    } catch (e: Exception) {
                        mainHandler.post { result.error("GET_ERROR", e.message, null) }
                    }
                }
            }

            else -> result.notImplemented()
        }
    }
}
