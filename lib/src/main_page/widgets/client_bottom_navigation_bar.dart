part of '../client_main_page.dart';

class _ClientBottomNavigationBar extends StatelessWidget {
  const _ClientBottomNavigationBar({required this.selctedTab, required this.onTabChanged});

  final ClientMainPageTabsEnum selctedTab;
  final ValueChanged<ClientMainPageTabsEnum> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: Platform.isIOS ? EdgeInsets.only(bottom: 12) : null,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [BoxShadow(color: AppColors.black.withOpacityPercent(8), blurRadius: 4)],
      ),
      child: Row(
        children: ClientMainPageTabsEnum.values.map((item) {
          final bool isSelected = item == selctedTab;
          return Expanded(
            child: Bounce(
              onTap: () {
                onTabChanged(item);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12).copyWith(bottom: Platform.isIOS ? 16 : 12),
                color: isSelected ? AppColors.primary50 : null,
                child: Column(
                  spacing: 4,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: Durations.medium3,
                      child: SizedBox(
                        key: ValueKey(selctedTab),
                        child: AppSvgIcon(path: !isSelected ? item.outlineIc : item.filledIc),
                      ),
                    ),
                    isSelected ? Text(item.title, style: TextStyles.regular12.copyWith(color: AppColors.primary)) : const SizedBox(),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
