import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';

import '../../../util/global_color.dart';

class MyInfoModifyTextField extends ConsumerStatefulWidget {
  final String indexTitle;
  final TextEditingController? indexController;
  final bool? multilineEnable;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final bool readOnly;

  const MyInfoModifyTextField(
      {super.key,
      required this.indexTitle,
      this.indexController,
      this.multilineEnable,
      this.inputFormatters,
      this.keyboardType,
      this.obscureText,
      this.textInputAction,
      this.readOnly = false});

  @override
  ConsumerState<MyInfoModifyTextField> createState() =>
      _MyInfoModifyTextField();
}

class _MyInfoModifyTextField extends ConsumerState<MyInfoModifyTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      IndexText(
        widget.indexTitle,
        textColor: GlobalColor.darkGreyFontColor,
      ),
      SizedBox(
        height: 5,
      ),
      TextFormField(
          readOnly: widget.readOnly,
          obscureText: widget.obscureText ?? false,
          inputFormatters: widget.inputFormatters,
          canRequestFocus: true,
          textInputAction: widget.textInputAction,
          maxLines: (widget.multilineEnable ?? false) ? null : 1,
          keyboardType: widget.keyboardType ??
              ((widget.multilineEnable ?? false)
                  ? TextInputType.multiline
                  : null),
          controller: widget.indexController,
          decoration: InputDecoration(
            hintText: "${widget.indexTitle}을(를) 입력해주세요",
            filled: true,
            fillColor: GlobalColor.indexBoxColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
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
