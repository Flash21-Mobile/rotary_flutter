import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:permission_handler/permission_handler.dart";
import 'package:rotary_flutter/data/remoteData/account_remote_data.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
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
  late TextEditingController nameController;
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
    nameController = TextEditingController();
    idController = TextEditingController();
    passwordController = TextEditingController();


  }

  Future<void> androidLogin() async {
    if (await Permission.phone.request().isGranted) {
      const androidChannel = MethodChannel('com.flash21.rotary_3700/android');
      try {
        var phone = await androidChannel.invokeMethod('getPhoneNumber');

        if (phone != null) {
          phone as String;

          var data = phone.replaceAll('+82', '0');

          final indexPhone =
              '${data.substring(0, 3)}-${data.substring(3, 7)}-${data.substring(7)}';
          login(indexPhone);
        }
      } catch (e) {
        showLoginDialog();
      }
    } else {
      //todo r: 권한 거부
      showErrorDialog();
    }
  }

  void iOSLogin() async {
    if ((await globalStorage.read(key: 'phone')) == null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showIOSLoginDialog();
    });
    }
  }

  void login(String phone) async {
    var dataState = await AccountAPI().getAccount(cellphone: phone);

    loadStateFunction(
        loadState: dataState,
        onSuccess: (data) async {
          var result = (data as List<Account>)[0];
          Fluttertoast.showToast(msg: '${result.name}님 로그인에 성공하였습니다.');

          if (result.permission == true) {
            globalStorage.write(key: 'admin', value: 'admin');
          } else {
            globalStorage.write(key: 'admin', value: null);
          }

          isLogin = true;
          globalStorage.write(key: 'phone', value: phone);
          dataState = End();
        },
        onError: (e) {
          showLoginDialog();
          dataState = End();
        });
  }

  void showIOSLoginDialog() {
    var homeProvider = ref.read(HomeProvider);

    showDismissDialog(context,
        onPopInvokedWithResult: (didPop, result) {
          if (homeProvider.loginState is! Success) {
            homeProvider.popCurrentWidget();
          }
        },
        textInputFormatter: [
          FilteringTextInputFormatter.digitsOnly,
          PhoneInputFormatter()
        ],
        subTextInputFormatter: null,
        keyboardType: TextInputType.number,
        hint: '전화번호',
        subHint: '이름',
        controller: phoneController,
        subController: nameController,
        onTap: () {
          if (phoneController.text.isNotEmpty &&
              nameController.text.isNotEmpty) {
            FocusNode().unfocus();
            homeProvider.iOSLogin(phoneController.text, nameController.text);
            // Navigator.of(context, rootNavigator: true).pop();
          }
        },
        subContent: InkWell(
          onTap: (){
            Navigator.of(context, rootNavigator: true).pop();
            showLoginDialog();
          },
          child: IndexMinText(
            '로그인이 안되시나요?',
            decoration: TextDecoration.underline,
          ),
        ),
        buttonText: '로그인');
  }

  void showLoginDialog() {
    showDismissDialog(context,
        hint: '아이디',
        controller: idController,
        subHint: '비밀번호',
        subController: passwordController,
        subObscureText: true,
        buttonText: '로그인', onTap: () {
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
    },
        extraContents: IndexText(
          '로그인 되지 않은 전화번호입니다.\n\'010-3803-9128\'에 문의하여 계정을 생성한 후 다시 시도해 주세요',
          textAlign: TextAlign.center,
        ));
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

    // iOS 로그인
    loadStateFunction(
        loadState: homeProvider.loginState,
        onSuccess: (data) {
          Navigator.of(context, rootNavigator: true).pop();
          login(phoneController.text);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            homeProvider.loginState = End();
          });
        },
        onError: (e) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            phoneController.text = '';
            nameController.text = '';
            Fluttertoast.showToast(msg: '전화번호 또는 이름이 잘못되었습니다');
          });
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
      ref.read(HomeProvider).setCurrentWidget = const HomeMainScreen();
    });
    return;
  }
}
