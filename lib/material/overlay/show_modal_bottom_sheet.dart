import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/core.dart';

Future<T?> showAppModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  final bool isDismissible = true,
  final bool enableDrag = true,
  final bool scrollable = true,
  final bool hasTopInductor = true,
  final double indicatorToChildDistance = 18,
  final RouteSettings? routeSettings,
  final EdgeInsets padding = const EdgeInsets.only(left: 24, right: 24, bottom: 16),
  final Color? backgroundColor,
}) async {
  if (FocusManager.instance.primaryFocus?.hasPrimaryFocus == true) {
    FocusScope.of(context).requestFocus(FocusNode());
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
  return await showModalBottomSheet<T?>(
    context: context,
    isScrollControlled: true,
    enableDrag: enableDrag,
    useRootNavigator: true,
    isDismissible: isDismissible,
    routeSettings: routeSettings,
    backgroundColor: backgroundColor,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: padding,
        constraints: BoxConstraints(minHeight: 100, maxHeight: MediaQuery.of(context).size.height * .9),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (hasTopInductor)
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * .2,
                  height: 2,
                  margin: EdgeInsets.only(top: 8, bottom: indicatorToChildDistance),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.dividerColor),
                ),
              if (scrollable)
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        child,
                        SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                      ],
                    ),
                  ),
                )
              else
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(child: child),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

Future<T?> showAppTopModalSheet<T>({
  required BuildContext context,
  required Widget child,
  double? borderRadius,
  bool isDismissible = true,
  bool hasInductor = true,
  final bool scrollable = true,
  String? routeSettingsName,
  EdgeInsets? padding,
  Widget Function(BuildContext context)? header,
  Widget Function(BuildContext context)? footer,
}) async {
  if (FocusManager.instance.primaryFocus?.hasPrimaryFocus == true) {
    FocusScope.of(context).requestFocus(FocusNode());
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
  return await showGeneralDialog<T?>(
    context: context,
    barrierDismissible: isDismissible,
    barrierLabel: routeSettingsName ?? "showAppTopModalSheet",
    routeSettings: RouteSettings(name: routeSettingsName),
    pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
      return Align(
        alignment: Alignment.topCenter,
        child: Material(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // color: AppColors.canvasBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
          elevation: .7,
          child: Container(
            padding: padding,
            constraints: const BoxConstraints(
              minWidth: double.infinity,
              // maxHeight: MediaQuery.of(context).size.height * .8,
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  if (scrollable)
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            child,
                            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                          ],
                        ),
                      ),
                    )
                  else
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(child: child),
                          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                        ],
                      ),
                    ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * .3,
                    height: 3,
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.dividerColor),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1), // Slide from top
          end: const Offset(0, 0),
        ).animate(anim1),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
