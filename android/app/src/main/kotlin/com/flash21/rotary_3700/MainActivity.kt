package com.flash21.rotary_3700

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.telephony.TelephonyManager
import android.util.Log
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.flash21.rotary_3700/android"
    private val PERMISSIONS_REQUEST_CODE = 22

    private lateinit var channel: MethodChannel

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getPhoneNumber" -> getPhoneNumber(result)
                "logd" -> {
                    val tag = call.argument<String>("tag") ?: "Flutter"
                    val message = call.argument<String>("message") ?: ""
                    Log.d(tag, message) // Android LogCat에 출력
                    result.success(null)
                }

                "loge" -> {
                    val tag = call.argument<String>("tag") ?: "Flutter"
                    val message = call.argument<String>("message") ?: ""
                    Log.e(tag, message) // Android LogCat에 출력
                    result.success(null)
                }

                "logw" -> {
                    val tag = call.argument<String>("tag") ?: "Flutter"
                    val message = call.argument<String>("message") ?: ""
                    Log.w(tag, message) // Android LogCat에 출력
                    result.success(null)
                }

                "logwtf" -> {
                    val tag = call.argument<String>("tag") ?: "Flutter"
                    val message = call.argument<String>("message") ?: ""
                    Log.wtf(tag, message) // Android LogCat에 출력
                    result.success(null)
                }

                "launchIntentForPackage" -> launchIntentForPackage(
                    result,
                    call.argument<String>("packageName") ?: "",
                    context
                )

                else -> result.notImplemented()
            }
        }
    }


    private fun getPhoneNumber(result: MethodChannel.Result) {
        val tm = getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

        if (ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.READ_PHONE_NUMBERS
            ) != PackageManager.PERMISSION_GRANTED &&
            ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.READ_PHONE_STATE
            ) != PackageManager.PERMISSION_GRANTED
        ) {

            // 권한 요청
            ActivityCompat.requestPermissions(
                this,
                arrayOf(
                    Manifest.permission.READ_PHONE_NUMBERS,
                    Manifest.permission.READ_PHONE_STATE
                ),
                PERMISSIONS_REQUEST_CODE
            )

            // 권한이 없을 경우
            result.error("PERMISSION_DENIED", "전화번호 권한이 필요합니다.", null)
            return
        }

        // 권한이 있을 경우 전화번호 가져오기
        val phoneNumber = tm.line1Number
        result.success(phoneNumber)
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == PERMISSIONS_REQUEST_CODE) {
            if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                // 권한이 승인된 경우 전화번호를 가져옵니다.
                val tm = getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
                val phoneNumber = tm.line1Number
                // Flutter로 전화번호 반환
                channel.invokeMethod("getPhoneNumberResult", phoneNumber)
            } else {
                // 권한 거부 시 처리
                Log.e("MainActivity", "전화번호 권한이 거부되었습니다.")
            }
        }
    }

    private fun launchIntentForPackage(
        result: MethodChannel.Result,
        packageName: String,
        context: Context
    ) {
        try {
            val intent = context.packageManager.getLaunchIntentForPackage(packageName)
            if (intent != null) {
                context.startActivity(intent)
                result.success(null)
            } else {
                result.error("CANNOT_OPEN", "Cannot open $packageName: Package not found", null)
            }
        } catch (e: Exception) {
            result.error("CANNOT_OPEN", "Cannot open $packageName: ${e.message}", null)
        }
    }
}

