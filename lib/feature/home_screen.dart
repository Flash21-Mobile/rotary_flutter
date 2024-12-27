import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import "package:permission_handler/permission_handler.dart";
import 'package:rotary_flutter/data/remoteData/account_remote_data.dart';
import 'package:rotary_flutter/feature/announcement/announcement_screen.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/feature/home/menu/index_screen.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/home_provider.dart';
import 'package:rotary_flutter/feature/myInfo/login_screen.dart';
import 'package:rotary_flutter/feature/myInfo/my_info_screen.dart';
import 'package:rotary_flutter/feature/userSearch/user_search_screen.dart';
import 'package:rotary_flutter/util/common/phone_input_formatter.dart';
import 'package:rotary_flutter/util/global_color.dart';
import 'package:rotary_flutter/util/logger.dart';
import 'package:rotary_flutter/util/model/state.dart';
import 'package:rotary_flutter/util/secure_storage.dart';

import '../data/model/account_model.dart';
import '../main.dart';
import '../util/fontSize.dart';
import 'home/home_main_screen.dart';
import 'myInfo/myInfoModify/my_info_modify_component.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreen();
}

late WidgetRef globalRef;

class _HomeScreen extends ConsumerState<HomeScreen> {
  int selectedIndex = 0;
  bool isLogin = false;

  late TextEditingController phoneController;
  late TextEditingController authenticateController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid)
      androidLogin();
    else if (Platform.isIOS) iOSLogin();

    globalRef = ref;

    phoneController = TextEditingController();
    authenticateController = TextEditingController();
  }

  Future<void> androidLogin() async {
    if (await Permission.phone.request().isGranted) {
      const androidChannel = MethodChannel('com.flash21.rotary_3700/android');
      try {
        final phone = await androidChannel.invokeMethod('getPhoneNumber');
        if (phone != null) {
          var dataState = await AccountAPI().getAccount(cellphone: phone);

          loadStateFunction(dataState,
              onSuccess: (data) {
                var result = (data as List<Account>)[0].name;
                Fluttertoast.showToast(msg: '${result}님 로그인에 성공하였습니다.');
                isLogin = true;
                globalStorage.write(key: 'phone', value: phone);
              },
              onError: (e) => showPhone(context));
        }
      } catch (e) {
        Fluttertoast.showToast(msg: '휴대폰 번호를 가져오는 중 오류가 발생했습니다.');
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      }
    }
  }

  void iOSLogin() async {
    if ((await globalStorage.read(key: 'phone')) == null)
      Future.delayed(Duration(milliseconds: 300))
          .then((onValue) => showPhone(context));
  }

  void showPhone(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            // BackKey 누르면 앱 종료
            if(ref.read(HomeProvider).phoneState is Success) {

            }else {
              ref.read(HomeProvider).popCurrentWidget();
            }
          },
          child: Dialog(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    height: 20,
                    'asset/images/main_logo.svg',
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyInfoModifyTextField(
                    indexTitle: '전화번호',
                    indexController: phoneController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      // FilteringTextInputFormatter.allow(
                      //   RegExp(r'^(010.*|.{0,2})$'), // 정규식 적용
                      // ),
                      PhoneInputFormatter()
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(mainAxisSize: MainAxisSize.max, children: [
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              if (phoneController.text.isNotEmpty) {
                                FocusNode().unfocus();
                                ref
                                    .read(HomeProvider)
                                    .postPhone(phoneController.text);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: GlobalColor.primaryColor,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              child: IndexTitle(
                                '문자 인증',
                                textColor: GlobalColor.white,
                              ),
                            )))
                  ]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showAuthenticate(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // 외부 클릭으로 다이얼로그 닫힘 방지
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return false;
          },
          child: Dialog(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    height: 20,
                    'asset/images/main_logo.svg',
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyInfoModifyTextField(
                    indexTitle: '인증번호',
                    indexController: authenticateController,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  Row(mainAxisSize: MainAxisSize.max, children: [
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              if (authenticateController.text.isNotEmpty) {
                                FocusNode().unfocus();
                                ref.read(HomeProvider).postAuthenticate(
                                    authenticateController.text);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: GlobalColor.primaryColor,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              child: IndexTitle(
                                '인증하기',
                                textColor: GlobalColor.white,
                              ),
                            )))
                  ]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var homeProvider = ref.watch(HomeProvider);

    loadStateFunction(homeProvider.phoneState, onSuccess: (data) {
      Future.delayed(Duration(milliseconds: 300)).then((onValue) {
        Navigator.of(context, rootNavigator: true).pop();
        showAuthenticate(context);

        homeProvider.phoneState = End();
      });
    });

    loadStateFunction(homeProvider.authenticateState, onSuccess: (data) {
      Future.delayed(Duration(milliseconds: 300)).then((onValue) {
        Navigator.of(context, rootNavigator: true).pop();

        homeProvider.authenticateState = End();
        globalStorage.write(key: 'phone', value: '01040502111');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text('인증 완료되었습니다'),
        ));
      });
    });

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(body: const IndexScreen());
  }
}
