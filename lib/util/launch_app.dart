import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'logger.dart';

class Launch {
  static Future intentForPackage(String packageName) async {
    const androidChannel = MethodChannel('com.flash21.rotary_3700/android');
    try {
      var response =await androidChannel.invokeMethod('launchIntentForPackage',{'packageName' : packageName});
      Log.d('$response');
    } on PlatformException catch (e) {
      final androidUrl = Uri.parse('https://play.google.com/store/apps/details?id=$packageName');
      if (await canLaunchUrl(androidUrl)) launchUrl(androidUrl);
    }
  }
}