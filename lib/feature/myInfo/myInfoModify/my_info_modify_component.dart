import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../util/global_color.dart';

class MyInfoModifyTextField extends ConsumerStatefulWidget {
  final String indexTitle;
  final TextEditingController indexController;
  final bool? multilineEnable;

  const MyInfoModifyTextField(
      {super.key, required this.indexTitle, required this.indexController, this.multilineEnable});

  @override
  ConsumerState<MyInfoModifyTextField> createState() =>
      _MyInfoModifyTextField();
}

class _MyInfoModifyTextField extends ConsumerState<MyInfoModifyTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(widget.indexTitle, style: TextStyle(color: GlobalColor.darkGreyFontColor),),
      SizedBox(height: 5,),
      TextFormField(
        canRequestFocus: true,
          maxLines: (widget.multilineEnable?? false) ? null: 1,
          keyboardType: (widget.multilineEnable?? false) ? TextInputType.multiline:null ,
          controller: widget.indexController,
          decoration: InputDecoration(
            hintText: "${widget.indexTitle}을(를) 입력해주세요",
            filled: true,
            fillColor: GlobalColor.indexBoxColor,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: GlobalColor.transparent)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: GlobalColor.transparent),
              borderRadius: BorderRadius.all(Radius.circular(30.0)), // 동그란 테두리
            ),
          )),
    ]);
  }
}
