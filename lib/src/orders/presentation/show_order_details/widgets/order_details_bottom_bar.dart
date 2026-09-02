part of '../show_order_details_page.dart';

const Color _kCancelButtonFill = Color(0xFFFEF5F4);

class _OrderDetailsBottomBar extends StatelessWidget {
  const _OrderDetailsBottomBar({required this.order});

  final OrderDetailsEntity order;

  @override
  Widget build(BuildContext context) {
    final Widget? content = _buildContent(context);
    if (content == null) return const SizedBox.shrink();

    return ColoredBox(
      color: AppColors.white,
      child: SafeArea(
        top: false,
        child: Padding(padding: const EdgeInsets.all( Dimensions.p16, ), child: content),
      ),
    );
  }

  Widget? _buildContent(BuildContext context) {
    switch (order.status) {
      case OrderStatusEnum.delivered:
        final bool canRate = order.ratedAt == null;
        if (!canRate) {
          return _OrderDetailsActionButton(
            label: appLocalizer.taxInvoice,
            backgroundColor: AppColors.white,
            textColor: AppColors.primary,
            borderColor: AppColors.primary,
          );
        }
        return Row(
          spacing: Dimensions.p12,
          children: [
            Expanded(
              child: _OrderDetailsActionButton(
                label: appLocalizer.taxInvoice,
                backgroundColor: AppColors.white,
                textColor: AppColors.primary,
                borderColor: AppColors.primary,
              ),
            ),
            Expanded(
              child: _OrderDetailsActionButton(
                label: appLocalizer.rateOrder,
                backgroundColor: AppColors.primary,
                textColor: AppColors.white,
                onTap: () => AddRatePage.show(context, order.id),
              ),
            ),
          ],
        );
      case OrderStatusEnum.neww:
        // return _OrderDetailsActionButton(label: appLocalizer.cancelOrder, backgroundColor: _kCancelButtonFill, textColor: AppColors.red500);
      case OrderStatusEnum.inProgress:
      case OrderStatusEnum.readyForDelivery:
      case OrderStatusEnum.onTheWay:
      case OrderStatusEnum.cancelled:
        return null;
    }
  }
}

class _OrderDetailsActionButton extends StatelessWidget {
  const _OrderDetailsActionButton({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    this.onTap,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: _kActionButtonHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.r16),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child: Text(
          label,
          style: TextStyles.semiBold18.copyWith(color: textColor, height: 1, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
