import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core.dart';
import 'app_theme.dart';

class LightTheme extends AppTheme {
  const LightTheme();

  @override
  String get name => "light";

  @override
  ThemeMode get themeMode => ThemeMode.light;

  @override
  Color get backgroundColor => white;

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
      prefixIconColor: black400,
      suffixIconColor: black400,
      prefixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 56),
      suffixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 56),
      constraints: const BoxConstraints(minHeight: 56),
      hintStyle: TextStyles.regular14.copyWith(color: black400, height: 1.4),
      labelStyle: TextStyles.semiBold16.copyWith(color: textColor, fontWeight: FontWeight.w700, height: 1.3),
      helperStyle: TextStyles.regular12.copyWith(color: mutedText, height: 1.4),
      errorStyle: TextStyles.regular12.copyWith(color: error, height: 1.4),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppTheme.fieldRadius)),
        borderSide: BorderSide.none,
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppTheme.fieldRadius)),
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppTheme.fieldRadius)),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(AppTheme.fieldRadius)),
        borderSide: BorderSide(color: focusedBorderColor),
      ),
      fillColor: fieldFill,
      filled: true,
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(AppTheme.fieldRadius)),
        borderSide: BorderSide(color: error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(AppTheme.fieldRadius)),
        borderSide: BorderSide(color: error),
      ),
      helperMaxLines: 3,
      errorMaxLines: 10,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      floatingLabelStyle: TextStyles.semiBold16,
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
      titleTextStyle: TextStyles.semiBold20.copyWith(color: textColor),
      elevation: 1,
      surfaceTintColor: AppColors.backgroundColor,
      backgroundColor: AppColors.white,
      centerTitle: true,
    ),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) {
        final bool isRtl = Directionality.of(context) == TextDirection.rtl;
        return UnconstrainedBox(
          child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: Color(0xFFF7F8FA), shape: BoxShape.circle),
            child: Transform.flip(
              flipX: isRtl,
              child: SvgPicture.asset(AppIcons.arrowBack, width: 22, height: 22),
            ),
          ),
        );
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
