import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import "package:permission_handler/permission_handler.dart";
import 'package:rotary_flutter/data/model/token/response/token.dart';
import 'package:rotary_flutter/data/remoteData/account_remote_data.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/home_view_model.dart';
import 'package:rotary_flutter/feature/myInfo/my_info_screen.dart';
import 'package:rotary_flutter/feature/usersearch/list/user_search_list_view_model.dart';
import 'package:rotary_flutter/util/checkPackageVersion.dart';
import 'package:rotary_flutter/util/common/phone_input_formatter.dart';
import 'package:rotary_flutter/util/global_color.dart';
import 'package:rotary_flutter/util/logger.dart';
import 'package:rotary_flutter/util/model/loadstate.dart';
import 'package:rotary_flutter/util/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/model/account/response/account_model.dart';
import 'home/home_main_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends ConsumerState<HomeScreen> {
  late TextEditingController phoneController;
  late TextEditingController nameController;
  late TextEditingController idController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    init();

    phoneController = TextEditingController();
    nameController = TextEditingController();
    idController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future init() async {
    final checkedData = await AppVersionCheck().checkUpdate();

    print('''
    앱 업데이트 체크
    canUpdate : ${checkedData.canUpdate}
    currentVersion : ${checkedData.currentVersion}
    newVersion : ${checkedData.newVersion}
    appURL : ${checkedData.appURL}
    errorMessage : ${checkedData.errorMessage}''');

    if (checkedData.canUpdate) {
      showDismissDialog(context,
          title: '새로운 버전이 출시되었습니다 \n앱을 업데이트합니다',
          buttonText: ('업데이트'), onTap: () async {
        if (Platform.isAndroid) {
          final PackageInfo packageInfo = await PackageInfo.fromPlatform();

          final androidUrl = Uri.parse('https://play.google.com/store/apps/details?id=${packageInfo.packageName}');
          if (await canLaunchUrl(androidUrl)) launchUrl(androidUrl);
        } else if (Platform.isIOS) {
          final iOSUrl = Uri.parse(
              'https://apps.apple.com/kr/app/%EB%A1%9C%ED%83%80%EB%A6%AC%EC%BD%94%EB%A6%AC%EC%95%84/id6499181112');

          if (await canLaunchUrl(iOSUrl)) {
            await launchUrl(iOSUrl);
          } else {
            Fluttertoast.showToast(msg: '앱 스토어를 열 수 없습니다');
          }
        }
      });
    } else {
      if (Platform.isAndroid) {
        androidLogin();
      } else if (Platform.isIOS) {
        iOSLogin();
      }
    }
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
          signIn(cellphone: indexPhone);
        }
      } catch (e) {
        // todo r: 타임아웃 처리하기
        showLoginDialog();
      }
    } else {
      showErrorDialog();
    }
  }

  void iOSLogin() async {
    final i =await SharedPreferences.getInstance();
    bool isInit = i.getBool('isInit')??false;

    final cellphone = await globalStorage.read(key: 'phone');
    if (cellphone == null || !isInit) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showIOSLoginDialog();
    });
    } else {
     signIn(cellphone: cellphone);
    }
  }
  void signIn({required String cellphone, String? name}) async {
    var viewModel = ref.watch(HomeProvider);

    viewModel.signIn(
        cellphone: cellphone, name: name); // todo r: 첫 로그인 시에도 회원 불러오기
  }

  void showIOSLoginDialog() {
    var homeProvider = ref.read(HomeProvider);

    showDismissDialog(context,
        onPopInvokedWithResult: (didPop, result) {
          if (homeProvider.loginState is! Success) {
            WidgetsBinding.instance.addPostFrameCallback((_){

            // homeProvider.popCurrentWidget();
            });
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
            // homeProvider.iOSLogin(phoneController.text, nameController.text);
            signIn(cellphone: phoneController.text, name: nameController.text);
            // Navigator.of(context, rootNavigator: true).pop();
          }
        },
        subContent: InkWell(
          onTap: () {
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

        // signIn('010-3811-0831');
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
    var viewModel = ref.watch(HomeProvider);

    loadStateFunction(
        loadState: viewModel.signState,
        onSuccess: (data) async {
          data as Account;

          if (data.cellphone == phoneController.text && Platform.isIOS) {
            Navigator.of(context, rootNavigator: true).pop();
            final i =await SharedPreferences.getInstance();
            i.setBool('isInit', true);

            Fluttertoast.showToast(msg: '${data.name}님 로그인에 성공하였습니다.');
          }
          if (Platform.isAndroid) {
            Fluttertoast.showToast(msg: '${data.name}님 로그인에 성공하였습니다.');
          }

          if (data.permission == true) {
            globalStorage.write(key: 'admin', value: 'admin');
          } else {
            globalStorage.write(key: 'admin', value: null);
          }
          globalStorage.write(key: 'phone', value: data.cellphone);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(UserSearchListProvider).getAccountList();
            viewModel.signState = End();
          });
        },
        onError: (e) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showLoginDialog();
            viewModel.signState = End();
          });
        });

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          var widget = viewModel.popCurrentWidget();
          if (widget == null) SystemNavigator.pop();
        },
        child: Scaffold(
            backgroundColor: GlobalColor.white,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: GlobalColor.white,
                title: InkWell(
                    onTap: () {
                      viewModel.pushCurrentWidget = HomeMainScreen();
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
                              viewModel.pushCurrentWidget = MyInfoScreen();
                            },
                            child: SvgPicture.asset(
                              'asset/icons/my_info_icon.svg',
                              width: 24,
                              height: 24,
                            ),
                          )
                        ])))),
            body: viewModel.currentWidget ?? currentWidgetIsNull()));
  }

  HomeMainScreen currentWidgetIsNull() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Platform.isAndroid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 1500),
            content: Text('뒤로 가기 버튼을 한 번 더 누르면 앱이 종료됩니다.'),
          ),
        );
      }
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
