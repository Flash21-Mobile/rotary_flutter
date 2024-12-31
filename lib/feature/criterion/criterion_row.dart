import 'package:flutter/material.dart';
import 'package:rotary_flutter/util/global_color.dart';

class CriterionRow {
  final String option;
  final String target;
  final String content;
  var note;

  CriterionRow(this.option, this.target, this.content, {this.note = ''});

  CriterionRow.defaultClub(this.option, this.content,
      {this.target = '해당 클럽', this.note = ''});

  CriterionRow.withNote(this.option, this.content, this.note,
      {this.target = '해당 클럽'});

  TableRow toDataRow() {
    return TableRow(children: [
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            textAlign: TextAlign.center,
            option,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
      TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                target,
                style: TextStyle(fontSize: 15),
              ))),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: content.replaceAll('\n', ''), // 줄바꿈 제거
                      style: const TextStyle(fontSize: 15),
                    ),
                    if (note != null)
                      TextSpan(
                        text: '\n'+note, // 줄바꿈 제거
                        style: const TextStyle(color: Colors.red, fontSize: 13),
                      ),
                  ],
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
