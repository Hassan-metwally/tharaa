part of '../contact_us_page.dart';

class _ContactUsTabSwitcher extends StatelessWidget {
  const _ContactUsTabSwitcher({required this.selectedTab, required this.onChanged});

  final _ContactUsTab selectedTab;
  final ValueChanged<_ContactUsTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(Dimensions.p4),
      decoration: BoxDecoration(color: _kContactUsFill, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: _ContactUsTabChip(
              label: appLocalizer.contactInformation,
              iconPath: AppIcons.callCalling,
              isSelected: selectedTab == _ContactUsTab.contactInformation,
              onTap: () => onChanged(_ContactUsTab.contactInformation),
            ),
          ),
          const SizedBox(width: Dimensions.p4),
          Expanded(
            child: _ContactUsTabChip(
              label: appLocalizer.sendMessage,
              iconPath: AppIcons.smsTracking,
              isSelected: selectedTab == _ContactUsTab.sendMessage,
              onTap: () => onChanged(_ContactUsTab.sendMessage),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactUsTabChip extends StatelessWidget {
  const _ContactUsTabChip({required this.label, required this.iconPath, required this.isSelected, required this.onTap});

  final String label;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color foreground = isSelected ? AppColors.primary : AppColors.mutedText;
    final TextStyle textStyle = (isSelected ? TextStyles.bold14 : TextStyles.medium14).copyWith(color: foreground, height: 1);

    return Bounce(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16, vertical: Dimensions.p12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(Dimensions.r16),
          border: isSelected ? Border.all(color: _kTabBorder) : null,
        ),
        child: Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(label, maxLines: 1, style: textStyle),
              ),
            ),
            const SizedBox(width: Dimensions.p4),
            SizedBox(
              width: Dimensions.ic24,
              height: Dimensions.ic24,
              child: AppSvgIcon(
                path: iconPath,
                width: Dimensions.ic24,
                height: Dimensions.ic24,
                color: foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
