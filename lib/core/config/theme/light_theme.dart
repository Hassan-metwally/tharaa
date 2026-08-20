import 'package:flutter/material.dart';

import '../../core.dart';
import 'app_theme.dart';

class LightTheme extends AppTheme {
  const LightTheme();

  @override
  String get name => "light";

  @override
  ThemeMode get themeMode => ThemeMode.light;

  @override
  Color get backgroundColor => const Color(0xffFFFCFB);

  @override
  Color get cardColor => Colors.white;

  @override
  Color get disbaledColor => black100;

  @override
  Color get dividerColor => AppColors.black100;

  @override
  Color get focusedBorderColor => primary500;

  @override
  Color get enabledBorderColor => AppColors.black50;

  @override
  Color get disableBorderColor => AppColors.black50.withAlpha(125);

  @override
  Color get appbarBorderColor => AppColors.black50;
  @override
  Color get hintColor => AppColors.black300;

  @override
  Color get textColor => AppColors.black900;

  @override
  ThemeData get theme => ThemeData(fontFamily: fontFamily).copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: backgroundColor,
    disabledColor: primary50,
    unselectedWidgetColor: primary50,
    canvasColor: cardColor,
    dividerColor: primary50,
    dividerTheme: DividerThemeData(color: primary50, thickness: 1),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionColor: AppColors.primary.withAlpha(50),
      selectionHandleColor: AppColors.primary,
    ),
    textTheme: ThemeData.light().primaryTextTheme.apply(bodyColor: textColor, displayColor: textColor, fontFamily: fontFamily),
    cardTheme: CardThemeData(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
    ),
    tooltipTheme: TooltipThemeData(
      triggerMode: TooltipTriggerMode.tap,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      textStyle: TextStyles.regular10.copyWith(color: textColor),
      textAlign: TextAlign.center,
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(8)),
    ),
    dialogTheme: DialogThemeData(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: cardColor,
      surfaceTintColor: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    popupMenuTheme: PopupMenuThemeData(
      surfaceTintColor: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      prefixIconColor: hintColor,
      suffixIconColor: hintColor,
      prefixIconConstraints: const BoxConstraints(minWidth: 30, minHeight: 46),
      suffixIconConstraints: const BoxConstraints(minWidth: 30, minHeight: 46),
      constraints: const BoxConstraints(minHeight: 48),
      hintStyle: TextStyles.light12.copyWith(color: hintColor),
      labelStyle: TextStyles.light14.copyWith(color: textColor),
      errorStyle: TextStyles.light10.copyWith(color: error),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: enabledBorderColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: disableBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: enabledBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: focusedBorderColor),
      ),
      fillColor: Colors.white,
      filled: true,
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: error),
      ),
      errorMaxLines: 10,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      floatingLabelStyle: TextStyles.light14,
    ),
    checkboxTheme: CheckboxThemeData(
      visualDensity: VisualDensity.compact,
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary;
        } else {
          return Colors.transparent;
        }
      }),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      side: BorderSide(color: primary400),
    ),
    colorScheme: ColorScheme(
      error: error,
      onError: error,
      primary: primary,
      brightness: Brightness.light,
      onPrimary: primary,
      secondary: primary,
      onSecondary: primary,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    cardColor: cardColor,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyles.light16.copyWith(color: textColor),
      elevation: 1,
      surfaceTintColor: AppColors.backgroundColor,
      backgroundColor: AppColors.white,
    ),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) {
        return Icon(Icons.arrow_back, color: textColor);
      },
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.center,
        minimumSize: WidgetStateProperty.all(const Size.fromHeight(50)),
        side: WidgetStateProperty.resolveWith<BorderSide>((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: disableBorderColor);
          }
          return BorderSide(color: primary);
        }),
        surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)))),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        foregroundColor: WidgetStateProperty.all(Colors.transparent),
        textStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.disabled)) {
            return TextStyles.regular14.copyWith(color: disbaledColor);
          }
          return TextStyles.regular14.copyWith(color: primary);
        }),
        elevation: WidgetStateProperty.all(0),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(thumbColor: WidgetStateProperty.all(primary)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: cardColor, elevation: .8, shape: const CircleBorder()),
    switchTheme: SwitchThemeData(
      thumbColor: const WidgetStatePropertyAll(Colors.white),
      trackColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.green;
        } else {
          return AppColors.primary200;
        }
      }),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      trackOutlineWidth: const WidgetStatePropertyAll(0),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: cardColor,
      surfaceTintColor: cardColor,
      dragHandleSize: const Size(64, 2),
      dragHandleColor: dividerColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      clipBehavior: Clip.antiAlias,
      // elevation: 2,
      constraints: const BoxConstraints(minHeight: 100),
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textColor: const Color(0xff202020),
      minTileHeight: 54,
      selectedColor: const Color(0xff202020),
      titleTextStyle: TextStyles.medium14,
      subtitleTextStyle: TextStyles.regular14.copyWith(color: textColor),
      selectedTileColor: const Color(0xffFBF5FE),
      tileColor: const Color(0xffF5F5F5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    ),
    radioTheme: RadioThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return primary;
        } else {
          return black300;
        }
      }),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.center,
        minimumSize: WidgetStateProperty.all(const Size(50, 52)),
        shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)))),
        backgroundBuilder: (context, states, child) {
          final bool isDisabled = states.contains(WidgetState.disabled);
          final bgColor = isDisabled ? AppColors.disbaledColor : AppColors.primary;
          return Container(
            decoration: BoxDecoration(color: bgColor),
            child: child,
          );
        },
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return textColor;
          }
          return Colors.white;
        }),
        textStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.disabled)) {
            return TextStyles.regular16.copyWith(color: disbaledColor);
          }
          return TextStyles.regular16.copyWith(color: Colors.white);
        }),
        elevation: WidgetStateProperty.all(.2),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      cancelButtonStyle: OutlinedButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyles.medium14,
      ),
      confirmButtonStyle: FilledButton.styleFrom(
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyles.semiBold14,
      ),
      backgroundColor: cardColor,
      surfaceTintColor: cardColor,
      dividerColor: dividerColor,
      shadowColor: Colors.transparent,
      yearStyle: TextStyles.bold15,
      dayStyle: TextStyles.medium14,
      elevation: .4,
      yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary50;
        }
        return null;
      }),
      todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary50;
        }
        return null;
      }),
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary50;
        }
        return null;
      }),
      weekdayStyle: TextStyles.bold16,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: primary)),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(6),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        // backgroundColor: tileColor,
      ),
    ),
  );
}
