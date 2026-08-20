part of '../my_addresses_page.dart';

class _RemoveAddressBottomSheet extends StatelessWidget {
  const _RemoveAddressBottomSheet(this.location, this.onLocationRemoved);

  final DeleteLocationParams location;
  final void Function() onLocationRemoved;

  static Future<bool?> show(
    BuildContext context, {
    required DeleteLocationParams location,
    required void Function() onLocationRemoved,
  }) async => await showAppModalBottomSheet(
    context: context,
    child: BlocProvider.value(value: injector<MyAddressesCubit>(), child: _RemoveAddressBottomSheet(location, onLocationRemoved)),
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyAddressesCubit, MyAddressesState>(
      listenWhen: (previous, current) => previous.deleteAddressState != current.deleteAddressState,
      listener: (context, state) {
        if (state.deleteAddressState.isSuccess) {
          AppRouter.pop();
          AppToasts.success(context, message: appLocalizer.addressRemoved);
          onLocationRemoved();
        } else if (state.deleteAddressState.isFailure) {
          AppRouter.pop();
          AppToasts.error(context, message: state.deleteAddressState.errorMessage ?? '');
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
        child: Column(
          children: [
            AppSvgIcon(path: "", size: 64),
            SizedBox(height: 16),
            Text(appLocalizer.deleteAddressFromList, style: TextStyles.medium16.copyWith(color: AppColors.black)),
            SizedBox(height: 10),
            Text(appLocalizer.areYouSureYouWantToDeleteThisAddress, textAlign: TextAlign.center, style: TextStyles.regular14),
            SizedBox(height: 28),
            BlocSelector<MyAddressesCubit, MyAddressesState, Async<void>>(
              selector: (state) => state.deleteAddressState,
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: appLocalizer.disagree,
                        onPressed: () => AppRouter.pop(),
                        buttonColor: AppColors.primary50,
                        textStyle: TextStyles.bold16.copyWith(color: AppColors.primary),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: AppButton(
                        text: appLocalizer.agree,
                        buttonColor: AppColors.red700,
                        isLoading: state.isLoading,
                        textStyle: TextStyles.bold16.copyWith(color: Colors.white),
                        onPressed: () {
                          context.read<MyAddressesCubit>().deleteAddress(location);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
