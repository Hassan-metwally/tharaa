part of '../orders_page.dart';

const Color _kOrderCardFill = Color(0xFFF7F8FA);
const Color _kDateBadgeBorder = Color(0xFFD2D8E1);
const double _kDetailsArrowSize = 32;
const double _kDetailsArrowIconSize = 16;
const double _kDetailsArrowRotationDeg = 34.84;

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.entity});

  final OrderEntity entity;

  String get _orderNumber {
    final String number = entity.orderNumber.trim();
    if (number.isNotEmpty) return number;
    return '#ORD-${entity.id}';
  }

  String get _totalLabel => entity.total % 1 == 0 ? entity.total.toInt().toString() : entity.total.toString();

  String? get _createdAtLabel {
    final DateTime? createdAt = entity.createdAt;
    if (createdAt == null) return null;
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRouter.pushNamed(AppRoutes.showOrderDetailsPage, arguments: ShowOrderDetailsPage(id: entity.id));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(Dimensions.p16),
        decoration: BoxDecoration(color: _kOrderCardFill, borderRadius: BorderRadius.circular(Dimensions.r16)),
        child: Column(
          children: [
            Row(
              children: [
                if (_createdAtLabel != null) _OrderDateBadge(label: appLocalizer.orderCreationDate(_createdAtLabel!)),
                const Spacer(),
                _OrderStatusBadge(status: entity.status),
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
                _OrderTotal(amount: _totalLabel),
              ],
            ),
            const SizedBox(height: Dimensions.p12),
            Divider(height: 1, thickness: 1, color: AppColors.black200),
            const SizedBox(height: Dimensions.p12),
            const _OrderDetailsAction(),
          ],
        ),
      ),
    );
  }
}

class _OrderDateBadge extends StatelessWidget {
  const _OrderDateBadge({required this.label});

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
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.medium12.copyWith(color: AppColors.mutedText, height: 1),
          ),
          const SizedBox(width: 2),
          AppSvgIcon(path: AppIcons.calendarBulk, width: Dimensions.ic14, height: Dimensions.ic14),
        ],
      ),
    );
  }
}

class _OrderStatusBadge extends StatelessWidget {
  const _OrderStatusBadge({required this.status});

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

class _OrderTotal extends StatelessWidget {
  const _OrderTotal({required this.amount});

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

class _OrderDetailsAction extends StatelessWidget {
  const _OrderDetailsAction();

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    const double radians = _kDetailsArrowRotationDeg * math.pi / 180;

    return Row(
      children: [
        Expanded(
          child: Text(
            appLocalizer.orderDetails,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.semiBold16.copyWith(color: AppColors.primary, height: 1, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: Dimensions.p4),
        Container(
          width: _kDetailsArrowSize,
          height: _kDetailsArrowSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
          child: Transform.rotate(
            angle: isRtl ? radians : math.pi - radians,
            child: AppSvgIcon(path: AppIcons.arrowUpRight, width: _kDetailsArrowIconSize, height: _kDetailsArrowIconSize),
          ),
        ),
      ],
    );
  }
}
