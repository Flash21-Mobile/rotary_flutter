import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/montlyletter/monthly_letter_view_model.dart';
import 'package:rotary_flutter/feature/userSearch/list/user_search_list_component.dart';
import '../../data/model/article_model.dart';
import '../../util/global_color.dart';
import '../home/home_main_component.dart';
import 'detail/monthly_letter_detail.dart';

class MonthlyLetterListTile extends ConsumerStatefulWidget {
  const MonthlyLetterListTile(
      {super.key, required this.data, required this.onTap});

  final ArticleModel data;
  final VoidCallback onTap;

  @override
  ConsumerState<MonthlyLetterListTile> createState() {
    return _MonthlyLetterListTile();
  }
}

class _MonthlyLetterListTile extends ConsumerState<MonthlyLetterListTile> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(MonthlyLetterProvider);
    return Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: (){
              widget.onTap();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return MonthlyLetterDetail(
                    data: widget.data);
              }));
            },
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: GlobalColor.dividerColor),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: FutureImage(
                            viewModel.getMonthlyFileFirst(widget.data.id),
                            width: 120,
                            height: 160))),
                SizedBox(
                  width: 15,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 167,
                    child: IndexTitle('${widget.data.title}'),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 167,
                    child: IndexMinText(
                      '${formatDateToFeature(widget.data.content)}',
                      textColor: GlobalColor.indexColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ])
              ],
            )));
  }

  String formatDateToFeature(String? dateTime) {
    try {
      DateTime parsedDate = DateTime.parse(dateTime ?? '');
      var result =
          "${parsedDate.year}.${parsedDate.month.toString().padLeft(2, '0')}.${parsedDate.day.toString().padLeft(2, '0')}";
      return result;
    } catch (e) {
      return dateTime ?? '';
    }
  }
}

class AdvertiseSearchBoxDelegate extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;
  @override
  final double maxExtent;

  final Function(String) onChanged;

  AdvertiseSearchBoxDelegate(
      {this.minExtent = 50, this.maxExtent = 50, required this.onChanged});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: GlobalColor.white,
        child: SearchBox(hint: '검색', onChanged: onChanged));
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
