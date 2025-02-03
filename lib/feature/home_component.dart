import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rotary_flutter/util/logger.dart';

import '../util/fontSize.dart';
import '../util/global_color.dart';
import '../util/model/loadstate.dart';
import 'home/home_main_component.dart';
import 'myInfo/modify/my_info_modify_component.dart';

class LoadStateScaffold extends ConsumerStatefulWidget {
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? loadingBody;
  final Widget Function(dynamic) successBody;
  final Widget? errorBody;
  final Widget? floatingActionButton;

  final LoadState loadState;

  const LoadStateScaffold(
      {super.key,
      this.backgroundColor,
      this.appBar,
      required this.loadState,
      this.loadingBody,
      required this.successBody,
      this.errorBody,
      this.floatingActionButton});

  @override
  ConsumerState<LoadStateScaffold> createState() => _LoadStateScaffold();
}

class _LoadStateScaffold extends ConsumerState<LoadStateScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: widget.appBar,
      body: switch (widget.loadState) {
        Loading() => widget.loadingBody ?? placeHolder,
        Success() => widget.successBody((widget.loadState as Success).data),
        Error() => errorWidget(widget.loadState as Error, widget.errorBody),
        _ => const Placeholder()
      },
      floatingActionButton: widget.floatingActionButton,
    );
  }

  var placeHolder = const Center(
      child: CircularProgressIndicator(
    color: GlobalColor.primaryColor,
  ));

  Widget errorWidget(Error error, Widget? errorWidget) {
    Log.e(error.exception.toString(), isSuper: true);
    return widget.errorBody ?? widget.loadingBody ?? placeHolder;
  }
}

class LoadStateWidget<T> extends StatelessWidget {
  final Widget? Function()? loadingWidget;
  final Widget Function(T) successWidget;
  final Widget? Function(Object?)? errorWidget;
  final Widget? elseWidget;

  final LoadState loadState;

  const LoadStateWidget(
      {super.key,
      required this.loadState,
      this.loadingWidget,
      required this.successWidget,
      this.errorWidget,
      this.elseWidget});

  @override
  Widget build(BuildContext context) {
    const placeHolder = Center(
        child: CircularProgressIndicator(
      color: GlobalColor.primaryColor,
    ));

    return switch (loadState) {
      Loading() => loadingWidget != null ? loadingWidget!()! : placeHolder,
      Success() => successWidget((loadState as Success).data),
      Error() => errorWidget != null
          ? errorWidget!((loadState as Error).exception)!
          : loadingWidget != null
              ? loadingWidget!()!
              : placeHolder,
      _ => elseWidget ?? SizedBox()
    };
  }
}

Widget LoadStateWidgetFun<T>(
    {Widget? Function()? loadingWidget,
    required Widget Function(T) successWidget,
    Widget? Function(Object?)? errorWidget,
    Widget? elseWidget,
    required LoadState loadState,}) {
  const placeHolder = Center(
      child: CircularProgressIndicator(
    color: GlobalColor.primaryColor,
  ));

  return switch (loadState) {
    Loading() => loadingWidget != null ? loadingWidget()! : placeHolder,
    Success() => successWidget(loadState.data),
    Error() => errorWidget != null
        ? errorWidget(loadState.exception)!
        : loadingWidget != null
            ? loadingWidget()!
            : placeHolder,
    _ => elseWidget ?? SizedBox()
  };
}

void showDismissDialog(BuildContext context,
    {String? title,
    Function(bool, Object?)? onPopInvokedWithResult,
    TextEditingController? controller,
    String? hint,
    Widget? extraContents,
    TextInputType? keyboardType,
    TextInputType? subKeyboardType,
    List<TextInputFormatter>? textInputFormatter,
    List<TextInputFormatter>? subTextInputFormatter,
    Function()? onTap,
    required String buttonText,
    TextEditingController? subController,
    String? subHint,
    bool? subObscureText,
    Widget? subContent}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: onPopInvokedWithResult,
        child: Dialog(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    height: 20,
                    'asset/icons/logo.svg',
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ...extraContents != null
                      ? [extraContents, const SizedBox(height: 20)]
                      : [],
                  ...title != null
                      ? [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ]
                      : [],
                  ...(hint != null)
                      ? [
                          MyInfoModifyTextField(
                              indexTitle: hint,
                              indexController: controller,
                              keyboardType: keyboardType,
                              inputFormatters: textInputFormatter),
                          SizedBox(height: 20)
                        ]
                      : [],
                  ...(subController != null && subHint != null)
                      ? [
                          MyInfoModifyTextField(
                              indexTitle: subHint,
                              indexController: subController,
                              keyboardType: subKeyboardType,
                              obscureText: subObscureText,
                              inputFormatters: subTextInputFormatter),
                          SizedBox(height: 20),
                        ]
                      : [],
                  Row(mainAxisSize: MainAxisSize.max, children: [
                    Expanded(
                        child: InkWell(
                            onTap: onTap,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: GlobalColor.primaryColor,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              child: IndexTitle(
                                buttonText,
                                textColor: GlobalColor.white,
                              ),
                            )))
                  ]),
                  ...subContent != null
                      ? [
                          const SizedBox(height: 15),
                          subContent,
                          const SizedBox(height: 5)
                        ]
                      : []
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void loadStateFunction<T>(
    {required LoadState loadState,
    required Function(T) onSuccess,
    Function()? onLoading,
    Function(Object)? onError,
    Function()? onElse}) {

  if (loadState is Success<T>) {
    Log.d('success on', isSuper: true);
    onSuccess(loadState.data);
  } else if (loadState is Loading<T>) {
    Log.d('loading on', isSuper: true);
    (onLoading ?? () {})();
  } else if (loadState is Error<T>) {
    Log.e('${loadState.exception}', isSuper: true);
    (onError ?? () {})(loadState.exception);
  }else {
    (onElse ?? () {})();
  }
}

LoadState runCatching(LoadState Function() function,
    {required Function onSuccess, Function()? onFailure}) {
  late LoadState data;

  try {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var load = function();
      if (load is Success) {
        onSuccess();
      } else if (load is Error && onFailure != null) {
        onFailure();
      }
      data = load;
    });
  } catch (e) {
    if (onFailure != null) {
      data = Error(e);
    }
  }
  return data;
}

class CustomDialog extends StatelessWidget {
  final String title;
  final String? subTitle;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  final String confirmText;
  final String cancelText;

  const CustomDialog(
      {super.key,
      required this.title,
      this.subTitle,
      required this.onConfirm,
      required this.onCancel,
      required this.confirmText,
      required this.cancelText});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IndexText(
              title,
              textAlign: TextAlign.center,
            ),
            ...subTitle == null
                ? []
                : [
                    SizedBox(
                      height: 5,
                    ),
                    IndexText(
                      subTitle,
                      textColor: GlobalColor.primaryColor,
                    )
                  ],
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 120,
                  child: InkWell(
                    onTap: () {
                      onConfirm();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: GlobalColor.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: IndexMinText(
                        textColor: GlobalColor.white,
                        confirmText,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  child: InkWell(
                    onTap: () {
                      onCancel();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1, color: GlobalColor.greyFontColor)),
                      child: IndexMinText(
                        textColor: GlobalColor.black,
                        cancelText,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingWidget {
  static show(context, content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
            canPop: false,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Center(
                    child: Column(
                      // clipBehavior: Clip.none,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IndexMaxTitle(
                          content,
                          textColor: GlobalColor.white,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CircularProgressIndicator(
                          color: GlobalColor.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
