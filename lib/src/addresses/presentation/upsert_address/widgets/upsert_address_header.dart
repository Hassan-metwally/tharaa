part of '../upsert_address_page.dart';

class _DeleteAddressButton extends StatelessWidget {
  const _DeleteAddressButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: _kActionSize,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.p10, vertical: Dimensions.p8),
        decoration: BoxDecoration(color: _kDeleteFill, borderRadius: BorderRadius.circular(80)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(appLocalizer.delete, style: TextStyles.medium12.copyWith(color: AppColors.red500, height: 1)),
            const SizedBox(width: Dimensions.p4),
            AppSvgIcon(path: AppIcons.trash, width: Dimensions.ic18, height: Dimensions.ic18),
          ],
        ),
      ),
    );
  }
}
