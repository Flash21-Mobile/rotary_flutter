import 'package:design_system/text/text_interface.dart';
import 'package:design_system/webview/webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: IndexTextMax('공지사항')),
      body: MMateWebView('http://rotary3700.or.kr/bsbbs/list?tn=notice'),
    );
  }
}
