part of '../show_order_details_page.dart';

const Color _kDateBadgeBorder = Color(0xFFD2D8E1);

class _OrderInfoCard extends StatelessWidget {
  const _OrderInfoCard({required this.order});

  final OrderDetailsEntity order;

  String get _orderNumber {
    final String number = order.orderNumber.trim();
    if (number.isNotEmpty) return number;
    return 'ORD-${order.id}';
  }

  String get _totalLabel => order.total % 1 == 0 ? order.total.toInt().toString() : order.total.toString();

  String? get _createdAtLabel {
    final DateTime? createdAt = order.createdAt;
    if (createdAt == null) return null;
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimensions.p16),
      decoration: BoxDecoration(color: AppColors.productCardFill, borderRadius: BorderRadius.circular(Dimensions.r16)),
      child: Column(
        children: [
          Row(
            children: [
              if (_createdAtLabel != null) _OrderDetailsDateBadge(label: appLocalizer.orderCreationDate(_createdAtLabel!)),
              const Spacer(),
              _OrderDetailsStatusBadge(status: order.status),
            ],
          ),
          const SizedBox(height: Dimensions.p8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _orderNumber,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.semiBold14.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      appLocalizer.orderNumber,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.medium12.copyWith(color: AppColors.mutedText, height: 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Dimensions.p8),
              _OrderDetailsTotal(amount: _totalLabel),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderDetailsDateBadge extends StatelessWidget {
  const _OrderDetailsDateBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.p12, vertical: Dimensions.p8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(80),
        border: Border.all(color: _kDateBadgeBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSvgIcon(path: AppIcons.calendarBulk, width: Dimensions.ic14, height: Dimensions.ic14),
          const SizedBox(width: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.medium12.copyWith(color: AppColors.mutedText, height: 1),
          ),
        ],
      ),
    );
  }
}

class _OrderDetailsStatusBadge extends StatelessWidget {
  const _OrderDetailsStatusBadge({required this.status});

  final OrderStatusEnum status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.p8, vertical: Dimensions.p4),
      decoration: BoxDecoration(
        color: status.bgColor,
        borderRadius: BorderRadius.circular(80),
        border: Border.all(color: AppColors.white),
      ),
      child: Text(status.title, style: TextStyles.medium14.copyWith(color: status.titlColor, height: 1)),
    );
  }
}

class _OrderDetailsTotal extends StatelessWidget {
  const _OrderDetailsTotal({required this.amount});

  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          amount,
          style: TextStyles.semiBold22.copyWith(color: AppColors.primary, height: 1, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: Dimensions.p4),
        Icon(saudiRiyalSymbolIconData, size: Dimensions.ic18, color: AppColors.primary),
      ],
    );
  }
}
