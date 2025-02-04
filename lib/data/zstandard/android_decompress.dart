import 'package:zstandard_android/zstandard_android.dart';
import 'package:flutter/services.dart';

Future<Uint8List?> androidDecompress(Uint8List? originalData) async {
  return await originalData?.decompress();
}