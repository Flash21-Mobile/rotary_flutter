import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:rotary_flutter/data/model/account/response/account_model.dart';
import 'package:rotary_flutter/util/logger.dart';
import 'package:rotary_flutter/util/model/account_grade_model.dart';

import '../../util/fontSize.dart';
import '../../util/global_color.dart';
import '../userSearch/list/user_search_list_component.dart';

class IndexText extends IndexInterface {
  const IndexText(super.data,
      {super.key,
      super.textColor,
      super.overFlowFade,
      super.maxLength,
      super.height,
      super.textAlign,
      super.defaultScale,
      super.decoration});

  @override
  double Function(BuildContext context) get fontSize =>
      (BuildContext context) => DynamicFontSize.font21(context);

  @override
  FontWeight get fontWeight => FontWeight.normal;
}

class IndexTitle extends IndexInterface {
  const IndexTitle(super.data,
      {super.key,
      super.textColor,
      super.overFlowFade,
      super.maxLength,
      super.height,
      super.textAlign,
      super.defaultScale,
      super.decoration});

  @override
  double Function(BuildContext context) get fontSize =>
      (BuildContext context) => DynamicFontSize.font21(context);

  @override
  FontWeight get fontWeight => FontWeight.bold;
}

class IndexTextTitle extends IndexInterface {
  const IndexTextTitle(super.data,
      {super.key,
      super.textColor,
      super.overFlowFade,
      super.maxLength,
      super.height,
      super.textAlign,
      super.defaultScale,
      super.decoration});

  @override
  double Function(BuildContext context) get fontSize =>
      (BuildContext context) => DynamicFontSize.font19(context);

  @override
  FontWeight get fontWeight => FontWeight.bold;
}

class IndexMaxTitle extends IndexInterface {
  const IndexMaxTitle(super.data,
      {super.key,
      super.textColor,
      super.overFlowFade,
      super.maxLength,
      super.height,
      super.textAlign,
      super.defaultScale,
      super.decoration});

  @override
  double Function(BuildContext context) get fontSize =>
      (BuildContext context) => DynamicFontSize.font25(context);

  @override
  FontWeight get fontWeight => FontWeight.bold;
}

class IndexMaxText extends IndexInterface {
  const IndexMaxText(super.data,
      {super.key,
      super.textColor,
      super.overFlowFade,
      super.maxLength,
      super.height,
      super.textAlign,
      super.defaultScale,
      super.decoration});

  @override
  double Function(BuildContext context) get fontSize =>
      (BuildContext context) => DynamicFontSize.font25(context);

  @override
  FontWeight get fontWeight => FontWeight.normal;
}

class IndexThumbTitle extends IndexInterface {
  const IndexThumbTitle(super.data,
      {super.key,
      super.textColor,
      super.overFlowFade,
      super.maxLength,
      super.height,
      super.textAlign,
      super.defaultScale,
      super.decoration});

  @override
  double Function(BuildContext context) get fontSize =>
      (BuildContext context) => DynamicFontSize.font30(context);

  @override
  FontWeight get fontWeight => FontWeight.bold;
}

class IndexMinText extends IndexInterface {
  const IndexMinText(super.data,
      {super.key,
      super.textColor,
      super.overFlowFade,
      super.maxLength,
      super.height,
      super.textAlign,
      super.defaultScale,
      super.decoration});

  @override
  double Function(BuildContext context) get fontSize =>
      (BuildContext context) => DynamicFontSize.font17(context);

  @override
  FontWeight get fontWeight => FontWeight.normal;
}

class IndexMinTitle extends IndexInterface {
  const IndexMinTitle(super.data,
      {super.key,
      super.textColor,
      super.overFlowFade,
      super.maxLength,
      super.height,
      super.textAlign,
      super.defaultScale,
      super.decoration});

  @override
  double Function(BuildContext context) get fontSize =>
      (BuildContext context) => DynamicFontSize.font17(context);

  @override
  FontWeight get fontWeight => FontWeight.bold;
}

class IndexMicroText extends IndexInterface {
  const IndexMicroText(super.data,
      {super.key,
      super.textColor,
      super.overFlowFade,
      super.maxLength,
      super.height,
      super.textAlign,
      super.defaultScale,
      super.decoration});

  @override
  double Function(BuildContext context) get fontSize =>
      (BuildContext context) => DynamicFontSize.font13(context);

  @override
  FontWeight get fontWeight => FontWeight.normal;
}

abstract class IndexInterface extends StatelessWidget {
  const IndexInterface(this.data,
      {super.key,
      required this.textColor,
      required this.overFlowFade,
      required this.maxLength,
      required this.height,
      required this.textAlign,
      required this.defaultScale,
      required this.decoration});

  final String? data;
  final Color? textColor;
  final bool? overFlowFade;
  final int? maxLength;
  final double? height;
  final TextAlign? textAlign;
  final bool? defaultScale;
  final TextDecoration? decoration;

  double Function(BuildContext) get fontSize;

  FontWeight get fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      data ?? '',
      textAlign: textAlign,
      textScaler: (defaultScale == true) ? TextScaler.noScaling : null,
      style: TextStyle(
          decoration: decoration,
          fontSize: fontSize(context),
          height: height,
          fontWeight: fontWeight,
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
  final NullableIndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final EdgeInsetsGeometry? padding;

  const ListPinchView(
      {super.key,
      required this.itemCount,
      this.padding,
      required this.itemBuilder});

  @override
  ConsumerState<ListPinchView> createState() => _ListPinchView();
}

class _ListPinchView extends ConsumerState<ListPinchView> {
  final List<int> events = [];
  bool _isPinch = false;

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
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
                  padding: widget.padding,
                  controller: _scrollController,
                  itemCount: widget.itemCount,
                  physics: _isPinch
                      ? NeverScrollableScrollPhysics()
                      : ScrollPhysics(),
                  itemBuilder: widget.itemBuilder,
                  separatorBuilder: (_, $) {
                    return Container(
                      height: 1,
                      color: GlobalColor.dividerColor,
                    );
                  },
                ))));
  }
}

class CustomScrollPinchView extends ConsumerStatefulWidget {
  final List<Widget> slivers;
  final EdgeInsetsGeometry? padding;

  const CustomScrollPinchView({super.key, required this.slivers, this.padding});

  @override
  ConsumerState<CustomScrollPinchView> createState() =>
      _CustomScrollPinchView();
}

class _CustomScrollPinchView extends ConsumerState<CustomScrollPinchView> {
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
            child: InteractiveViewer(
                minScale: 1.0,
                maxScale: 6.0,
                child: Padding(
                    padding: widget.padding ?? const EdgeInsets.all(0),
                    child: CustomScrollView(
                      slivers: widget.slivers,
                      physics: _isPinch
                          ? const NeverScrollableScrollPhysics()
                          : const ScrollPhysics(),
                    )))));
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
    var scrollController = ScrollController();

    return GestureDetector(
      onTap: !isLoading
          ? () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    if (onTap != null) {
                      onTap!();
                    } //todo r: cache manager vs sqlite
                    Future.delayed(Duration.zero, () {
                      Log.d('messaged hello: $selectedValue');
                      scrollController.jumpTo((((selectedValue ?? 1) * 51) < 300
                              ? 0
                              : (selectedValue ?? 1) * 51 - 300)
                          .toDouble());
                    });

                    return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                        alignment: Alignment.center,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                                color: GlobalColor.white,
                                child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Scrollbar(
                                        thumbVisibility: true, // 항상 보이도록 설정
                                        thickness: 2,
                                        radius: Radius.circular(10),
                                        child: ListView.separated(
                                            controller: scrollController,
                                            separatorBuilder: (context, index) {
                                              return Container(
                                                height: 1,
                                                color: GlobalColor.dividerColor,
                                              );
                                            },
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16),
                                            shrinkWrap: true,
                                            // ListView의 크기를 내용에 맞게 조정
                                            itemCount: items.length,
                                            itemBuilder: (context, index) {
                                              return Material(
                                                  color: GlobalColor.white,
                                                  child: InkWell(
                                                    child: Container(
                                                        height: 50,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Row(children: [
                                                          SizedBox(width: 6,),
                                                          SizedBox(
                                                            width: 39,
                                                            height: 50,
                                                            child: selectedValue == index ? Icon(Icons.check,size: 33,): null,
                                                          ),
                                                          Text(
                                                            items[index],
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  selectedValue ==
                                                                          index
                                                                      ? FontWeight
                                                                          .bold
                                                                      : FontWeight
                                                                          .normal,
                                                              fontSize:
                                                                  DynamicFontSize
                                                                      .font24(
                                                                          context),
                                                            ),
                                                          ),
                                                        ])),
                                                    onTap: () {
                                                      // ref.read(statusProvider.notifier).setStatus(entry.key);
                                                      onChanged(index);
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pop();
                                                    },
                                                  ));
                                            }),
                                      ),
                                      Material(
                                          color: GlobalColor.transparent,
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 24,
                                                    color: GlobalColor
                                                        .greyFontColor,
                                                  )))),
                                    ]))));
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
                fontWeight: FontWeight.w800,
                fontSize: DynamicFontSize.font17(context),
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

class CustomGradeDropdown extends ConsumerWidget {
  final List<AccountGradeModel> items;
  final int? selectedValue;
  final ValueChanged<int?> onChanged;
  final double? width;
  final double? height;
  final Color? bgColor;
  final String title; // 제목을 추가
  final bool isLoading;
  final VoidCallback? onTap;

  const CustomGradeDropdown({
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
    var scrollController = ScrollController();

    return GestureDetector(
      onTap: !isLoading
          ? () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    if (onTap != null) {
                      onTap!();
                    }
                    Future.delayed(Duration.zero, () {
                      Log.d('messaged hello: $selectedValue');
                      scrollController.jumpTo((((selectedValue ?? 1) * 51) < 300
                              ? 0
                              : (selectedValue ?? 1) * 51 - 300)
                          .toDouble());
                    });

                    return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                        alignment: Alignment.center,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                                color: GlobalColor.white,
                                child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Scrollbar(
                                        thumbVisibility: true, // 항상 보이도록 설정
                                        thickness: 2,
                                        radius: Radius.circular(10),
                                        child: ListView.separated(
                                            controller: scrollController,
                                            separatorBuilder: (context, index) {
                                              return Container(
                                                height: 1,
                                                color: GlobalColor.dividerColor,
                                              );
                                            },
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16),
                                            shrinkWrap: true,
                                            // ListView의 크기를 내용에 맞게 조정
                                            itemCount: items.length,
                                            itemBuilder: (context, index) {
                                              return Material(
                                                  color: GlobalColor.white,
                                                  child: InkWell(
                                                    child: Container(
                                                      height: 50,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child:Row(children: [
                                                        SizedBox(width: 6,),
                                                        SizedBox(
                                                          width: 39,
                                                          height: 50,
                                                          child: selectedValue == index ? Icon(Icons.check, size: 33,): null,
                                                        ),

                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              items[index]
                                                                  .grade,
                                                              style: TextStyle(
                                                                fontWeight: selectedValue ==
                                                                        index
                                                                    ? FontWeight
                                                                        .bold
                                                                    : FontWeight
                                                                        .normal,
                                                                fontSize:
                                                                    DynamicFontSize
                                                                        .font24(
                                                                            context),
                                                              ),
                                                            ),
                                                            SizedBox(width: 5),
                                                            items[index].date !=
                                                                    null
                                                                ? selectedValue ==
                                                                        index
                                                                    ? IndexMinTitle(formatDate(
                                                                        items[index]
                                                                            .date!))
                                                                    : IndexMicroText(
                                                                        textColor:
                                                                            GlobalColor
                                                                                .greyFontColor,
                                                                        formatDate(
                                                                            items[index].date!))
                                                                : SizedBox()
                                                          ])]),
                                                    ),
                                                    onTap: () {
                                                      // ref.read(statusProvider.notifier).setStatus(entry.key);
                                                      onChanged(index);
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pop();
                                                    },
                                                  ));
                                            }),
                                      ),
                                      Material(
                                          color: GlobalColor.transparent,
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 24,
                                                    color: GlobalColor
                                                        .greyFontColor,
                                                  )))),
                                    ]))));
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
              items[selectedValue ?? 0].grade,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: DynamicFontSize.font17(context),
                color: GlobalColor.darkGreyFontColor,
              ),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy. MM. dd');
    return formatter.format(date);
  }
}
