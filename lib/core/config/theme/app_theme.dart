import 'package:flutter/material.dart';

import '../../blocs/theme_notifier/theme_notifier.dart';
import '../../core.dart';

Color getThemeColor({Color? lightColor, Color? darkColor}) {
  switch (ThemeNotifier.instance.themeMode) {
    case ThemeMode.system:
    case ThemeMode.light:
      return lightColor ?? Colors.transparent;
    case ThemeMode.dark:
      return darkColor ?? Colors.transparent;
  }
}

T getGenericTheme<T>({required T lightColor, required T darkColor}) {
  switch (ThemeNotifier.instance.themeMode) {
    case ThemeMode.system:
    case ThemeMode.light:
      return lightColor;
    case ThemeMode.dark:
      return darkColor;
  }
}

abstract class AppTheme {
  const AppTheme();
  abstract final String name;
  abstract final ThemeMode themeMode;
  abstract final ThemeData theme;
  final String fontFamily = AppFonts.mainFont;

  /// Common Used Colors For Material Design
  ///
  abstract final Color backgroundColor;
  abstract final Color cardColor;
  abstract final Color dividerColor;
  abstract final Color disbaledColor;

  abstract final Color focusedBorderColor;
  abstract final Color enabledBorderColor;
  abstract final Color disableBorderColor;
  abstract final Color appbarBorderColor;

  abstract final Color textColor;
  abstract final Color hintColor;

  final Color fieldFill = const Color(0xFFF5F6F8);
  final Color mutedText = const Color(0xFF6E829F);
  final Color chipText = const Color(0xFF4E5C71);
  final Color oldPriceColor = const Color(0xFF8B9BB2);
  final Color productCardFill = const Color(0xFFF7F8FA);
  final Color offersCardFill = const Color(0xFFFFFFFF);
  static const double fieldRadius = 16;

  BoxShadow get boxShadow => BoxShadow(color: Colors.black.withOpacityPercent(8), blurRadius: 4);

  LinearGradient get primaryGradiant => LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [primary500, primary500.withOpacityPercent(50), primary500.withOpacityPercent(1)],
  );

  LinearGradient get disableGradient =>
      LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [black50, black100]);

  LinearGradient get greyGradient =>
      const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xff999999), Color(0xff333333)]);

  /// APP DESIGN SYSTEM COLORS
  ///
  Color get primary => primary500;
  Color get grey => primary500;
  final Color primary50 = const Color(0xffFDF5E7);
  final Color primary100 = const Color(0xffF9DFB6);
  final Color primary200 = const Color(0xffF6D092);
  final Color primary300 = const Color(0xffF2BB61);
  final Color primary400 = const Color(0xffF0AD42);
  final Color primary500 = const Color(0xffEC9913);
  final Color primary600 = const Color(0xffD78B11);
  final Color primary700 = const Color(0xffA86D0D);
  final Color primary800 = const Color(0xff82540A);
  final Color primary900 = const Color(0xff634008);
  final Color primary950 = Colors.black;

  Color get secondary => secondary500;
  final Color secondary50 = const Color(0xffFBF5EA);
  final Color secondary100 = const Color(0xffF7EBD4);
  final Color secondary200 = const Color(0xffEED6AA);
  final Color secondary300 = const Color(0xffE6C27F);
  final Color secondary400 = const Color(0xffDDAD55);
  final Color secondary500 = const Color(0xffD9A441);
  final Color secondary600 = const Color(0xffAA7A22);
  final Color secondary700 = const Color(0xff805C19);
  final Color secondary800 = const Color(0xff553D11);
  final Color secondary900 = const Color(0xff2B1F08);

    Color get black => black900;
  final Color black50 = const Color(0xFFFFFFFF);
  final Color black100 = const Color(0xFFF8F8F8);
  final Color black200 = const Color(0xFFE9E9E9);
  final Color black300 = const Color(0xFFD6D6D6);
  final Color black400 = const Color(0xFF969696);
  final Color black500 = const Color(0xFF737373);
  final Color black600 = const Color(0xFF545454);
  final Color black700 = const Color(0xFF404040);
  final Color black800 = const Color(0xFF272727);
  final Color black900 = const Color(0xFF181818);

  Color get blue => blue600;
  final Color blue50 = const Color(0xffE6E6EA);
  final Color blue100 = const Color(0xffB1B1BF);
  final Color blue200 = const Color(0xff8C8BA0);
  final Color blue300 = const Color(0xff575575);
  final Color blue400 = const Color(0xff36355A);
  final Color blue500 = const Color(0xff040231);
  final Color blue600 = const Color(0xff04022D);
  final Color blue700 = const Color(0xff030123);
  final Color blue800 = const Color(0xff02011B);
  final Color blue900 = const Color(0xff020115);

  Color get error => red500;
  final Color red50 = const Color(0xFFFCEAEA);
  final Color red100 = const Color(0xFFF4BFBD);
  final Color red200 = const Color(0xFFEFA09D);
  final Color red300 = const Color(0xFFE87470);
  final Color red400 = const Color(0xFFE45955);
  final Color red500 = const Color(0xFFDD302A);
  final Color red600 = const Color(0xFFC92C26);
  final Color red700 = const Color(0xFF9D221E);
  final Color red800 = const Color(0xFF7A1A17);
  final Color red900 = const Color(0xFF5D1412);

  final Color warning50 = const Color(0xFFFCF5E9);
  final Color warning100 = const Color(0xFFF7DFBA);
  final Color warning200 = const Color(0xFFF3D099);
  final Color warning300 = const Color(0xFFEDBA6A);
  final Color warning400 = const Color(0xFFE9AD4D);
  final Color warning500 = const Color(0xFFE49821);
  final Color warning600 = const Color(0xFFCF8A1E);
  final Color warning700 = const Color(0xFFA26C17);
  final Color warning800 = const Color(0xFF7D5412);
  final Color warning900 = const Color(0xFF60400E);

  final Color success50 = const Color(0xFFE7F2ED);
  final Color success100 = const Color(0xFFB4D7C6);
  final Color success200 = const Color(0xFF8FC4AA);
  final Color success300 = const Color(0xFF5CA983);
  final Color success400 = const Color(0xFF3D986B);
  final Color success500 = const Color(0xFF0C7E46);
  final Color success600 = const Color(0xFF0B7340);
  final Color success700 = const Color(0xFF095932);
  final Color success800 = const Color(0xFF074527);
  final Color success900 = const Color(0xFF05351D);

  final Color white = const Color(0xFFFFFFFF);
  final Color white100 = const Color(0xFFFBFBFB);

  final Color green = const Color(0xff067B00);
  final Color greenTransparent = const Color(0x14067B00);
  final Color greenTransparent2 = const Color.fromARGB(49, 45, 218, 56);

  final Color skyBlue = const Color(0xff0066C5);
  final Color skyBlueTransparent = const Color(0xFFF6F8FF);

  final Color orange = const Color(0xffE8AF00);
  final Color orangeTransparent = const Color(0x14E8AF00);

  final Color terquoise = const Color(0xff07A49C);
  final Color terquoiseTransparent = const Color(0x1407A49C);

  final Color b14119 = const Color(0xffB14119);
  final Color b14119Transparent = const Color(0x14B14119);
}
