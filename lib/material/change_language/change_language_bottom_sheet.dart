import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../buttons/app_button.dart';
import '../media/svg_icon.dart';
import '../overlay/show_modal_bottom_sheet.dart';

const Color _kLightGray = Color(0xFFF7F8FA);
const Color _kSecondaryButtonText = Color(0xFF647691);
const double _kFlagWidth = 72;
const double _kFlagHeight = 48;
const double _kHeaderIconSize = 60;
const double _kHeaderIconInnerSize = 32;

class ChangeLanguageBottomSheet extends StatefulWidget {
  const ChangeLanguageBottomSheet._();

  @override
  State<ChangeLanguageBottomSheet> createState() => _ChangeLanguageBottomSheetState();

  static void show(BuildContext context) async {
    return await showAppModalBottomSheet(
      child: const ChangeLanguageBottomSheet._(),
      context: context,
      hasTopInductor: false,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
    );
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
    setState(() {
      currentLang = (selectedLang ?? AppLanguageEnum.en);
    });
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

  void _onGoBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: Dimensions.p32,
      children: [
        Column(
          spacing: Dimensions.p12,
          children: [
            const _HeaderIcon(),
            const _HeaderTexts(),
            Row(
              spacing: Dimensions.p12,
              children: [
                Expanded(
                  child: _LanguageOptionCard(
                    isSelected: currentLang == AppLanguageEnum.ar,
                    flagPath: AppImages.flagSaudi,
                    title: appLocalizer.arabicLanguage,
                    onTap: () => _onLanguageChange(AppLanguageEnum.ar),
                  ),
                ),
                Expanded(
                  child: _LanguageOptionCard(
                    isSelected: currentLang == AppLanguageEnum.en,
                    flagPath: AppImages.flagUsa,
                    title: appLocalizer.englishLanguage,
                    onTap: () => _onLanguageChange(AppLanguageEnum.en),
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          spacing: Dimensions.p12,
          children: [
            Expanded(
              child: AppButton(
                text: appLocalizer.apply,
                textStyle: TextStyles.semiBold18.copyWith(color: Colors.white),
                onPressed: _onSaveLanguage,
              ),
            ),
            Expanded(
              child: AppButton(
                text: appLocalizer.goBack,
                buttonColor: _kLightGray,
                textStyle: TextStyles.semiBold18.copyWith(color: _kSecondaryButtonText),
                onPressed: _onGoBack,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _kHeaderIconSize,
      height: _kHeaderIconSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: AppColors.primary50, shape: BoxShape.circle),
      child: AppSvgIcon(path: AppIcons.global, size: _kHeaderIconInnerSize, color: AppColors.primary),
    );
  }
}

class _HeaderTexts extends StatelessWidget {
  const _HeaderTexts();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Dimensions.p4,
      children: [
        Text(
          appLocalizer.changeLanguage,
          textAlign: TextAlign.center,
          style: TextStyles.semiBold18.copyWith(color: AppColors.black900, height: 1),
        ),
        Text(
          appLocalizer.changeLanguageSubtitle,
          textAlign: TextAlign.center,
          style: TextStyles.regular14.copyWith(color: AppColors.mutedText, height: 1),
        ),
      ],
    );
  }
}

class _LanguageOptionCard extends StatelessWidget {
  const _LanguageOptionCard({required this.isSelected, required this.flagPath, required this.title, required this.onTap});

  final bool isSelected;
  final String flagPath;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: Dimensions.p12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary50 : _kLightGray,
          borderRadius: BorderRadius.circular(Dimensions.r16),
          border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent),
        ),
        child: Column(
          spacing: Dimensions.p12,
          children: [
            _LanguageFlag(path: flagPath),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.medium12.copyWith(color: AppColors.black900, height: 1),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageFlag extends StatelessWidget {
  const _LanguageFlag({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.r8),
      child: SizedBox(
        width: _kFlagWidth,
        height: _kFlagHeight,
        child: AppSvgIcon(path: path, width: _kFlagWidth, height: _kFlagHeight, fit: BoxFit.cover),
      ),
    );
  }
}
