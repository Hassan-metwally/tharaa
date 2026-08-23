import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/ads/presentation/ads/ads_cubit.dart';
import '../../../../core/di/di.dart';
import 'widgets/ads_slider_widget.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<AdsCubit>()..getAllAds(),
      child: BlocBuilder<AdsCubit, AdsState>(
        builder: (context, state) {
          if (state.getAllAdsState.isLoading) {
            return const AdsSliderLoadingWidget();
          } else if (state.getAllAdsState.isFailure) {
            return AdsSliderErrorWidget(
              onRetry: () {
                context.read<AdsCubit>().getAllAds();
              },
            );
          } else if (state.getAllAdsState.isSuccess) {
            final ads = state.getAllAdsState.data ?? [];
            return AdsSliderWidget(sliders: ads);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
