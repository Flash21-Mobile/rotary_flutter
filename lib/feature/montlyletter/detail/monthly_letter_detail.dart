import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/article_model.dart';
import 'package:rotary_flutter/feature/advertise/advertise_view_model.dart';
import 'package:rotary_flutter/feature/event/page/advertise_page_screen.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/home_view_model.dart';
import 'package:rotary_flutter/feature/montlyletter/monthly_letter_view_model.dart';
import 'package:rotary_flutter/feature/userSearch/info/user_info_screen.dart';
import 'package:rotary_flutter/feature/userSearch/list/user_search_list_component.dart';
import 'package:rotary_flutter/util/global_color.dart';

import '../../../util/model/loadstate.dart';
import '../../../util/secure_storage.dart';

class MonthlyLetterDetail extends ConsumerStatefulWidget {
  final ArticleModel data;

  const MonthlyLetterDetail({super.key, required this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Widget();
}

class _Widget extends ConsumerState<MonthlyLetterDetail> {
  var _index = 1;

  var isAdmin = false;

  void checkAdmin() async {
    var data = (await globalStorage.read(key: 'admin')) == 'admin';

    setState(() => isAdmin = data);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.read(MonthlyLetterProvider).getMonthlyFiles(widget.data.id);
      checkAdmin();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(MonthlyLetterProvider);

    return LoadStateScaffold(
        loadState: viewModel.monthlyLetterFilesState,
        appBar: AppBar(
          title: Text(''
              '총재월신'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            ...?isAdmin
                ? [
              Container(
                  padding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: GlobalColor.primaryColor),
                      child: Text(
                        '삭제',
                        style: TextStyle(color: GlobalColor.white),
                      ),
                    ),
                    onTap: () async {
                      var response = await ref
                          .read(MonthlyLetterProvider)
                          .deleteMonthlyLetter(widget.data.id ?? 0);
                      if (response is Success) {
                        Navigator.pop(context);
                      }
                    },
                  ))
            ]
                : null
          ],
        ),
        backgroundColor: GlobalColor.black,
        successBody: (data) {
          data as List<int?>?;

          return Stack(
            alignment: Alignment.bottomRight,
            children: [
              // PageablePinchView(
              //     items: data,
              //     onPageChanged: (index) {
              //       setState(() => _index = index + 1);
              //     }),
              ListPinchView(
                items: data,
                indexNum: (index) {
                  setState(() {
                    _index = index + 1;
                  });
                },
              ),

              Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                      color: GlobalColor.black.withAlpha(100),
                      borderRadius: BorderRadius.circular(100)),
                  margin: EdgeInsets.only(bottom: 10, right: 10),
                  child: IndexMinText(
                    '$_index / ${data?.length}',
                    textColor: GlobalColor.white,
                  ))
            ],
          );
        });
  }
}
