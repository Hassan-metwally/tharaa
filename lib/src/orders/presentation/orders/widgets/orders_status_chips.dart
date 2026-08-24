part of '../orders_page.dart';

const Color _kChipFill = Color(0xFFF7F8FA);

class _OrdersStatusChips extends StatelessWidget {
  const _OrdersStatusChips({required this.selected, required this.onSelected});

  final OrderStatusEnum? selected;
  final ValueChanged<OrderStatusEnum?> onSelected;

  @override
  Widget build(BuildContext context) {
    final int itemCount = OrderStatusEnum.values.length + 1;
    final bool isAllSelected = selected == null;

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16),
        itemCount: itemCount,
        separatorBuilder: (_, _) => const SizedBox(width: Dimensions.p12),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _OrderStatusChip(label: appLocalizer.all, isSelected: isAllSelected, onTap: () => onSelected(null));
          }
          final OrderStatusEnum status = OrderStatusEnum.values[index - 1];
          return _OrderStatusChip(label: status.title, isSelected: selected == status, onTap: () => onSelected(status));
        },
      ),
    );
  }
}

class _OrderStatusChip extends StatelessWidget {
  const _OrderStatusChip({required this.label, required this.isSelected, required this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(Dimensions.p8),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: isSelected ? AppColors.primary : _kChipFill, borderRadius: BorderRadius.circular(Dimensions.r8)),
        child: Text(label, style: TextStyles.medium14.copyWith(color: isSelected ? AppColors.white : AppColors.mutedText, height: 1)),
      ),
    );
  }
}
