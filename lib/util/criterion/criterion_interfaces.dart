import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../feature/home/home_main_component.dart';

abstract interface class CriterionInterface {
  const CriterionInterface(
      {required this.type, required this.target, this.note = ''});

  final String type;
  final String target;
  final String note;

  List<Widget> rowColumnWidget({required Widget divider});
}

class CriterionAll extends CriterionInterface {
  const CriterionAll({
    required super.type,
    required super.target,
    super.note,
    required this.content,
  });

  final String content;

  @override
  List<Widget> rowColumnWidget({required divider}) {
    return [
      Expanded(flex: 4, child: _container(_indexText(type))),
      divider,
      Expanded(flex: 3, child: _container(_indexText(target))),
      divider,
      Expanded(flex: 7, child: _container(_indexText(content))),
    ];
  }
}

class CriterionClub extends CriterionInterface {
  const CriterionClub({
    required super.type,
    required super.target,
    super.note,
    required this.content,
  });

  final String content;

  @override
  List<Widget> rowColumnWidget({required divider}) {
    return [
      Expanded(flex: 4, child: _container(_indexText(type))),
      divider,
      Expanded(flex: 3, child: _container(_indexText(target))),
      divider,
      Expanded(
          flex: 7,
          child: _container(Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _indexText(content),
                note.isNotEmpty ? _indexText(note, color: Colors.red) : const SizedBox()
              ])))
    ];
  }
}

class CriterionPersonal extends CriterionInterface {
  const CriterionPersonal({
    required super.type,
    required super.target,
    super.note,
  });

  @override
  List<Widget> rowColumnWidget({required divider}) {
    return [
      Expanded(flex: 4, child: _container(_indexText(type))),
      divider,
      Expanded(flex: 7, child: _container(_indexText(target))),
      divider,
      Expanded(flex: 5, child: _container(_indexText(note))),
    ];
  }
}

Widget _container(Widget child) =>
    Container(padding: EdgeInsets.symmetric(horizontal: 3), alignment: Alignment.center, height: 50, child: child);

Widget _indexText(String text, {Color? color}) =>
    IndexMicroText(height: 1.2, textAlign: TextAlign.center, text, textColor: color,);
