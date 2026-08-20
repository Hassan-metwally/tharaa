import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/inputs/app_text_form_field.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../material/toast/app_toast.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/params/address_params.dart';
import '../utils/products_subscription.dart';
import 'upsert_address_cubit.dart';

class UpssertAddressBottomSheet extends StatelessWidget {
  final LocationEntity? address;

  const UpssertAddressBottomSheet({super.key, this.address});

  static Future show(BuildContext context, {LocationEntity? address}) async {
    await showAppModalBottomSheet(
      context: context,
      padding: const EdgeInsets.only(top: 16),
      child: UpssertAddressBottomSheet(address: address),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<UpsertAddressCubit>()..setInitialParams(address),
      child: AddAddressBody(address: address),
    );
  }
}

class UpsertAddressPage extends StatelessWidget {
  final LocationEntity? address;

  const UpsertAddressPage({super.key, this.address});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<UpsertAddressCubit>()..setInitialParams(address),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appLocalizer.address, style: TextStyles.bold16),
          centerTitle: true,
          shadowColor: AppColors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: AddAddressBody(address: address),
          ),
        ),
      ),
    );
  }
}

class AddAddressBody extends StatefulWidget {
  final LocationEntity? address;
  const AddAddressBody({super.key, this.address});

  @override
  State<AddAddressBody> createState() => _AddAddressBodyState();
}

class _AddAddressBodyState extends State<AddAddressBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UpsertAddressCubit, UpsertAddressState, AddressParams>(
      selector: (state) {
        return state.params;
      },
      builder: (context, params) {
        final cubit = context.read<UpsertAddressCubit>();
        return Padding(
          padding: const EdgeInsets.all(20.0).copyWith(top: 0, bottom: 30),
          child: Form(
            key: params.formKey,
            child: Column(
              children: [
                AppSvgIcon(path: ""),
                const SizedBox(height: 12),
                Text(appLocalizer.addAddress, style: TextStyles.regular16.copyWith(color: AppColors.black800)),
                const SizedBox(height: 16),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(appLocalizer.pleaseEnterAddressDetails, style: TextStyles.light14.copyWith(color: AppColors.black800)),
                ),
                const SizedBox(height: 8),

                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: AppTextFormField(
                        label: appLocalizer.district,
                        hint: appLocalizer.enterDistrict,
                        validator: (text) => Validator(text).defaultValidator,
                        controller: params.district,
                        maxLength: 50,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppTextFormField(
                        label: appLocalizer.building,
                        hint: appLocalizer.enterBuildingNumber,
                        validator: (text) => Validator(text).defaultValidator,
                        maxLines: 1,
                        controller: params.building,
                        maxLength: 50,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                const SizedBox(height: 20),
                // SizedBox(height: 25),
                BlocConsumer<UpsertAddressCubit, UpsertAddressState>(
                  listener: (context, state) {
                    if (state.upsertAddressState.isSuccess) {
                      AppToasts.success(
                        context,
                        message: widget.address == null ? appLocalizer.addressAddedSuccessfully : appLocalizer.addressUpdatedSuccessfully,
                      );
                      MyAddressesSubscription.pushUpdate(NoParams());
                      AppRouter.pop();
                    } else if (state.upsertAddressState.isFailure) {
                      AppToasts.error(context, message: state.upsertAddressState.errorMessage ?? '');
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      text: widget.address != null ? appLocalizer.edit : appLocalizer.save,
                      isLoading: state.upsertAddressState.isLoading,
                      onPressed: () {
                        if (params.formKey.currentState!.validate()) {
                          cubit.upsertAddress();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
