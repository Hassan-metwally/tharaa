part of '../client_main_page.dart';

const double _kNavBarHeight = 70;
const double _kNavBarRadius = 20;
const double _kNavBarWidth = 343;
const double _kSelectedTabWidth = 71;
const double _kUnselectedTabWidth = 62;

class _ClientBottomNavigationBar extends StatelessWidget {
  const _ClientBottomNavigationBar({required this.selctedTab, required this.onTabChanged});

  final ClientMainPageTabsEnum selctedTab;
  final ValueChanged<ClientMainPageTabsEnum> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.fromLTRB(Dimensions.p16, 0, Dimensions.p16, Dimensions.p16 + MediaQuery.paddingOf(context).bottom),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Container(
            width: _kNavBarWidth,
            height: _kNavBarHeight,
            padding: const EdgeInsets.all(Dimensions.p4),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(_kNavBarRadius),
              boxShadow: [BoxShadow(color: AppColors.black.withOpacityPercent(25), offset: const Offset(0, 3), blurRadius: 6)],
            ),
            child: Row(
              spacing: Dimensions.p4,
              children: ClientMainPageTabsEnum.values.map((item) {
                final bool isSelected = item == selctedTab;
                return SizedBox(
                  width: isSelected ? _kSelectedTabWidth : _kUnselectedTabWidth,
                  child: Bounce(
                    onTap: () => onTabChanged(item),
                    child: AnimatedContainer(
                      duration: Durations.medium3,
                      width: double.infinity,
                      height: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: isSelected ? Dimensions.p16 : 0),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.white : AppColors.black800,
                        borderRadius: BorderRadius.circular(Dimensions.r16),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppSvgIcon(
                            path: isSelected ? item.filledIc : item.outlineIc,
                            size: Dimensions.ic24,
                            color: isSelected ? AppColors.primary : AppColors.white,
                          ),
                          if (isSelected)
                            Text(
                              item.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.bold14.copyWith(color: AppColors.primary, height: 1),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
