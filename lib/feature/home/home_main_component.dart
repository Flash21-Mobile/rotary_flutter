import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/util/logger.dart';

import '../../util/fontSize.dart';
import '../../util/global_color.dart';
import '../userSearch/list/user_search_list_component.dart';

class IndexText extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final bool? overFlowFade;
  final TextAlign? textAlign;

  const IndexText(this.text,
      {super.key, this.textColor, this.overFlowFade, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      style: TextStyle(
          fontSize: DynamicFontSize.font21(context),
          //* MediaQuery.of(context).textScaleFactor,
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
          // * MediaQuery.of(context).textScaleFactor,,
          color: textColor ?? GlobalColor.black,
          fontWeight: FontWeight.bold),
    );
  }
}

class IndexThumbTitle extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final TextAlign? textAlign;

  const IndexThumbTitle(this.text, {super.key, this.textColor, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      style: TextStyle(
          fontSize: DynamicFontSize.font25(context),
          // * MediaQuery.of(context).textScaleFactor,
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

  const IndexMinText(this.text,
      {super.key, this.textColor, this.overFlowFade, this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
          fontSize: DynamicFontSize.font17(context),
          // * MediaQuery.of(context).textScaleFactor,
          color: textColor ?? GlobalColor.black),
      overflow: maxLength == null
          ? overFlowFade ?? false
              ? TextOverflow.fade
              : null
          : TextOverflow.ellipsis,
      maxLines: maxLength ?? (overFlowFade ?? false ? 1 : null),
      softWrap: overFlowFade ?? false ? false : null,
    );
  }
}

class IndexMinTitle extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final bool? overFlowFade;

  const IndexMinTitle(this.text,
      {super.key, this.textColor, this.overFlowFade});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: DynamicFontSize.font17(context),
          // * MediaQuery.of(context).textScaleFactor,
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

class ListPinchView extends ConsumerStatefulWidget {
  final List<int?>? items;
  final Function(int) indexNum;

  const ListPinchView({super.key, required this.items, required this.indexNum});

  @override
  ConsumerState<ListPinchView> createState() => _ListPinchView();
}

class _ListPinchView extends ConsumerState<ListPinchView> {
  final List<int> events = [];
  bool _isPinch = false;
  GlobalKey itemKey = GlobalKey();

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

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
            child: InteractiveViewer(
                minScale: 1.0,
                maxScale: 6.0,
                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: widget.items?.length ?? 0,
                  physics: _isPinch
                      ? NeverScrollableScrollPhysics()
                      : ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return FutureImage(
                        itemKey: index == 0 ? itemKey : null,
                   Future.value(widget.items?[index]));
                  },
                  separatorBuilder: (_, $) {
                    return Container(
                      height: 1,
                      color: GlobalColor.dividerColor,
                    );
                  },
                ))));
  }

  void _scrollListener() {
    final position = _scrollController.position;
    final viewportHeight = position.viewportDimension;

    // 화면의 중앙 위치
    final centerPosition = position.pixels + viewportHeight / 2;

    // 가장 많이 보이는 아이템 계산
    final visibleItemIndex = (centerPosition /
            ((itemKey.currentContext?.findRenderObject()) as RenderBox)
                .size
                .height)
        .floor();

    // widget.indexNum을 가장 자연스러운 아이템 번호로 호출
    widget.indexNum(visibleItemIndex);
  }
}

class PageablePinchView extends ConsumerStatefulWidget {
  final List<int?>? items;
  final Function(int)? onPageChanged;

  const PageablePinchView({super.key, required this.items, this.onPageChanged});

  @override
  ConsumerState<PageablePinchView> createState() => _PageablePinchView();
}

class _PageablePinchView extends ConsumerState<PageablePinchView> {
  final List<int> events = [];
  bool _isPinch = false;

  late double scale;

  @override
  void initState() {
    scale = 1.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Log.d('scale: $scale');
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
            child: PageView.builder(
                onPageChanged: widget.onPageChanged,
                itemCount: widget.items?.length,
                physics:
                    _isPinch ? NeverScrollableScrollPhysics() : ScrollPhysics(),
                itemBuilder: (context, index) {
                  return InteractiveViewer(
                      minScale: 1.0,
                      maxScale: 6.0,
                      child: FutureImage(
                      Future.value(widget.items?[index]),
                      ));
                })));
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
  final FocusNode? focusNode;

  const SearchBox(
      {super.key,
      required this.hint,
      this.onSearch,
      this.focusNode,
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
      focusNode: widget.focusNode,
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
  final VoidCallback? onTap;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.width,
    this.height = 40,
    this.bgColor,
    this.title = '',
    this.onTap,
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
                    if (onTap != null) {
                      onTap!();
                    }
                    return Container(
                        decoration: BoxDecoration(
                          color: GlobalColor.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Scrollbar(
                            thumbVisibility: true, // 항상 보이도록 설정
                            thickness: 2,
                            radius: Radius.circular(10),
                            child: ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16),
                                shrinkWrap: true, // ListView의 크기를 내용에 맞게 조정
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return Material(
                                      color: GlobalColor.white,
                                      child: InkWell(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 21),
                                          child: Text(
                                            items[index],
                                            style: TextStyle(
                                              fontSize: DynamicFontSize.font20(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          // ref.read(statusProvider.notifier).setStatus(entry.key);
                                          onChanged(index);
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        },
                                      ));
                                }),
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
