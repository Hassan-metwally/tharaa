import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../../../material/app_select_location.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/inputs/app_text_form_field.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/toast/app_toast.dart';
import '../../../google_maps/domain/entities/address_entity.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/params/address_params.dart';
import '../../domain/usecases/delete_location_use_case.dart';
import '../utils/products_subscription.dart';
import '../widgets/remove_address_bottom_sheet.dart';
import 'upsert_address_cubit.dart';

part 'widgets/upsert_address_footer.dart';
part 'widgets/upsert_address_header.dart';

const Color _kPageFill = Color(0xFFFFFFFF);
const Color _kCardFill = Color(0xFFF7F8FA);
const Color _kDeleteFill = Color(0xFFFEF5F4);
const Color _kTonalButtonFill = Color(0xFFFCF5E9);
const double _kActionSize = 48;

class UpssertAddressBottomSheet extends StatelessWidget {
  final LocationEntity? address;

  const UpssertAddressBottomSheet({super.key, this.address});

  static Future show(BuildContext context, {LocationEntity? address}) {
    return Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<void>(builder: (_) => UpsertAddressPage(address: address)));
  }

  @override
  Widget build(BuildContext context) {
    return UpsertAddressPage(address: address);
  }
}

class UpsertAddressPage extends StatelessWidget {
  final LocationEntity? address;

  const UpsertAddressPage({super.key, this.address});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<UpsertAddressCubit>()..setInitialParams(address),
      child: _UpsertAddressView(address: address),
    );
  }
}

class _UpsertAddressView extends StatelessWidget {
  const _UpsertAddressView({this.address});

  final LocationEntity? address;

  bool get _isEdit => address != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kPageFill,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(_isEdit ? appLocalizer.editAddress : appLocalizer.addAddressPageTitle),
        actions: [
          if (_isEdit)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: Dimensions.p16),
              child: Center(
                child: _DeleteAddressButton(
                  onTap: () => RemoveAddressBottomSheet.show(
                    context,
                    location: DeleteLocationParams(id: address!.id),
                    onLocationRemoved: () {
                      MyAddressesSubscription.pushUpdate(NoParams());
                      AppRouter.pop();
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
      body: BlocSelector<UpsertAddressCubit, UpsertAddressState, AddressParams>(
        selector: (state) => state.params,
        builder: (context, params) {
          final cubit = context.read<UpsertAddressCubit>();
          return Form(
            key: params.formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(Dimensions.p16, Dimensions.p12, Dimensions.p16, Dimensions.p16),
                    child: Column(
                      children: [
                        AppSelectLocationWidget(
                          mapLocation: params.lat != 0 || params.lng != 0 || params.address.isNotEmpty
                              ? MapAddressEntity(address: params.address, lat: params.lat, lng: params.lng)
                              : null,
                          lable: appLocalizer.address,
                          hint: appLocalizer.enterAddressLocationOnMap,
                          onSelect: (value) {
                            cubit.updateParams(params.copyWith(lat: value.lat, lng: value.lng, address: value.address));
                          },
                        ),
                        const SizedBox(height: Dimensions.p16),
                        AppTextFormField(
                          label: appLocalizer.addressTitle,
                          hint: appLocalizer.addressNameHint,
                          labelTextStyle: TextStyles.semiBold14.copyWith(color: AppColors.black900, height: 1),
                          hintTextStyle: TextStyles.regular14.copyWith(color: AppColors.oldPriceColor, height: 1),
                          inputTextStyle: TextStyles.regular14.copyWith(color: AppColors.black900, height: 1),
                          validator: (text) => Validator(text).defaultValidator,
                          controller: params.building,
                          maxLength: 50,
                          maxLines: 1,
                          hasCounter: true,
                          margin: EdgeInsets.zero,
                          filled: true,
                          fillColor: _kCardFill,
                          contentPadding: const EdgeInsets.symmetric(horizontal: Dimensions.p16, vertical: 14),
                        ),
                        const SizedBox(height: Dimensions.p16),
                        AppTextFormField(
                          label: appLocalizer.addressDetails,
                          hint: appLocalizer.addressDetailsHint,
                          labelTextStyle: TextStyles.semiBold14.copyWith(color: AppColors.black900, height: 1),
                          hintTextStyle: TextStyles.regular14.copyWith(color: AppColors.oldPriceColor, height: 1),
                          inputTextStyle: TextStyles.regular14.copyWith(color: AppColors.black900, height: 1),
                          validator: (text) => Validator(text).defaultValidator,
                          controller: params.district,
                          maxLength: 50,
                          maxLines: 1,
                          hasCounter: true,
                          margin: EdgeInsets.zero,
                          filled: true,
                          fillColor: _kCardFill,
                          contentPadding: const EdgeInsets.symmetric(horizontal: Dimensions.p16, vertical: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                _UpsertAddressFooter(isEdit: _isEdit, isDefault: address?.isDefault ?? false),
              ],
            ),
          );
        },
      ),
    );
  }
}
