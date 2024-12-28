import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:permission_handler/permission_handler.dart";
import 'package:rotary_flutter/data/remoteData/account_remote_data.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/home_provider.dart';
import 'package:rotary_flutter/feature/myInfo/my_info_screen.dart';
import 'package:rotary_flutter/util/common/phone_input_formatter.dart';
import 'package:rotary_flutter/util/global_color.dart';
import 'package:rotary_flutter/util/logger.dart';
import 'package:rotary_flutter/util/model/state.dart';
import 'package:rotary_flutter/util/secure_storage.dart';
import '../data/model/account_model.dart';
import 'home/home_main_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {     //todo r: 전화번호 받아오는 동안 로딩
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreen();
}

late WidgetRef globalRef;

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
    if (Platform.isAndroid) androidLogin();
    else if (Platform.isIOS) iOSLogin();

    globalRef = ref;

    phoneController = TextEditingController();
    authenticateController = TextEditingController();
    idController = TextEditingController();
    passwordController = TextEditingController();
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
              onError: (e) => showLoginDialog());
        }
      } catch (e) {
        showLoginDialog();
      }
    }
  }

  void iOSLogin() async {
    if ((await globalStorage.read(key: 'phone')) == null)
      Future.delayed(Duration(milliseconds: 300))
          .then((onValue) => showPhoneDialog());
  }

  void showPhoneDialog() {
    var homeProvider = ref.read(HomeProvider);
    
    showDismissDialog(context,
      onPopInvokedWithResult: (didPop, result) {
        if (homeProvider.phoneState is! Success)
          homeProvider.popCurrentWidget();
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
    
    showDismissDialog(
        context, 
        controller: authenticateController, 
        hint: '인증번호',
        onTap: (){
          if (authenticateController.text.isNotEmpty) {
            FocusNode().unfocus();
            homeProvider.postAuthenticate(
                authenticateController.text);
          }},
        keyboardType: TextInputType.number,
    buttonText: '인증하기');
  }
  
  void showLoginDialog(){
    showDismissDialog(
        context,
        hint: '아이디',
        controller: idController,
        subHint: '비밀번호',
        subController: passwordController,
        buttonText: '로그인',
    onTap: (){
          if (idController.text == 'flash21' && passwordController.text == 'flash2121'){
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(milliseconds: 1500),
              content: Text('로그인에 성공하였습니다'),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(milliseconds: 1500),
              content: Text('로그인에 실패하였습니다'),
            ));
          }
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

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          var widget = homeProvider.popCurrentWidget();
          if(widget == null) SystemNavigator.pop();
        },
        child: Scaffold(
            backgroundColor: GlobalColor.white,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: GlobalColor.white,
                title:InkWell(
                    onTap: (){
                      homeProvider.pushCurrentWidget = HomeMainScreen();
                    },
                    child:  Container(
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
                            'asset/images/main_logo.svg',
                            fit: BoxFit.contain,
                          ),
                          Spacer(),
                          InkWell(
                            onTap: (){
                              homeProvider.pushCurrentWidget = MyInfoScreen();
                            },
                            child: SvgPicture.asset('asset/icons/router/my_info_filled_icon.svg',width: 24, height: 24,),
                          )
                        ])))),
            body: homeProvider.currentWidget??currentWidgetIsNull())


    );
  }

  HomeMainScreen currentWidgetIsNull(){
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

  Future addHomeScreen()async{
    await Future.delayed(const Duration(milliseconds: 1500)).then((onValue){
      Log.d('NavigateScope: Add HomeMainScreen');
      ref.read(HomeProvider).setCurrentWidget = const HomeMainScreen();
    });
    return;
  }
}
