import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/userSearch/UserSearchList/user_search_list_view_model.dart';
import 'package:rotary_flutter/feature/userSearch/userInfo/user_info_screen.dart';
import 'package:rotary_flutter/util/model/cardinal_location.dart';
import 'package:rotary_flutter/util/model/cardinal_r_c.dart';

import '../../../data/model/account_model.dart';
import '../../../util/global_color.dart';
import '../../home/home_main_component.dart';
import '../../home_provider.dart';

class UserListWidget extends ConsumerStatefulWidget {
  final int initialLocation;

  const UserListWidget({super.key, required this.initialLocation});

  @override
  ConsumerState<UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends ConsumerState<UserListWidget> {
  late int _selectedLocation;
  late int _selectedRC;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.initialLocation;
    _selectedRC = 0;

    getAccountList();
  }

  void getAccountList() {
    ref.read(UserSearchListProvider).getAccountList(
        cardinal: CardinalLocation.all[_selectedLocation].id,
        groupCardinal: CardinalRC.all[_selectedRC].id);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userSearchListProvider = ref.watch(UserSearchListProvider);
    return Scaffold(
        backgroundColor: GlobalColor.indexBoxColor,
        appBar: AppBar(
          title: Text('회원검색'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(HomeProvider).popCurrentWidget();
            },
          ),
        ),
        body: Column(children: [
          SizedBox(
            height: 15,
          ),
          Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Row(
                children: [
                  CustomDropdown(
                      items: CardinalLocation.all.map((value) => value.name).toList(),
                      selectedValue: _selectedLocation,
                      onChanged: (value) {
                        if (value != null && value != _selectedLocation) {
                          setState(() => _selectedLocation = value);
                          getAccountList();
                        }
                      }),

                  SizedBox(width: 10),
                  CustomDropdown(
                      items: CardinalRC.all.map((value) => value.name).toList(),
                      selectedValue: _selectedRC,
                      onChanged: (value) {
                        if (value != null && value != _selectedLocation) {
                          setState(() => _selectedRC = value);
                          getAccountList();
                        }
                      }),

                  SizedBox(width: 10),
                  // 검색 텍스트필드
                  Expanded(
                      child: Container(
                    height: 40,
                    child: SearchBox(
                      hint: '회원검색',
                      borderColor: GlobalColor.transparent,
                      backgroundColor: GlobalColor.white,
                    ),
                  )) //
                ],
              )),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: LoadStateWidget(
                  loadState: userSearchListProvider.userListState,
                  successWidget: (data) {
                    var accounts = data as List<Account>;

                    return LoadStateWidget(
                        loadState: userSearchListProvider.userListState,
                        successWidget: (data) {
                          return ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            itemCount: accounts.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    ref.read(HomeProvider).pushCurrentWidget = UserInfoScreen(id: accounts[index].id??0);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: GlobalColor.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 160,
                                          color: GlobalColor.primaryColor,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(children: [
                                              IndexThumbTitle(
                                                  accounts[index].name),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              IndexText(
                                                accounts[index].groupCardinal?.name,
                                                overFlowFade: true,
                                              )
                                            ]),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            IndexText('정회원'),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(children: [
                                              IndexText('직책'),
                                              IndexText('초대회장'),
                                            ]),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(children: [
                                              IndexText('입회일'),
                                            ]),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            IndexText('010-****-****'),
                                          ],
                                        )
                                      ],
                                    ),
                                  ));
                            },
                            separatorBuilder: (_, $) {
                              return SizedBox(
                                height: 10,
                              );
                            },
                          );
                        });
                  },errorWidget: Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      Text(
                        'ⓘ',
                        style: TextStyle(fontSize: 40),
                      ),
                      IndexText('조회된 데이터가 없습니다.'),
                    ],
                  ))))
        ]));
  }
}
