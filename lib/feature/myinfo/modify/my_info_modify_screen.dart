import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rotary_flutter/data/remoteData/file_remote_data.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/home_view_model.dart';
import 'package:rotary_flutter/util/common/common.dart';
import 'package:rotary_flutter/util/get_address_screen.dart';
import 'package:rotary_flutter/util/model/menu_items.dart';
import 'package:rotary_flutter/data/remoteData/account_remote_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rotary_flutter/data/model/account/response/account_model.dart';
import '../../../util/common/date_input_formatter.dart';
import '../../../util/logger.dart';
import '../../../util/model/loadstate.dart';
import '../../../util/fontSize.dart';
import '../../../util/global_color.dart';
import '../../../util/model/pair.dart';
import '../../home/home_main_component.dart';
import '../../myInfo/modify/my_info_modify_component.dart';
import '../../myInfo/modify/my_info_modify_view_model.dart';
import '../my_info_view_model.dart';

class MyInfoModifyScreen extends ConsumerStatefulWidget {
  const MyInfoModifyScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyInfoModifyScreen();
}

class _MyInfoModifyScreen extends ConsumerState<MyInfoModifyScreen> {
  var nickNameController = TextEditingController();
  var birthDateController = TextEditingController();
  var enNameController = TextEditingController();
  var memoController = TextEditingController();

  var emailController = TextEditingController();
  var faxController = TextEditingController();

  var workNameController = TextEditingController();
  var workPositionNameController = TextEditingController();
  var workAddressZipCodeController = TextEditingController();
  var workAddressController = TextEditingController();
  var workAddressSubController = TextEditingController();
  var typeController = TextEditingController();

  var timeController = TextEditingController();

  void getMyData() async {
    var myInfoProvider = ref.read(MyInfoProvider);
    var myInfoModifyProvider = ref.read(MyInfoModifyProvider);
    await myInfoProvider.getMyAccount();

    Log.d("hello: heli ${myInfoProvider.accountState}");
    loadStateFunction(
        loadState: myInfoProvider.accountState,
        onSuccess: (data) async {
          var account = (data as List<Account>).first;

          nickNameController.text = account.nickname ?? '';
          birthDateController.text = account.birthDate ?? '';
          enNameController.text = account.englishName ?? '';
          memoController.text = account.memo ?? '';

          emailController.text = account.email ?? '';
          faxController.text = account.faxNumber ?? '';

          workNameController.text = account.workName ?? '';
          workPositionNameController.text = account.workPositionName ?? '';
          workAddressZipCodeController.text = account.workAddressZipCode ?? '';
          workAddressController.text = account.workAddress ?? '';
          workAddressSubController.text = account.workAddressSub ?? '';
          typeController.text = account.job ?? '';
          timeController.text = account.time??'';

          await myInfoModifyProvider.getAccountFile(account.id);
        });
  }

  @override
  void dispose() {
    nickNameController.dispose();
    birthDateController.dispose();
    enNameController.dispose();
    memoController.dispose();

    workNameController.dispose();
    workPositionNameController.dispose();
    workAddressZipCodeController.dispose();
    workAddressController.dispose();
    workAddressSubController.dispose();
    typeController.dispose();

    timeController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getMyData();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(MyInfoModifyProvider);
    var myInfoProvider = ref.watch(MyInfoProvider);

    Log.d('i am Received ${viewModel.imagePath}');

    return LoadStateScaffold(
        loadState: myInfoProvider.accountState,
        backgroundColor: GlobalColor.white,
        appBar: AppBar(
          title: IndexMaxTitle('내 정보 수정'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(HomeProvider).popCurrentWidget();
            },
          ),
          actions: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: InkWell(
                  onTap: () async {
                    final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (emailController.text.isNotEmpty &&
                        !emailRegex.hasMatch(emailController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        duration: Duration(milliseconds: 1500),
                        content: Text('이메일 형식이 올바르지 않습니다.'),
                      ));

                      return;
                    }

                    var data =
                        (myInfoProvider.accountState as Success).data.first;
                    data as Account;
                    data.nickname = nickNameController.text;

                    data.birthDate = birthDateController.text;
                    data.englishName = enNameController.text;
                    data.memo = memoController.text;

                    data.email = emailController.text;
                    data.faxNumber = faxController.text;

                    data.workName = workNameController.text;
                    data.workPositionName = workPositionNameController.text;
                    data.workAddressZipCode = workAddressZipCodeController.text;
                    data.workAddress = workAddressController.text;
                    data.workAddressSub = workAddressSubController.text;
                    data.job = typeController.text;

                    data.time = timeController.text;

                    var currentState = myInfoProvider.accountState;

                    myInfoProvider.accountState = Loading();
                    setState(() {});

                    var response = await AccountAPI().putAccount(data);

                    var imageResponse = viewModel.image != null
                        ? await FileAPI()
                            .postAccountFile(data.id, viewModel.image!)
                        : Success('');

                    if (response is Success && imageResponse is Success) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(milliseconds: 1500),
                        content: Text('성공적으로 저장되었습니다.'),
                      ));

                      myInfoProvider.accountState =
                          Success([response.data as Account]);

                      // ref.read(HomeProvider).popCurrentWidget();
                    } else {
                      myInfoProvider.accountState = currentState;
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: GlobalColor.primaryColor),
                    child: IndexText(
                      '저장',
                      defaultScale: true,
                      textColor: GlobalColor.white,
                    ),
                  ),
                ))
          ],
        ),
        successBody: (data) {
          var account = (data as List<Account>).first;

          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(
                      text: '개인정보',
                    ),
                    Tab(
                      text: '회사정보',
                    ),
                  ],
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.primaryColor,
                      fontSize: DynamicFontSize.font20(context)),
                  unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: DynamicFontSize.font20(context),
                      color: GlobalColor.indexColor),
                  indicator: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: GlobalColor.primaryColor, width: 1)),
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(children: [
                            Row(
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    viewModel.pickImage();
                                  },
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.all(5),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color: GlobalColor
                                                          .indexBoxColor,
                                                      border: Border.all(
                                                          color: GlobalColor
                                                              .indexColor,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                  width: 100,
                                                  height: 100,
                                                  child: viewModel.image != null
                                                      ? Image.file(
                                                          viewModel.image!,
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                          alignment: Alignment
                                                              .topCenter,
                                                        ) // todo r: 총재월신 삭제 컨펌하기
                                                      : viewModel.imagePath !=
                                                              null
                                                          ? AvifImage.network(
                                                              '$BASE_URL/file/${viewModel.imagePath}',
                                                              headers: const {
                                                                'cheat':
                                                                    'showmethemoney'
                                                              },
                                                              fit: BoxFit.cover,
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .person_rounded,
                                                              size: 50,
                                                              color: GlobalColor
                                                                  .indexColor,
                                                            )))),
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: GlobalColor.indexColor),
                                          padding: EdgeInsets.all(5),
                                          child: Icon(
                                            Icons.camera_alt_rounded,
                                            size: 25,
                                            color: GlobalColor.indexBoxColor,
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IndexMaxTitle(account.name),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      IndexMaxTitle('${account.cellphone}'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      IndexText('${account.memberRi ?? ''}')
                                    ])
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            MyInfoModifyTextField(
                                indexTitle: '아호',
                                indexController: nickNameController),
                            SizedBox(
                              height: 15,
                            ),
                            MyInfoModifyTextField(
                              indexTitle: '생년월일',
                              indexController: birthDateController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [DateInputFormatter()],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            MyInfoModifyTextField(
                                indexTitle: '영문명',
                                indexController: enNameController),
                            SizedBox(
                              height: 15,
                            ),
                            MyInfoModifyTextField(
                                indexTitle: '이메일',
                                indexController: emailController),
                            SizedBox(
                              height: 15,
                            ),
                            MyInfoModifyTextField(
                                indexTitle: '팩스',
                                keyboardType: TextInputType.number,
                                indexController: faxController),
                            SizedBox(
                              height: 15,
                            ),
                            MyInfoModifyTextField(
                              indexTitle: '메모',
                              indexController: memoController,
                              multilineEnable: true,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            MyInfoModifyTextField(
                              indexTitle: '입회일',
                              keyboardType: TextInputType.number,
                              indexController: timeController,
                              inputFormatters: [DateInputFormatter()],
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ]),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(children: [
                            MyInfoModifyTextField(
                                indexTitle: '회사명',
                                indexController: workNameController),
                            SizedBox(
                              height: 15,
                            ),
                            MyInfoModifyTextField(
                                indexTitle: '회사 직책',
                                indexController: workPositionNameController),
                            const SizedBox(height: 15),
                            InkWell(
                                splashColor: GlobalColor.transparent,
                                highlightColor: GlobalColor.transparent,
                                onTap: () {
                                  getAddress();
                                },
                                child: AbsorbPointer(
                                    child: Column(children: [
                                  MyInfoModifyTextField(
                                      indexTitle: '회사 우편번호',
                                      indexController:
                                          workAddressZipCodeController),
                                  const SizedBox(height: 15),
                                  MyInfoModifyTextField(
                                      indexTitle: '회사 주소',
                                      indexController: workAddressController),
                                  const SizedBox(height: 15),
                                ]))),
                            MyInfoModifyTextField(
                                indexTitle: '회사 상세주소',
                                indexController: workAddressSubController),
                            const SizedBox(height: 15),
                            MyInfoModifyTextField(
                                indexTitle: '업종',
                                indexController: typeController),
                            SizedBox(
                              height: 100,
                            )
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future getAddress() async {
    DataModel data =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return GetAddressScreen();
    }));

    workAddressController.text = data.address;
    workAddressZipCodeController.text = data.zonecode;

    Log.d('received data hello: $data');
  }
}
