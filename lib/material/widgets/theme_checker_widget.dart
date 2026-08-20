import 'package:flutter/material.dart';

import '../../core/blocs/theme_notifier/theme_notifier.dart';

class ThemeCheckerWidget extends StatelessWidget {
  final Widget? lightChild;
  final Widget? darkchild;
  const ThemeCheckerWidget({super.key, this.lightChild, this.darkchild});

  @override
  Widget build(BuildContext context) {
    if (ThemeNotifier.instance.themeMode == ThemeMode.light) {
      return lightChild ?? const SizedBox();
    } else if (ThemeNotifier.instance.themeMode == ThemeMode.dark) {
      return darkchild ?? const SizedBox();
    } else if (ThemeNotifier.instance.themeMode == ThemeMode.system) {
      return lightChild ?? darkchild ?? const SizedBox();
    }
    return const SizedBox();
  }
}
