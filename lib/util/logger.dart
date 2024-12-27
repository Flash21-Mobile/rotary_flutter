import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

import 'package:flutter/services.dart';

class Log {
  static const _androidChannel = MethodChannel('com.flash21.rotary_3700/android');
  static const _appName = "Rotary3700";

  static void _log(String level, String message,bool isSuper) {
    if (kDebugMode) {
      final stack = StackTrace.current.toString().split('\n')[isSuper ? 3:2];
      final match = RegExp(r'(\S+\.dart):(\d+):\d+').firstMatch(stack);
      final location = match != null ? '${match.group(1)}:${match.group(2)}' : 'unknown location';

      try {
        _androidChannel.invokeMethod(level, {'tag': _appName, 'message': '$message $location)'});
      } catch (e) {
        print('Error invoking method: $e');
      }
    }
  }

  static void d(String message,{String? tag,bool isSuper = false}) {
    _log('logd', message, isSuper);
  }

  static void e(String message, {String? tag,bool isSuper = false}) {
    _log('loge', message, isSuper);
  }

  static void w(String message, {String? tag,bool isSuper = false}) {
    _log('logw', message, isSuper);
  }

  static void wtf(String message, {String? tag,bool isSuper = false}) {
    _log('logwtf', message, isSuper);
  }
}


