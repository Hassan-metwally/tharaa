import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../material/toast/app_toast.dart';
import '../../domain/entities/address_entity.dart';
import '../maps_main_cubit.dart';
import '../maps_main_state.dart';
import '../search/maps_search_page.dart';

class MapsAppBarWidget extends StatelessWidget {
  const MapsAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onDoubleTap: () {},
      onLongPress: () {},
      child: SafeArea(
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: 8.0),
                  child: Icon(Icons.arrow_back_ios, color: AppColors.black800),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, FadeTransitionRoute(child: (context) => MapsSearchPage())).then((value) {
                      if (context.mounted && value != null && value is MapAddressEntity) {
                        MapsMainCubit.of(context).setLocationAddressData(value);
                      }
                    });
                  },
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 50),
                    alignment: AlignmentDirectional.centerStart,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: BlocConsumer<MapsMainCubit, MapsMainState>(
                      listenWhen: (previous, current) => previous.locationState != current.locationState,
                      listener: (context, state) {
                        if (state.locationState.isFailure) {
                          AppToasts.error(context, message: appLocalizer.failedToGetLocationDetails);
                        }
                      },
                      buildWhen: (previous, current) => previous.locationState != current.locationState,
                      builder: (context, state) {
                        final locationState = state.locationState;
                        final initialAddress = locationState.data?.address;
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                initialAddress ?? appLocalizer.searchForAddress,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.medium14.copyWith(
                                  color: initialAddress != null ? AppColors.black800 : AppColors.black800,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (locationState.isLoading)
                              SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 3))
                            else
                              Icon(Icons.search, color: AppColors.black800, size: 20),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
