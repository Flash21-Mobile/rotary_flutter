import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../util/fontSize.dart';
import '../../util/global_color.dart';

class IndexText extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final bool? overFlowFade;

  const IndexText(this.text, {super.key, this.textColor, this.overFlowFade});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
          fontSize: DynamicFontSize.font21(context),
          color: textColor ?? GlobalColor.black),
      overflow: overFlowFade ?? false ? TextOverflow.fade : null,
      maxLines: overFlowFade ?? false ? 1 : null,
      softWrap: overFlowFade ?? false ? false : null,
    );
  }
}

class IndexTitle extends StatelessWidget {
  final String? text;
  final Color? textColor;

  const IndexTitle(this.text, {super.key, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
          fontSize: DynamicFontSize.font21(context),
          color: textColor ?? GlobalColor.black,
          fontWeight: FontWeight.bold),
    );
  }
}

class IndexThumbTitle extends StatelessWidget {
  final String? text;
  final Color? textColor;

  const IndexThumbTitle(this.text, {super.key, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
          fontSize: DynamicFontSize.font25(context),
          color: textColor ?? GlobalColor.black,
          fontWeight: FontWeight.bold),
    );
  }
}

class IndexMinText extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final bool? overFlowFade;
  final int? maxLength;

  const IndexMinText(this.text, {super.key, this.textColor, this.overFlowFade, this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
          fontSize: DynamicFontSize.font17(context),
          color: textColor ?? GlobalColor.black),
      overflow: maxLength == null ? overFlowFade ?? false ? TextOverflow.fade : null: TextOverflow.ellipsis,
      maxLines: maxLength ?? (overFlowFade ?? false ? 1 : null),
      softWrap:  overFlowFade ?? false ? false : null,
    );
  }
}

class IndexMinTitle extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final bool? overFlowFade;

  const IndexMinTitle(this.text, {super.key, this.textColor, this.overFlowFade});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: DynamicFontSize.font17(context),
          color: textColor ?? GlobalColor.black),
      overflow: overFlowFade ?? false ? TextOverflow.fade : null,
      maxLines: overFlowFade ?? false ? 1 : null,
      softWrap: overFlowFade ?? false ? false : null,
    );
  }
}

class ScrollablePinchView extends ConsumerStatefulWidget {
  final Widget child;

  const ScrollablePinchView({super.key, required this.child});

  ConsumerState<ScrollablePinchView> createState() => _ScrollablePinchView();
}

class _ScrollablePinchView extends ConsumerState<ScrollablePinchView> {
  final List<int> events = [];
  bool _isPinch = false;

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => Listener(
            onPointerDown: (PointerEvent event) {
              events.add(event.pointer);
              final int pointers = events.length;

              if (pointers >= 2) {
                print('isPinching');
                setState(() => _isPinch = true);
              }
            },
            onPointerUp: (event) {
              events.clear();
              print('isPinching false');
              setState(() => _isPinch = false);
            },
            child: SingleChildScrollView(
                physics:
                    _isPinch ? NeverScrollableScrollPhysics() : ScrollPhysics(),
                child: InteractiveViewer(
                    minScale: 1.0, maxScale: 6.0, child: widget.child))));
  }
}

class PinchView extends StatelessWidget {
  final Widget child;

  const PinchView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(minScale: 1.0, maxScale: 6.0, child: child);
  }
}

class SearchBox extends ConsumerStatefulWidget {
  final String hint;
  final Function(String)? onSearch;
  final Color? backgroundColor;
  final Color? borderColor;
  final Function(String)? onChanged;

  const SearchBox(
      {super.key,
      required this.hint,
      this.onSearch,
      this.backgroundColor,
      this.borderColor,
      this.onChanged});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBox();
}

class _SearchBox extends ConsumerState<SearchBox> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onFieldSubmitted: widget.onSearch,
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
          filled: widget.backgroundColor == null ? false : true,
          fillColor: widget.backgroundColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          hintText: widget.hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
                color: widget.borderColor ?? GlobalColor.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
                color: widget.borderColor ?? GlobalColor.primaryColor),
          ),
          suffixIcon: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                widget.onSearch != null
                    ? widget.onSearch!(_controller.text)
                    : () {};
              },
              child: Icon(
                Icons.search,
                color: GlobalColor.primaryColor,
                size: 30,
              ))),
    );
  }
}

class CustomDropdown extends ConsumerWidget {
  final List<String> items;
  final int? selectedValue;
  final ValueChanged<int?> onChanged;
  final double? width;
  final double? height;
  final Color? bgColor;
  final String title; // 제목을 추가
  final bool isLoading;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.width,
    this.height = 40,
    this.bgColor,
    this.title = '',
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('isLoading $isLoading');

    return GestureDetector(
      onTap: !isLoading
          ? () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 450,
                            child: Scrollbar(
                              thumbVisibility: true, // 항상 보이도록 설정
                              thickness: 2,
                              radius: Radius.circular(10),
                              child: ListView(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 6),
                                shrinkWrap: true, // ListView의 크기를 내용에 맞게 조정
                                children: items.asMap().entries.map((entry) {
                                  return InkWell(
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        entry.value,
                                        style: TextStyle(
                                          fontSize:
                                              DynamicFontSize.font20(context),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      print('바꿀 값 ${entry.key}');
                                      // ref.read(statusProvider.notifier).setStatus(entry.key);
                                      onChanged(entry.key);
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ));
                  });
            }
          : () {
              print('you cannot touch');
            },
      child: Container(
        padding: EdgeInsets.only(right: 5, left: 15),
        height: height,
        decoration: BoxDecoration(
          color: GlobalColor.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              items[selectedValue ?? 0],
              style: TextStyle(
                fontSize: DynamicFontSize.font16(context),
                color: GlobalColor.darkGreyFontColor,
              ),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
