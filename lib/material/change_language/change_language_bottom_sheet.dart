// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../media/svg_icon.dart';
import '../overlay/show_modal_bottom_sheet.dart';

class ChangeLanguageBottomSheet extends StatefulWidget {
  const ChangeLanguageBottomSheet._();

  @override
  State<ChangeLanguageBottomSheet> createState() => _ChangeLanguageBottomSheetState();

  static void show(BuildContext context) async {
    return await showAppModalBottomSheet(child: const ChangeLanguageBottomSheet._(), context: context);
  }
}

class _ChangeLanguageBottomSheetState extends State<ChangeLanguageBottomSheet> {
  AppLanguageEnum currentLang = AppLanguageEnum.en;

  AppLanguageEnum get savedLanguage => AppLanguageCubit.of(context).state.langCode;

  @override
  void initState() {
    currentLang = savedLanguage;
    super.initState();
  }

  void _onLanguageChange(AppLanguageEnum? selectedLang) {
    currentLang = (selectedLang ?? AppLanguageEnum.en);
    _onSaveLanguage();
  }

  void _onSaveLanguage() async {
    if (savedLanguage != currentLang) {
      await AppLanguageCubit.of(context).changeLanguage(currentLang);
    }
    if (mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
    if (mounted && savedLanguage != currentLang) {
      AppAuthenticationBloc.of(context).add(const AuthRestartEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppSvgIcon(path: ""),
        const SizedBox(height: 24),
        Text(appLocalizer.changeLanguage, style: TextStyles.bold16),
        const SizedBox(height: 24),
        _Tile(
          isSeleted: currentLang == AppLanguageEnum.ar,
          icon: "",
          onTap: () => _onLanguageChange(AppLanguageEnum.ar),
          title: "اللغة العربية",
        ),
        Divider(color: AppColors.black50, height: 7),
        _Tile(isSeleted: currentLang == AppLanguageEnum.en, icon: "", onTap: () => _onLanguageChange(AppLanguageEnum.en), title: "English"),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.isSeleted, required this.onTap, required this.title, required this.icon});
  final bool isSeleted;
  final VoidCallback onTap;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      selected: isSeleted,
      title: Text(title),
      tileColor: AppColors.white,
      selectedTileColor: AppColors.primary50,
      shape: isSeleted
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: AppColors.primary, width: 1.5),
            )
          : RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      leading: Container(
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(4)),
        child: AppSvgIcon(path: icon),
      ),
      trailing: isSeleted
          ? Radio(value: true, groupValue: true, onChanged: (value) {})
          : Radio(value: false, groupValue: true, onChanged: (value) {}, fillColor: WidgetStateProperty.all(AppColors.black300)),
    );
  }
}
