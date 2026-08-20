import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../material/widgets/riyal_price_text.dart';
import '../../domain/enums/payment_methods_enum.dart';

class PaymentMethodButtomsheet extends StatefulWidget {
  const PaymentMethodButtomsheet({super.key, required this.totalPrice});
  final double totalPrice;

  static Future<PaymentMethodsEnum?> show({required BuildContext context, required double totalPrice}) async {
    return await showAppModalBottomSheet<PaymentMethodsEnum>(
      context: context,
      routeSettings: const RouteSettings(name: "_PaymentMethodButtomsheet"),
      child: PaymentMethodButtomsheet(totalPrice: totalPrice),
    );
  }

  @override
  State<PaymentMethodButtomsheet> createState() => _PaymentMethodButtomsheetState();
}

class _PaymentMethodButtomsheetState extends State<PaymentMethodButtomsheet> {
  PaymentMethodsEnum _selectedPaymentMethod = PaymentMethodsEnum.wallet;

  Widget _buildPaymentMethodTile(PaymentMethodsEnum paymentMethod) {
    final bool isSelected = _selectedPaymentMethod == paymentMethod;
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = paymentMethod),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary50 : AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.black50),
        ),
        child: Row(
          children: [
            AppSvgIcon(path: paymentMethod.icon, size: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                paymentMethod.title,
                style: TextStyles.medium16.copyWith(color: isSelected ? AppColors.primary : AppColors.black800),
              ),
            ),
            const SizedBox(width: 8),
            _PaymentMethodRadio(isSelected: isSelected),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        AppSvgIcon(path: "", size: 44, color: AppColors.primary),
        const SizedBox(height: 8),
        Text(appLocalizer.paymentMethod, style: TextStyles.bold18.copyWith(color: AppColors.black900)),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10.5),
          decoration: BoxDecoration(color: Color(0xFFF8F8F8), borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Text(appLocalizer.totalOrderPrice, style: TextStyles.light14.copyWith(color: AppColors.black800)),
              const SizedBox(width: 12),
              Expanded(
                child: RiyalPriceText(
                  price: widget.totalPrice.toString(),
                  priceTextStyle: TextStyles.regular14.copyWith(color: AppColors.black900),
                  currencyTextStyle: TextStyles.regular14.copyWith(color: AppColors.primary),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(appLocalizer.paymentMethod, style: TextStyles.regular14.copyWith(color: AppColors.black800)),
        ),
        const SizedBox(height: 8),
        _buildPaymentMethodTile(PaymentMethodsEnum.wallet),
        const SizedBox(height: 8),
        _buildPaymentMethodTile(PaymentMethodsEnum.electronicPay),
        // const SizedBox(height: 8),
        // _buildPaymentMethodTile(PaymentMethodsEnum.applePay),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: appLocalizer.confirmPayment,
                buttonColor: AppColors.primary,
                onPressed: () => AppRouter.pop(result: _selectedPaymentMethod),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton(
                text: appLocalizer.cancel,
                buttonColor: AppColors.black50,
                textStyle: TextStyles.medium16.copyWith(color: AppColors.black800),
                onPressed: () => AppRouter.pop(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PaymentMethodRadio extends StatelessWidget {
  const _PaymentMethodRadio({required this.isSelected});
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
        border: Border.all(color: isSelected ? AppColors.primary : AppColors.black200, width: 1.5),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(shape: BoxShape.circle, color: isSelected ? AppColors.primary : Colors.transparent),
      ),
    );
  }
}
