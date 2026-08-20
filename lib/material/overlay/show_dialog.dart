import 'package:flutter/material.dart';

import '../../core/core.dart';

Future<T?> showAppDialog<T>({
  required BuildContext context,
  required Widget child,
  bool isDismissible = true,
  bool useRootNavigator = true,
  String? headerText,
  Widget? headerWidget,
  TextStyle headerStyle = TextStyles.regular16,
  AlignmentGeometry openAlign = Alignment.center,
  double maxWidth = 300,
  final String routeName = "showAppDialog",
}) async {
  return await showGeneralDialog<T?>(
    context: context,
    barrierDismissible: isDismissible,
    barrierLabel: routeName,
    routeSettings: RouteSettings(name: routeName),
    useRootNavigator: useRootNavigator,
    pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
      return _DialogShape(maxWidth: maxWidth, headerText: headerText, headerStyle: headerStyle, headerWidget: headerWidget, child: child);
    },
    transitionBuilder: (context, anim1, anim2, child) {
      if (openAlign == Alignment.center || openAlign == AlignmentDirectional.center) {
        return FadeTransition(opacity: Tween<double>(begin: 0.0, end: 1.0).animate(anim1), child: child);
      }
      return SlideTransition(
        position: Tween<Offset>(begin: getBeingOffsetAccordingDirection(openAlign), end: const Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}

Offset getBeingOffsetAccordingDirection(AlignmentGeometry align) {
  if (align == Alignment.topCenter || align == AlignmentDirectional.topCenter) {
    return const Offset(0, -1);
  } else if (align == Alignment.topRight) {
    return const Offset(1, -1);
  } else if (align == Alignment.topLeft) {
    return const Offset(-1, -1);
  } else if (align == Alignment.centerLeft) {
    return const Offset(-1, 0);
  } else if (align == Alignment.centerRight) {
    return const Offset(1, 0);
  } else if (align == Alignment.bottomCenter || align == AlignmentDirectional.bottomCenter) {
    return const Offset(0, 1);
  } else if (align == Alignment.bottomLeft) {
    return const Offset(-1, 1);
  } else if (align == Alignment.bottomRight) {
    return const Offset(1, 1);
  } else if (align == AlignmentDirectional.centerEnd) {
    if (isLTR) {
      return const Offset(-1, 0);
    } else {
      return const Offset(1, 0);
    }
  } else if (align == AlignmentDirectional.centerStart) {
    if (!isLTR) {
      return const Offset(-1, 0);
    } else {
      return const Offset(1, 0);
    }
  }
  return const Offset(0, -1);
}

TextDirection get appDirectionality {
  final context = appNavigatorKey.currentContext;
  if (context != null && context.mounted) {
    return Directionality.of(context);
  }
  return TextDirection.ltr;
}

bool get isLTR => appDirectionality == TextDirection.ltr;

class _DialogShape extends StatelessWidget {
  const _DialogShape({required this.maxWidth, this.headerText, this.headerWidget, required this.headerStyle, required this.child});
  final double maxWidth;
  final String? headerText;
  final TextStyle headerStyle;
  final Widget? headerWidget;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SafeArea(
                child: Container(
                  constraints: BoxConstraints(minHeight: 100, minWidth: 268, maxWidth: maxWidth),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (headerText?.isNotEmpty == true || headerWidget != null) const SizedBox(height: 16),
                      if (headerText?.isNotEmpty == true)
                        Text(headerText ?? '', textAlign: TextAlign.center, style: headerStyle)
                      else
                        ?headerWidget,
                      if (headerText?.isNotEmpty == true || headerWidget != null)
                        Container(width: double.infinity, height: 2, color: AppColors.primary600, margin: const EdgeInsets.only(top: 10)),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20), child: child),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
