part of '../add_order_page.dart';

class _CheckoutOptionChip extends StatelessWidget {
  const _CheckoutOptionChip({required this.label, required this.isSelected, required this.onTap, this.iconPath});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    final Color fill = isSelected ? AppColors.primary50 : AppColors.productCardFill;
    final Color textColor = isSelected ? AppColors.black900 : AppColors.mutedText;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: _kChipHeight,
        padding: const EdgeInsetsDirectional.only(start: Dimensions.p8, end: Dimensions.p16),
        decoration: BoxDecoration(color: fill, borderRadius: BorderRadius.circular(Dimensions.r16)),
        child: Row(
          children: [
            if (iconPath != null) ...[
              AppSvgIcon(
                path: iconPath!,
                width: Dimensions.ic18,
                height: Dimensions.ic18,
                color: isSelected ? AppColors.black900 : const Color(0xFF8B9BB2),
              ),
              const SizedBox(width: Dimensions.p4),
            ],
            Expanded(
              child: Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.medium12.copyWith(color: textColor, height: 1),
              ),
            ),
            _CheckoutRadio(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _CheckoutRadio extends StatelessWidget {
  const _CheckoutRadio({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kRadioSize,
      height: _kRadioSize,
      child: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        size: 24,
        color: isSelected ? AppColors.primary : const Color(0xFF8B9BB2),
      ),
    );
  }
}
