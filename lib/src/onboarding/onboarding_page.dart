import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../../material/change_language/change_language_bottom_sheet.dart';
import '../../material/media/app_image.dart';

const Color _kMutedText = Color(0xFF6E829F);
const Color _kIndicatorInactive = Color(0xFFBCC6D3);
const double _kDesignWidth = 375;
const double _kDesignHeight = 812;

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;

  List<_OnboardingSlide> get _slides => [
    _OnboardingSlide(
      imagePath: AppImages.userOnboarding1,
      title: appLocalizer.userOnBoardingTitle1,
      subtitle: appLocalizer.userOnBoardingSubTitle1,
      gradientStart: const Color(0xFFDDF3F7),
      overlayStart: const Color(0xFFDDF3F7),
      stickerPath: AppImages.onboardingSticker1,
      stickerTint: const Color(0xFFDEF3F7),
      heroWidth: 453,
      heroHeight: 400,
      heroTop: 86,
    ),
    _OnboardingSlide(
      imagePath: AppImages.userOnboarding2,
      title: appLocalizer.userOnBoardingTitle2,
      subtitle: appLocalizer.userOnBoardingSubTitle2,
      gradientStart: const Color(0xFFFEEAFE),
      overlayStart: const Color(0xFFFEEAFE),
      stickerPath: AppImages.onboardingSticker2,
      stickerTint: const Color(0xFFF9D5F9),
      heroWidth: 416,
      heroHeight: 385,
      heroTop: 96,
    ),
    _OnboardingSlide(
      imagePath: AppImages.userOnboarding3,
      title: appLocalizer.userOnBoardingTitle3,
      subtitle: appLocalizer.userOnBoardingSubTitle3,
      gradientStart: const Color(0xFFF0FECF),
      overlayStart: const Color(0xFFF3FFE4),
      stickerPath: AppImages.onboardingSticker3,
      stickerTint: const Color(0xFFE7FFC7),
      heroWidth: 423,
      heroHeight: 423,
      heroTop: 123,
    ),
  ];

  int get _kOnbordingPageCount => _slides.length;
  bool get getIsLastPage => _currentPage == _kOnbordingPageCount - 1;

  void _onNext() {
    if (getIsLastPage) {
      _onFinish();
    } else {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _onFinish() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    AppAuthenticationBloc.of(context).add(const OnFinishWalkThrowEvent());
  }

  @override
  Widget build(BuildContext context) {
    final _OnboardingSlide slide = _slides[_currentPage];
    final MediaQueryData media = MediaQuery.of(context);
    final Size size = media.size;
    final double sx = size.width / _kDesignWidth;

    double heroW = slide.heroWidth * sx;
    double heroH = slide.heroHeight * sx;
    double heroTop = slide.heroTop * sx;
    final double bottomBlock = 300 * sx;
    final double maxHeroH = size.height - bottomBlock - heroTop;
    if (maxHeroH > 0 && heroH > maxHeroH) {
      final double k = maxHeroH / heroH;
      heroW *= k;
      heroH *= k;
    }
    final double heroLeft = (size.width - heroW) / 2;
    final double overlayH = 389 * (size.height / _kDesignHeight);
    final double bottomPad = math.max(44 * sx, media.padding.bottom + 10 * sx);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: AnimatedContainer(
          duration: Durations.medium4,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [slide.gradientStart, Colors.white]),
          ),
          child: ClipRect(
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: Durations.medium4,
                  curve: Curves.easeInOut,
                  top: heroTop,
                  left: heroLeft,
                  width: heroW,
                  height: heroH,
                  child: AnimatedSwitcher(
                    duration: Durations.medium2,
                    reverseDuration: Durations.medium4,
                    child: _HeroImage(key: ValueKey(_currentPage), path: slide.imagePath, width: heroW, height: heroH),
                  ),
                ),
                Positioned(
                  left: -40,
                  right: -40,
                  bottom: -40,
                  height: overlayH + 80,
                  child: IgnorePointer(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30, tileMode: TileMode.decal),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [slide.overlayStart, Colors.white],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16 * sx,
                  right: 16 * sx,
                  bottom: bottomPad,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AnimatedSwitcher(
                        duration: Durations.medium4,
                        reverseDuration: Durations.medium4,
                        child: _CopyBlock(
                          key: ValueKey(_currentPage),
                          title: slide.title,
                          subtitle: slide.subtitle,
                          stickerPath: slide.stickerPath,
                          stickerTint: slide.stickerTint,
                          scale: sx,
                        ),
                      ),
                      SizedBox(height: 24 * sx),
                      _FooterRow(currentPage: _currentPage, pageCount: _kOnbordingPageCount, onNext: _onNext, scale: sx),
                    ],
                  ),
                ),
                Positioned(
                  top: media.padding.top + 20 * sx,
                  left: 10 * sx,
                  right: 10 * sx,
                  child: _HeaderWidget(onSkip: _onFinish),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingSlide {
  const _OnboardingSlide({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.gradientStart,
    required this.overlayStart,
    required this.stickerPath,
    required this.stickerTint,
    required this.heroWidth,
    required this.heroHeight,
    required this.heroTop,
  });

  final String imagePath;
  final String title;
  final String subtitle;
  final Color gradientStart;
  final Color overlayStart;
  final String stickerPath;
  final Color stickerTint;
  final double heroWidth;
  final double heroHeight;
  final double heroTop;
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({super.key, required this.path, required this.width, required this.height});

  final String path;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AppImage(path: path, width: width, height: height, cacheImage: true, fit: BoxFit.contain);
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({required this.onSkip});

  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onSkip,
          behavior: HitTestBehavior.opaque,
          child: Text(
            appLocalizer.skip,
            style: TextStyles.semiBold16.copyWith(color: _kMutedText, fontWeight: FontWeight.w600, height: 1),
          ),
        ),
        GestureDetector(
          onTap: () {
            ChangeLanguageBottomSheet.show(context);
          },
          behavior: HitTestBehavior.opaque,
          child: BlocBuilder<AppLanguageCubit, AppLanguageState>(
            builder: (context, state) {
              return Text(
                appLocalizer.languageName,
                style: TextStyles.semiBold16.copyWith(color: _kMutedText, fontWeight: FontWeight.w600, height: 1),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CopyBlock extends StatelessWidget {
  const _CopyBlock({
    super.key,
    required this.title,
    required this.subtitle,
    required this.stickerPath,
    required this.stickerTint,
    required this.scale,
  });

  final String title;
  final String subtitle;
  final String stickerPath;
  final Color stickerTint;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = TextStyle(
      fontFamily: AppFonts.mainFont,
      fontWeight: FontWeight.w600,
      fontSize: 34 * scale,
      height: 1.3,
      letterSpacing: 0,
      color: AppColors.black900,
    );

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 182 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: title, style: titleStyle),
                WidgetSpan(
                  alignment: PlaceholderAlignment.bottom,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: 4 * scale),
                    child: _TitleSticker(path: stickerPath, tint: stickerTint, scale: scale),
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 12 * scale),
          Text(
            subtitle,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: AppFonts.mainFont,
              fontWeight: FontWeight.w500,
              fontSize: 18 * scale,
              height: 1,
              letterSpacing: 0,
              color: _kMutedText,
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleSticker extends StatelessWidget {
  const _TitleSticker({required this.path, required this.tint, required this.scale});

  final String path;
  final Color tint;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52 * scale,
      height: 46 * scale,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 21 * scale,
            child: Container(
              width: 52 * scale,
              height: 25 * scale,
              decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(80 * scale)),
            ),
          ),
          Positioned(
            left: 1 * scale,
            top: 0,
            child: AppImage(path: path, width: 46 * scale, height: 38 * scale, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}

class _FooterRow extends StatelessWidget {
  const _FooterRow({required this.currentPage, required this.pageCount, required this.onNext, required this.scale});

  final int currentPage;
  final int pageCount;
  final VoidCallback onNext;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _PageProgressInductor(currentPage: currentPage, count: pageCount, scale: scale),
        const Spacer(),
        _OnboardingCtaButton(step: currentPage, onTap: onNext, scale: scale),
      ],
    );
  }
}

class _PageProgressInductor extends StatelessWidget {
  const _PageProgressInductor({required this.currentPage, required this.count, required this.scale});

  final int currentPage;
  final int count;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (int index) {
        final bool isSelected = index == currentPage;
        return AnimatedContainer(
          duration: Durations.medium2,
          height: 4 * scale,
          width: (isSelected ? 30 : 20) * scale,
          margin: EdgeInsetsDirectional.only(start: index == 0 ? 0 : 4 * scale),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20 * scale),
            color: isSelected ? AppColors.primary500 : _kIndicatorInactive,
          ),
        );
      }),
    );
  }
}

class _OnboardingCtaButton extends StatelessWidget {
  const _OnboardingCtaButton({required this.step, required this.onTap, required this.scale});

  final int step;
  final VoidCallback onTap;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final List<String> labels = [appLocalizer.next, appLocalizer.next, appLocalizer.startNow];
    final String label = labels[step.clamp(0, labels.length - 1)];

    return Material(
      color: AppColors.primary500,
      elevation: 0,
      shadowColor: Colors.transparent,
      borderRadius: BorderRadius.circular(16 * scale),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16 * scale),
        child: SizedBox(
          width: 150 * scale,
          height: 50 * scale,
          child: Center(
            child: AnimatedSwitcher(
              duration: Durations.medium4,
              child: Text(
                label,
                key: ValueKey(label),
                style: TextStyle(
                  fontFamily: AppFonts.mainFont,
                  fontWeight: FontWeight.w600,
                  fontSize: 18 * scale,
                  height: 1,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
