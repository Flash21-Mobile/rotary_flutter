import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:permission_handler/permission_handler.dart";
import 'package:rotary_flutter/data/remoteData/account_remote_data.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/home_view_model.dart';
import 'package:rotary_flutter/feature/myInfo/my_info_screen.dart';
import 'package:rotary_flutter/util/common/phone_input_formatter.dart';
import 'package:rotary_flutter/util/global_color.dart';
import 'package:rotary_flutter/util/logger.dart';
import 'package:rotary_flutter/util/model/loadstate.dart';
import 'package:rotary_flutter/util/secure_storage.dart';
import '../data/model/account_model.dart';
import 'home/home_main_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends ConsumerState<HomeScreen> {
  int selectedIndex = 0;
  bool isLogin = false;

  late TextEditingController phoneController;
  late TextEditingController authenticateController;
  late TextEditingController idController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      androidLogin();
    } else if (Platform.isIOS) {
      iOSLogin();
    }

    phoneController = TextEditingController();
    authenticateController = TextEditingController();
    idController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> androidLogin() async {
    if (await Permission.phone
        .request()
        .isGranted) {
      const androidChannel = MethodChannel('com.flash21.rotary_3700/android');
      try {
        var phone = await androidChannel.invokeMethod('getPhoneNumber');

        if (phone != null) {
          phone as String;

          phone = phone.replaceAll('+82', '0');

          //todo r: 검색 문구 변경, 전체 회원수 추가, 전체 회원수 위치 변경 상단으로

          final indexPhone = '${phone.substring(0, 3)}-${phone.substring(
              3, 7)}-${phone.substring(7)}';
          login(indexPhone);
        }
      } catch (e) {
        showLoginDialog();
      }
    } else {
      //todo r: 궈한 거부
      showErrorDialog();
    }
  }

  void iOSLogin() async {
    // if ((await globalStorage.read(key: 'phone')) == null) {    //todo r: 수정하기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showPhoneDialog();
    });
    // }
  }

  void login(String phone) async {
    var dataState = await AccountAPI().getAccount(cellphone: phone);

    loadStateFunction(dataState,
        onSuccess: (data) async {
          var result = (data as List<Account>)[0];
          Fluttertoast.showToast(msg: '${result.name}님 로그인에 성공하였습니다.');

          if (result.permission == true) {
            globalStorage.write(key: 'admin', value: 'admin');
          } else {
            globalStorage.write(key: 'admin', value: null);
          }
          Log.d(
              'i am permission: ${result.permission} ${await globalStorage.read(
                  key: 'admin')}');

          isLogin = true;
          globalStorage.write(key: 'phone', value: phone);
        },
        onError: (e) => showLoginDialog());
  }

  void showPhoneDialog() {
    var homeProvider = ref.read(HomeProvider);

    showDismissDialog(context,
        onPopInvokedWithResult: (didPop, result) {
          if (homeProvider.phoneState is! Success) {
            homeProvider.popCurrentWidget();
          }
        },
        controller: phoneController,
        textInputFormatter: [
          FilteringTextInputFormatter.digitsOnly,
          PhoneInputFormatter()
        ],
        keyboardType: TextInputType.number,
        hint: '전화번호',
        onTap: () {
          if (phoneController.text.isNotEmpty) {
            FocusNode().unfocus();
            homeProvider.postPhone(phoneController.text);
          }
        },
        buttonText: '인증하기');
  }

  void showAuthenticateDialog() {
    var homeProvider = ref.read(HomeProvider);

    showDismissDialog(context, controller: authenticateController,
        hint: '인증번호',
        onTap: () {
          if (authenticateController.text.isNotEmpty) {
            FocusNode().unfocus();
            homeProvider.postAuthenticate(
                phoneController.text, authenticateController.text);
          }
        },
        keyboardType: TextInputType.number,
        buttonText: '인증하기');
  }

  void showLoginDialog() {
    showDismissDialog(context,
        hint: '아이디',
        controller: idController,
        subHint: '비밀번호',
        subController: passwordController,
        buttonText: '로그인',
        onTap: () {
          if (idController.text == 'flash21' &&
              passwordController.text == 'flash2121') {
            Navigator.of(context, rootNavigator: true).pop();

            login('010-3811-0831');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(milliseconds: 1500),
              content: Text('로그인에 실패하였습니다.'),
            ));
          }
        });
  }

  void showErrorDialog() {
    showDismissDialog(context,
        title: '앱 재실행 후 전화번호 사용 권한을 허용해 주세요',
        buttonText: '확인', onTap: () async {
          Navigator.of(context, rootNavigator: true).pop();

          SystemNavigator.pop();
        });
  }

  @override
  Widget build(BuildContext context) {
    var homeProvider = ref.watch(HomeProvider);

    loadStateFunction(homeProvider.phoneState, onSuccess: (data) {
      Future.delayed(Duration(milliseconds: 300)).then((onValue) {
        Navigator.of(context, rootNavigator: true).pop();
        showAuthenticateDialog();

        homeProvider.phoneState = End();
      });
    }, onError: (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text('인증에 실패하였습니다.'),
        ),
      );
    });

    loadStateFunction(homeProvider.authenticateState, onSuccess: (data) {
      Future.delayed(Duration(milliseconds: 300)).then((onValue) {
        Navigator.of(context, rootNavigator: true).pop();

        homeProvider.authenticateState = End();
        login(phoneController.text);
      });
    }, onError: (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text('인증번호가 잘못되었습니다.'),
        ),
      );
    });

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          var widget = homeProvider.popCurrentWidget();
          if (widget == null) SystemNavigator.pop();
        },
        child: Scaffold(
            backgroundColor: GlobalColor.white,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: GlobalColor.white,
                title: InkWell(
                    onTap: () {
                      homeProvider.pushCurrentWidget = HomeMainScreen();
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: GlobalColor.indexBoxColor,
                        ),
                        child: Row(children: [
                          SvgPicture.asset(
                            height: 20,
                            'asset/icons/logo.svg',
                            fit: BoxFit.contain,
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              homeProvider.pushCurrentWidget = MyInfoScreen();
                            },
                            child: SvgPicture.asset(
                              'asset/icons/my_info_icon.svg',
                              width: 24,
                              height: 24,
                            ),
                          )
                        ])))),
            body: homeProvider.currentWidget ?? currentWidgetIsNull()));
  }

  HomeMainScreen currentWidgetIsNull() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text('뒤로 가기 버튼을 한 번 더 누르면 앱이 종료됩니다.'),
        ),
      );
    });
    addHomeScreen();
    return const HomeMainScreen();
  }

  Future addHomeScreen() async {
    await Future.delayed(const Duration(milliseconds: 1500)).then((onValue) {
      Log.d('NavigateScope: Add HomeMainScreen');
      ref
          .read(HomeProvider)
          .setCurrentWidget = const HomeMainScreen();
    });
    return;
  }
}
