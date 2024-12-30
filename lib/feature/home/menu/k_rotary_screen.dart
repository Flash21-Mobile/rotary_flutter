import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../util/global_color.dart';
import '../../home_provider.dart';

class KRotaryKoreaScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<KRotaryKoreaScreen> createState() => _KRotaryKoreaScreen();
}

class _KRotaryKoreaScreen extends ConsumerState<KRotaryKoreaScreen> {
  final androidUrl =Uri.parse('https://play.google.com/store/apps/details?id=com.project.rotarysystem');
  final iOSUrl = Uri.parse('https://apps.apple.com/kr/app/%EB%A1%9C%ED%83%80%EB%A6%AC%EC%BD%94%EB%A6%AC%EC%95%84/id6499181112');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColor.white,
        appBar: AppBar(
          title: Text('로타리 코리아 앱'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(HomeProvider).popCurrentWidget();
            },
          ),
        ),
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Platform.isAndroid
                ? InkWell(
                  onTap:()async{
                    if(await canLaunchUrl(androidUrl)){
                      await launchUrl(androidUrl);
                    }else {
                      Fluttertoast.showToast(msg: '플레이스토어를 설치해주세요');
                    }
                  },
                 child:Image.asset('asset/images/menu/k_rotary_android_image.png',width: double.infinity,))
                : InkWell(
                 onTap:()async{
                   if(await canLaunchUrl(iOSUrl)){
                     await launchUrl(iOSUrl);
                   }else {
                     Fluttertoast.showToast(msg: '앱 스토어를 열 수 없습니다');    //todo rotary:: 왜 안되냐...
                   }
                 },
                 child:Image.asset('asset/images/menu/k_rotary_ios_image.png',width: double.infinity,)
             ),
            IndexText('클릭 후 다운로드 화면으로 이동합니다.')
    ]));
  }
}