import 'package:dio/dio.dart';
import 'package:rotary_flutter/util/logger.dart';
import 'package:zstandard/zstandard.dart';

class ZstdInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      final zstandard = Zstandard();

      Log.d('message: ${response.data}');

      final decompressedData = await zstandard.decompress(response.data);

      response.data = decompressedData;
    } catch (e) {
      print('Zstd Decompression Error: $e');
    }
    super.onResponse(response, handler);
  }
}
