part of '../upsert_address_page.dart';

class _UpsertAddressFooter extends StatelessWidget {
  const _UpsertAddressFooter({required this.isEdit, required this.isDefault});

  final bool isEdit;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    final formCubit = context.read<UpsertAddressCubit>();
    return ColoredBox(
      color: _kPageFill,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Dimensions.p16, Dimensions.p24, Dimensions.p16, Dimensions.p16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isEdit && !isDefault) ...[
                BlocProvider(
                  create: (_) => injector<UpsertAddressCubit>(),
                  child: _UpsertAddressActionButton(
                    text: appLocalizer.setAsDefaultAddress,
                    buttonColor: _kTonalButtonFill,
                    textStyle: TextStyles.semiBold18.copyWith(color: AppColors.primary, height: 1, fontWeight: FontWeight.w600),
                    isEdit: isEdit,
                    onPressed: (cubit) {
                      cubit
                        ..updateParams(formCubit.state.params)
                        ..setAsDefaultAddress();
                    },
                  ),
                ),
                const SizedBox(height: Dimensions.p16),
              ],
              BlocProvider(
                create: (_) => injector<UpsertAddressCubit>(),
                child: _UpsertAddressActionButton(
                  text: isEdit ? appLocalizer.saveEdites : appLocalizer.saveAddress,
                  textStyle: TextStyles.semiBold18.copyWith(color: AppColors.white, height: 1, fontWeight: FontWeight.w600),
                  isEdit: isEdit,
                  onPressed: (cubit) {
                    if (formCubit.state.params.formKey.currentState!.validate()) {
                      cubit
                        ..updateParams(formCubit.state.params)
                        ..upsertAddress();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpsertAddressActionButton extends StatelessWidget {
  const _UpsertAddressActionButton({
    required this.text,
    required this.isEdit,
    required this.onPressed,
    this.buttonColor,
    this.textStyle,
  });

  final String text;
  final bool isEdit;
  final Color? buttonColor;
  final TextStyle? textStyle;
  final void Function(UpsertAddressCubit cubit) onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpsertAddressCubit, UpsertAddressState>(
      listenWhen: (previous, current) => previous.upsertAddressState != current.upsertAddressState,
      listener: (context, state) {
        if (state.upsertAddressState.isSuccess) {
          AppToasts.success(
            context,
            message: isEdit ? appLocalizer.addressUpdatedSuccessfully : appLocalizer.addressAddedSuccessfully,
          );
          MyAddressesSubscription.pushUpdate(NoParams());
          AppRouter.pop();
        } else if (state.upsertAddressState.isFailure) {
          AppToasts.error(context, message: state.upsertAddressState.errorMessage ?? '');
        }
      },
      builder: (context, state) {
        return AppButton(
          text: text,
          buttonColor: buttonColor,
          loadingColor: AppColors.primary,
          textStyle: textStyle,
          isLoading: state.upsertAddressState.isLoading,
          onPressed: () => onPressed(context.read<UpsertAddressCubit>()),
        );
      },
    );
  }
}
