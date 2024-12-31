import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rotary_flutter/util/logger.dart';

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

  final LoadState loadState;

  const LoadStateScaffold({super.key,
    this.backgroundColor,
    this.appBar,
    required this.loadState,
    this.loadingBody,
    required this.successBody,
    this.errorBody});

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
        });
  }

  var placeHolder = const Center(child: CircularProgressIndicator(color: GlobalColor.primaryColor,));

  Widget errorWidget(Error error, Widget? errorWidget) {
    Log.e(error.exception.toString(), isSuper: true);
    return widget.errorBody ?? widget.loadingBody ?? placeHolder;
  }
}

class LoadStateWidget extends StatelessWidget {
  final Widget? loadingWidget;
  final Widget Function(dynamic) successWidget;
  final Widget? errorWidget;

  final LoadState loadState;

  const LoadStateWidget({super.key,
    required this.loadState,
    this.loadingWidget,
    required this.successWidget,
    this.errorWidget});

  @override
  Widget build(BuildContext context) {
    const placeHolder = Center(
        child: CircularProgressIndicator(
          color: GlobalColor.primaryColor,
        ));

    return switch (loadState) {
      Loading() => loadingWidget ?? placeHolder,
      Success() => successWidget((loadState as Success).data),
      Error() => errorWidget ?? loadingWidget ?? placeHolder,
      _ => const Placeholder()
    };
  }
}

void showDismissDialog(BuildContext context, {
  Function(bool, Object?)? onPopInvokedWithResult,
  required TextEditingController controller,
  required String hint,
  TextInputType? keyboardType,
  List<TextInputFormatter>? textInputFormatter,
  Function()? onTap,
  required String buttonText,
  TextEditingController? subController,
  String? subHint,
}) {
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
                MyInfoModifyTextField(
                    indexTitle: hint,
                    indexController: controller,
                    keyboardType: keyboardType,
                    inputFormatters: textInputFormatter),
                SizedBox(height: 20),
                ...(subController != null && subHint != null)
                    ? [
                  MyInfoModifyTextField(
                      indexTitle: subHint,
                      indexController: subController,
                      keyboardType: keyboardType,
                      obscureText: true,
                      inputFormatters: textInputFormatter),
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
              ],
            ),
          ),
        ),
      );
    },
  );
}

void loadStateFunction(LoadState loadState,
    {required Function(dynamic) onSuccess, Function(Object)? onError}) {
  if (loadState is Success) {
    Log.d('success on', isSuper: true);
    onSuccess(loadState.data);
  } else if (loadState is Error) {
    Log.e('${loadState.exception}', isSuper: true);
    (onError ?? () {})(loadState.exception);
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
