import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/core.dart';
import '../../../../../../../material/app_fail_widget.dart';
import '../../../../../../../material/shimmer/shimmer_effect_widget.dart';
import '../../../domain/entities/ad_entity.dart';

class AdsSliderWidget extends StatefulWidget {
  const AdsSliderWidget({required this.sliders, super.key});

  final List<AdEntity> sliders;

  @override
  State<AdsSliderWidget> createState() => _AdsSliderWidgetState();
}

class _AdsSliderWidgetState extends State<AdsSliderWidget> {
  final controller = CarouselSliderController();
  int _currentIndex = 0;
  bool get isLast => _currentIndex == widget.sliders.length - 1;
  int get totalCount => widget.sliders.length;

  @override
  Widget build(BuildContext context) {
    return (widget.sliders.isEmpty)
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CarouselSlider(
                  carouselController: controller,
                  options: CarouselOptions(
                    scrollPhysics: const ClampingScrollPhysics(),
                    autoPlay: true,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    height: 170,
                    onPageChanged: (index, _) {
                      _currentIndex = index;
                      setState(() {});
                    },
                  ),
                  items: List.generate(totalCount, (index) {
                    final slider = widget.sliders[index];
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 154,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(slider.image.path), fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              // gradient: LinearGradient(
                              //   begin: context.read<AppLanguageCubit>().isRtl ? Alignment.centerRight : Alignment.centerLeft,
                              //   end: context.read<AppLanguageCubit>().isRtl ? Alignment.centerLeft : Alignment.centerRight,
                              //   colors: [
                              //     AppColors.primary500,
                              //     AppColors.primary500.withOpacityPercent(50),
                              //     AppColors.primary500.withOpacityPercent(1),
                              //   ],
                              // ),
                            ),
                          ),
                        ),
                        Positioned.directional(
                          textDirection: context.read<AppLanguageCubit>().isRtl ? TextDirection.rtl : TextDirection.ltr,
                          top: 30,
                          start: 20,
                          child: SizedBox(
                            width: 170,
                            child: Text(widget.sliders[_currentIndex].title, style: TextStyles.bold14.copyWith(color: AppColors.white)),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                Positioned(
                  bottom: 20,
                  child: Row(
                    children: List.generate(totalCount, (index) {
                      final bool isSelected = index == _currentIndex;
                      return AnimatedContainer(
                        duration: Durations.medium2,
                        height: 6,
                        width: isSelected ? 30 : 6,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isSelected ? AppColors.white : AppColors.black50,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
  }
}

class AdsSliderLoadingWidget extends StatelessWidget {
  const AdsSliderLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primary100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary50, width: 5),
        ),
      ),
    );
  }
}

class AdsSliderErrorWidget extends StatelessWidget {
  final void Function() onRetry;

  const AdsSliderErrorWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: AppColors.black50,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: AppColors.black50, width: 5),
      ),
      child: AppFailWidget(isMini: true, onRetry: onRetry),
    );
  }
}
