import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

import 'package:flutter/services.dart';

class Log {
  static const _androidChannel =
      MethodChannel('com.flash21.rotary_3700/android');
  static const _appName = "Rotary3700";

  static void _log(
      String? tag, String level, String message, bool isSuper, String type) {
    if (kDebugMode) {
      final stack = StackTrace.current.toString().split('\n')[isSuper ? 3 : 2];

      final match = RegExp(r'(\S+\.dart):(\d+):\d+').firstMatch(stack);
      final location = match != null
          ? '${match.group(1)}:${match.group(2)}'
          : 'unknown location';

      if (Platform.isAndroid) {
        try {
          _androidChannel.invokeMethod(level, {
            'tag': '$_appName${tag != null ? '_$tag' : ''}',
            'message': '$message $location)'
          });
        } catch (e) {
          print('Error invoking method: $e');
        }
      }
      else {
        debugPrint('$_appName${tag != null ? '_$tag' : ''} [$type] $message $location)');
      }
    }
  }

  static void d(String message, {String? tag, bool isSuper = false}) {
    _log(tag, 'logd', message, isSuper, 'D');
  }

  static void e(String message, {String? tag, bool isSuper = false}) {
    _log(tag, 'loge', message, isSuper, 'E');
  }

  static void w(String message, {String? tag, bool isSuper = false}) {
    _log(tag, 'logw', message, isSuper, 'W');
  }

  static void wtf(String message, {String? tag, bool isSuper = false}) {
    _log(tag, 'logwtf', message, isSuper, 'WTF');
  }
}
