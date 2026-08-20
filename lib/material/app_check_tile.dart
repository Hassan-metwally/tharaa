import 'package:flutter/material.dart';

import '../core/core.dart';

class AppCheckBoxTile extends StatelessWidget {
  final bool value;
  final void Function(bool? value)? onChanged;
  final Widget? child;
  final String? title;
  final Widget? subTitle;
  final EdgeInsetsGeometry? paddingInsets;
  final Color? unselectedColor;
  final bool? enabled;

  const AppCheckBoxTile({
    super.key,
    required this.value,
    this.onChanged,
    this.child,
    this.paddingInsets,
    this.unselectedColor,
    this.subTitle,
    this.title,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        listTileTheme: const ListTileThemeData(
          controlAffinity: ListTileControlAffinity.leading,
          horizontalTitleGap: 1,
          contentPadding: EdgeInsets.zero,
        ),
      ),
      child: CheckboxListTile(
        subtitle: subTitle,
        dense: true,
        checkboxScaleFactor: .8,
        value: value,
        enabled: enabled,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: paddingInsets,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        title: title != null ? Text(title ?? '', style: TextStyles.medium14) : child,
      ),
    );
  }
}
