import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../zstandard/android_decompress.dart';
import '../zstandard/ios_decompress.dart';

class ZstdInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      if (response.headers.value('content-encoding') == 'zstd') {
        late Uint8List? result;

        if (Platform.isAndroid) {
          result = await androidDecompress(response.data);
        } else if (Platform.isIOS) {
          result = await iOSDecompress(response.data);
        } else {
          return;
        }

        var decodeData = utf8.decode(result ?? []);
        response.data = json.decode(decodeData);
      }
    } catch (e) {
      print('Failed Zstd Decompress: $e');
    }
    return handler.next(response);
  }
}
