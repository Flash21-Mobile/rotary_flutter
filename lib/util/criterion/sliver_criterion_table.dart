import 'package:flutter/cupertino.dart';
import '../global_color.dart';
import 'criterion_interfaces.dart';

class SliverCriterionTable extends StatelessWidget {
  final List<CriterionInterface> data;

  const SliverCriterionTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Column(children: [
          index == 0
              ? horizontalDivider(color: GlobalColor.indexColor)
              : const SizedBox(),
          Container(
              color: index == 0 ? GlobalColor.boxColor : null,
              child: Row(
                  children: data[index].rowColumnWidget(
                      divider:  index != 0 ? verticalDivider() : const SizedBox()))),
          horizontalDivider()
        ]);
      },
    );
  }

  Widget horizontalDivider({Color color = GlobalColor.dividerColor}) =>
      Container(
        height: 1,
        color: color,
      );

  Widget verticalDivider() =>
      Container(width: 1, height: 50, color: GlobalColor.dividerColor);
}
