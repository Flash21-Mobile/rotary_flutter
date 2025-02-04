import 'package:zstandard_ios/zstandard_ios.dart';
import 'package:flutter/services.dart';

Future<Uint8List?> iOSDecompress(Uint8List? originalData) async {
  return await originalData?.decompress();
}