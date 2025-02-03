import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/article/response/article_model.dart';
import 'package:rotary_flutter/feature/advertise/advertise_component.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/montlyletter/detail/monthly_letter_detail.dart';
import 'package:rotary_flutter/feature/montlyletter/monthly_letter_component.dart';
import 'package:rotary_flutter/feature/montlyletter/monthly_letter_view_model.dart';
import 'package:rotary_flutter/feature/userSearch/list/user_search_list_component.dart';
import 'package:rotary_flutter/util/common/common.dart';
import 'package:rotary_flutter/util/fontSize.dart';

import '../../data/model/article/response/article_model.dart';
import '../../../../util/global_color.dart';
import '../../util/logger.dart';
import '../../util/model/loadstate.dart';
import '../../util/secure_storage.dart';
import '../advertise/advertise_view_model.dart';
import '../event/page/advertise_page_screen.dart';
import '../home/home_main_component.dart';
import '../home_view_model.dart';

class MonthlyLetterScreen extends ConsumerStatefulWidget {
  const MonthlyLetterScreen({super.key});

  @override
  ConsumerState<MonthlyLetterScreen> createState() => _Widget();
}

class _Widget extends ConsumerState<MonthlyLetterScreen> {
  late ScrollController controller;

  var isAdmin = false;

  void checkAdmin() async {
    var data = (await globalStorage.read(key: 'admin')) == 'admin';

    setState(() => isAdmin = data);
  }

  Future<String?> pickPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    return result?.files.single.path;
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController();

    ref.read(MonthlyLetterProvider).monthlyLetterState = End();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(MonthlyLetterProvider).getMonthlyLetterAll();
      checkAdmin();
    });
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(MonthlyLetterProvider);

    Log.d('데이터 state: ${viewModel.monthlyLetterPostState}');

    loadStateFunction(
        loadState: viewModel.monthlyLetterPostState,
        onSuccess: (data) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('업로드에 성공하였습니다'),
                duration: Duration(milliseconds: 1500),
              ),
            );
          });
          viewModel.monthlyLetterPostState = End();
          SchedulerBinding.instance.addPostFrameCallback((_) {
            viewModel.getMonthlyLetterAll();
          });
          Navigator.of(context, rootNavigator: true).pop();
        },
        onLoading: () {
          viewModel.monthlyLetterPostState = End();
          SchedulerBinding.instance.addPostFrameCallback((_) {
            LoadingWidget.show(context, '파일을 업로드 중입니다');
          });
        },
        onError: (e) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('업로드에 실패하였습니다'),
                duration: Duration(milliseconds: 1500),
                backgroundColor: Colors.red,
              ),
            );
          });

          viewModel.monthlyLetterPostState = End();
          Navigator.of(context, rootNavigator: true).pop();
        });

    return Scaffold(
      backgroundColor: GlobalColor.white,
      appBar: AppBar(
        title: IndexMaxTitle('총재월신'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(HomeProvider).popCurrentWidget();
          },
        ),
        actions: [
          Center(
              child: Row(children: [
            Icon(
              Icons.article,
              color: GlobalColor.greyFontColor,
              size: 20,
            ),
            IndexMinText(
              '${viewModel.monthlyLetterCount}',
              textColor: GlobalColor.greyFontColor,
            ),
            SizedBox(
              width: 15
            )
          ]))
        ],
      ),
      body: Stack(alignment: Alignment.topCenter, children: [
        CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            controller: controller,
            slivers: [
              SliverAppBar(
                snap: true,
                automaticallyImplyLeading: false,
                floating: true,
                flexibleSpace: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    color: GlobalColor.white,
                    child: SearchBox(
                        hint: '검색',
                        onChanged: (data) {
                          viewModel.sortData(query: data);
                        })),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 15)),
              LoadStateWidgetFun(
                  loadState: viewModel.monthlyLetterState,
                  successWidget: (_) {
                    return SliverList.separated(
                      itemCount: viewModel.monthlyLetterList.length + 1,
                      itemBuilder: (context, index) {
                        if (index == viewModel.monthlyLetterList.length) {
                          return Container(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: const IndexText('더 이상 검색된 목록이 없습니다',
                                  textAlign: TextAlign.center));
                        }
                        return MonthlyLetterListTile(
                          data: viewModel.monthlyLetterList[index],
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                        );
                      },
                      separatorBuilder: (_, $) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                            height: 1, color: GlobalColor.dividerColor),
                      ),
                    );
                  },
                  loadingWidget: () => SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator())),
                  errorWidget: (e) =>
                      SliverToBoxAdapter(child: CircularProgressIndicator()),
                  elseWidget: SliverToBoxAdapter())
            ]),
      ]),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () async {
                var data = await pickPdfFile();
                if (data != null) {
                  showFileDialog(data);
                }
              },
              backgroundColor: GlobalColor.primaryColor,
              child: const Icon(
                Icons.add_rounded,
              ))
          : null,
    );
    // Container(
    //     color: GlobalColor.white,
    //     height: 30,
    //     alignment: Alignment.center,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.end,
    //       children: [
    //         IndexMinText('전체 광고 수: ${viewModel.advertiseCount}'),
    //       ],
  }

  void showFileDialog(
    String data,
  ) {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              title: '선택된 파일',
              subTitle: data.split('/').last,
              onConfirm: () async {
                Navigator.of(context).pop();
                await ref.read(MonthlyLetterProvider).postMonthlyLetter(data);
              },
              onCancel: () {
                Navigator.of(context).pop();
              },
              confirmText: '업로드',
              cancelText: '취소',
            ));
  }
}
