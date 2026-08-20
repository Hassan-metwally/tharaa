import 'package:flutter/material.dart';

import '../../core.dart';
import 'app_theme.dart';

class DarkTheme extends AppTheme {
  const DarkTheme();

  @override
  String get name => "dark";

  @override
  ThemeMode get themeMode => ThemeMode.dark;

  @override
  Color get backgroundColor => throw UnimplementedError();

  @override
  Color get cardColor => throw UnimplementedError();

  @override
  Color get disableBorderColor => throw UnimplementedError();

  @override
  Color get disbaledColor => throw UnimplementedError();

  @override
  Color get dividerColor => throw UnimplementedError();

  @override
  Color get focusedBorderColor => primary300;

  @override
  Color get enabledBorderColor => throw UnimplementedError();

  @override
  Color get hintColor => throw UnimplementedError();

  @override
  Color get textColor => throw UnimplementedError();

  @override
  ThemeData get theme => ThemeData.dark();

  @override
  Color get appbarBorderColor => AppColors.white;

  // @override
  // ThemeData get theme => ThemeData().copyWith(
  //       brightness: Brightness.dark,
  //       scaffoldBackgroundColor: backgroundColor,
  //       disabledColor: primary50,
  //       unselectedWidgetColor: primary50,
  //       canvasColor: Colors.white,
  //       dividerColor: dividerColor,
  //       dividerTheme: DividerThemeData(
  //         color: dividerColor,
  //         thickness: .8,
  //       ),
  //       textTheme: ThemeData.light().primaryTextTheme.apply(
  //             bodyColor: text,
  //             displayColor: text,
  //             fontFamily: fontFamily,
  //           ),
  //       textSelectionTheme: TextSelectionThemeData(
  //         cursorColor: AppColors.primary,
  //         selectionColor: AppColors.primary.withAlpha(50),
  //         selectionHandleColor: AppColors.primary,
  //       ),
  //       cardTheme: CardThemeData(
  //         color: cardColor,
  //         surfaceTintColor: cardColor,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         clipBehavior: Clip.antiAlias,
  //       ),
  //       tooltipTheme: TooltipThemeData(
  //         triggerMode: TooltipTriggerMode.tap,
  //         padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
  //         textStyle: TextStyles.regular10.copyWith(color: text),
  //         textAlign: TextAlign.center,
  //         decoration: BoxDecoration(
  //           color: cardColor,
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //       ),
  //       dialogTheme: DialogThemeData(
  //         insetPadding: const EdgeInsets.all(20),
  //         backgroundColor: canvasBackgroundColor,
  //         surfaceTintColor: canvasBackgroundColor,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(24),
  //         ),
  //       ),
  //       popupMenuTheme: PopupMenuThemeData(
  //         surfaceTintColor: canvasBackgroundColor,
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  //       ),
  //       inputDecorationTheme: InputDecorationTheme(
  //         isDense: true,
  //         prefixIconColor: hintColor,
  //         suffixIconColor: hintColor,
  //         prefixIconConstraints:
  //             const BoxConstraints(minWidth: 40, minHeight: 46),
  //         suffixIconConstraints:
  //             const BoxConstraints(minWidth: 40, minHeight: 46),
  //         constraints: const BoxConstraints(minHeight: 44),
  //         hintStyle: TextStyles.regular12.copyWith(
  //           color: hintColor,
  //         ),
  //         labelStyle: TextStyles.regular14.copyWith(color: text),
  //         errorStyle: TextStyles.regular11.copyWith(color: error),
  //         contentPadding:
  //             const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  //         border: OutlineInputBorder(
  //           borderRadius: const BorderRadius.all(Radius.circular(32)),
  //           borderSide: BorderSide(
  //             color: borderColor,
  //           ),
  //         ),
  //         disabledBorder: OutlineInputBorder(
  //           borderRadius: const BorderRadius.all(Radius.circular(32)),
  //           borderSide: BorderSide(
  //             color: disableBorderColor,
  //           ),
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: const BorderRadius.all(Radius.circular(32)),
  //           borderSide: BorderSide(
  //             color: borderColor,
  //           ),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: const BorderRadius.all(Radius.circular(32)),
  //           borderSide: BorderSide(
  //             color: primary300,
  //           ),
  //         ),
  //         fillColor: canvasBackgroundColor,
  //         filled: true,
  //         errorBorder: OutlineInputBorder(
  //           borderRadius: const BorderRadius.all(Radius.circular(32)),
  //           borderSide: BorderSide(
  //             color: error,
  //           ),
  //         ),
  //         focusedErrorBorder: OutlineInputBorder(
  //           borderRadius: const BorderRadius.all(Radius.circular(32)),
  //           borderSide: BorderSide(
  //             color: error,
  //           ),
  //         ),
  //         errorMaxLines: 10,
  //         floatingLabelBehavior: FloatingLabelBehavior.never,
  //         floatingLabelStyle: TextStyles.regular14,
  //       ),
  //       checkboxTheme: CheckboxThemeData(
  //           visualDensity: VisualDensity.compact,
  //           checkColor: WidgetStateProperty.all(Colors.white),
  //           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(4),
  //           ),
  //           side: BorderSide(
  //             color: secondary600,
  //           )),
  //       colorScheme: ColorScheme(
  //         error: error,
  //         onError: error,
  //         primary: primary,
  //         brightness: Brightness.light,
  //         onPrimary: primary,
  //         secondary: primary,
  //         onSecondary: primary,
  //         surface: Colors.white,
  //         onSurface: Colors.white,
  //       ),
  //       cardColor: cardColor,
  //       appBarTheme: AppBarTheme(
  //         titleSpacing: 0,
  //         backgroundColor: canvasBackgroundColor,
  //         titleTextStyle: TextStyles.regular17.copyWith(color: text),
  //         elevation: .2,
  //         surfaceTintColor: canvasBackgroundColor,
  //       ),
  //       actionIconTheme: ActionIconThemeData(
  //         backButtonIconBuilder: (context) {
  //           return AppSvgIcon(
  //             path: 'assets/icons/arrow_right_ic.svg',
  //             isReversed: getLocaleTypeEnum == AppLanguageEnum.en,
  //           );
  //         },
  //       ),
  //       outlinedButtonTheme: OutlinedButtonThemeData(
  //         style: ButtonStyle(
  //           alignment: Alignment.center,
  //           minimumSize: WidgetStateProperty.all(const Size.fromHeight(50)),
  //           side: WidgetStateProperty.resolveWith<BorderSide>(
  //             (states) {
  //               if (states.contains(WidgetState.disabled)) {
  //                 return BorderSide(color: disableBorderColor);
  //               }
  //               return BorderSide(color: primary600);
  //             },
  //           ),
  //           surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
  //           shape: WidgetStateProperty.all(
  //             const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(
  //                 Radius.circular(50),
  //               ),
  //             ),
  //           ),
  //           backgroundColor: WidgetStateProperty.all(Colors.transparent),
  //           foregroundColor: WidgetStateProperty.all(Colors.transparent),
  //           textStyle: WidgetStateProperty.resolveWith<TextStyle>(
  //             (states) {
  //               if (states.contains(WidgetState.disabled)) {
  //                 return TextStyles.medium16
  //                     .copyWith(color: disableBorderColor);
  //               }
  //               return TextStyles.medium16.copyWith(color: primary600);
  //             },
  //           ),
  //           elevation: WidgetStateProperty.all(0),
  //           padding: WidgetStateProperty.all(
  //               const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
  //         ),
  //       ),
  //       scrollbarTheme: ScrollbarThemeData(
  //         thumbColor: WidgetStateProperty.all(primary),
  //       ),
  //       bottomSheetTheme: BottomSheetThemeData(
  //         backgroundColor: canvasBackgroundColor,
  //         surfaceTintColor: canvasBackgroundColor,
  //         dragHandleSize: const Size(60, 4),
  //         dragHandleColor: blue400,
  //         shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(20),
  //             topRight: Radius.circular(20),
  //           ),
  //         ),
  //         clipBehavior: Clip.antiAlias,
  //         elevation: 10,
  //         constraints: const BoxConstraints(minHeight: 100),
  //       ),
  //       listTileTheme: ListTileThemeData(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         textColor: const Color(0xff202020),
  //         minTileHeight: 54,
  //         selectedColor: const Color(0xff202020),
  //         titleTextStyle: TextStyles.medium14,
  //         subtitleTextStyle: TextStyles.regular14.copyWith(color: text1),
  //         selectedTileColor: const Color(0xffFBF5FE),
  //         tileColor: const Color(0xffF5F5F5),
  //         contentPadding:
  //             const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  //       ),
  //       radioTheme: RadioThemeData(
  //         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //         fillColor: WidgetStateProperty.resolveWith<Color>(
  //           (Set<WidgetState> states) {
  //             if (states.contains(WidgetState.disabled)) {
  //               return disableBorderColor;
  //             }
  //             return const Color(0xff870EFA);
  //           },
  //         ),
  //       ),
  //       elevatedButtonTheme: ElevatedButtonThemeData(
  //         style: ButtonStyle(
  //           alignment: Alignment.center,
  //           minimumSize: WidgetStateProperty.all(const Size(50, 52)),
  //           backgroundBuilder: (context, states, child) {
  //             final bool isDisabled = states.contains(WidgetState.disabled);
  //             final bgColorGradiant = isDisabled
  //                 ? AppColors.disableGradient
  //                 : AppColors.linearGradient1;
  //             return Container(
  //               decoration: BoxDecoration(gradient: bgColorGradiant),
  //               child: child,
  //             );
  //           },
  //           shape: WidgetStateProperty.all(
  //             const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(
  //                 Radius.circular(50),
  //               ),
  //             ),
  //           ),
  //           foregroundColor: WidgetStateProperty.resolveWith<Color>(
  //             (states) {
  //               if (states.contains(WidgetState.disabled)) {
  //                 return text2;
  //               }
  //               return Colors.white;
  //             },
  //           ),
  //           textStyle: WidgetStateProperty.resolveWith<TextStyle>(
  //             (states) {
  //               if (states.contains(WidgetState.disabled)) {
  //                 return TextStyles.medium16.copyWith(color: text2);
  //               }
  //               return TextStyles.medium16.copyWith(color: Colors.white);
  //             },
  //           ),
  //           elevation: WidgetStateProperty.all(.2),
  //           padding: WidgetStateProperty.all(
  //               const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
  //         ),
  //       ),
  //       datePickerTheme: DatePickerThemeData(
  //           cancelButtonStyle: OutlinedButton.styleFrom(
  //             alignment: Alignment.center,
  //             backgroundColor: Colors.white,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(8)),
  //             textStyle: TextStyles.medium14,
  //           ),
  //           confirmButtonStyle: FilledButton.styleFrom(
  //             alignment: Alignment.center,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(8)),
  //             textStyle: TextStyles.semiBold14,
  //           ),
  //           backgroundColor: canvasBackgroundColor,
  //           surfaceTintColor: canvasBackgroundColor,
  //           dividerColor: dividerColor,
  //           shadowColor: Colors.transparent,
  //           locale: getLocale,
  //           headerHeadlineStyle: TextStyles.bold14.copyWith(color: text),
  //           yearStyle: TextStyles.bold15.copyWith(color: text),
  //           dayStyle: TextStyles.medium14.copyWith(color: text),
  //           elevation: .4,
  //           yearBackgroundColor: WidgetStateProperty.resolveWith(
  //             (states) {
  //               if (states.contains(WidgetState.selected)) {
  //                 return primary50;
  //               }
  //               return null;
  //             },
  //           ),
  //           todayBackgroundColor: WidgetStateProperty.resolveWith(
  //             (states) {
  //               if (states.contains(WidgetState.selected)) {
  //                 return primary50;
  //               }
  //               return null;
  //             },
  //           ),
  //           dayBackgroundColor: WidgetStateProperty.resolveWith(
  //             (states) {
  //               if (states.contains(WidgetState.selected)) {
  //                 return primary50;
  //               }
  //               return null;
  //             },
  //           ),
  //           weekdayStyle: TextStyles.bold16.copyWith(color: text),
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(12))),
  //       textButtonTheme: TextButtonThemeData(
  //         style: TextButton.styleFrom(
  //           foregroundColor: primary,
  //         ),
  //       ),
  //       floatingActionButtonTheme: FloatingActionButtonThemeData(
  //         backgroundColor: blue600,
  //         shape: const CircleBorder(),
  //       ),
  //       iconButtonTheme: IconButtonThemeData(
  //         style: IconButton.styleFrom(
  //           padding: const EdgeInsets.all(6),
  //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //           // backgroundColor: tileColor,
  //         ),
  //       ),
  //     );
}
