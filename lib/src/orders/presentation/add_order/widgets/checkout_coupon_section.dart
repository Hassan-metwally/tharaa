part of '../add_order_page.dart';

class _CheckoutCouponSection extends StatelessWidget {
  const _CheckoutCouponSection({required this.controller, required this.isLoading, required this.onApply});

  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    return _CheckoutSection(
      title: appLocalizer.discountCoupon,
      child: SizedBox(
        height: _kCouponControlHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.productCardFill,
                  borderRadius: BorderRadius.circular(Dimensions.r16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16),
                  child: Center(
                    child: TextField(
                      controller: controller,
                      cursorColor: AppColors.primary,
                      style: TextStyles.regular14.copyWith(color: AppColors.black900, height: 1),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        isDense: true,
                        filled: false,
                        constraints: const BoxConstraints(),
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: appLocalizer.enterDiscountCoupon,
                        hintStyle: TextStyles.regular14.copyWith(color: AppColors.mutedText, height: 1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: Dimensions.p12),
            AppButton(
              isExpanded: false,
              isLoading: isLoading,
              text: appLocalizer.apply,
              textStyle: TextStyles.semiBold16.copyWith(color: AppColors.white, height: 1),
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16),
              onPressed: onApply,
            ),
          ],
        ),
      ),
    );
  }
}
