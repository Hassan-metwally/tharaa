part of '../home_page.dart';

const Color _kHomeAppBarActionsFill = Color(0xFFF7F8FA);
const double _kHomeAppBarHeight = 78;
const double _kHomeAppBarActionSize = 48;
const double _kHomeAppBarActionsRadius = 18;
const double _kHomeAppBarActionsPadding = 2;
const double _kHomeAppBarBadgeSize = 18;

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: _kHomeAppBarHeight,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.p16),
            child: Row(
              children: [
                Expanded(child: _HomeAppBarSlogan()),
                SizedBox(width: Dimensions.p12),
                _HomeAppBarActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeAppBarSlogan extends StatelessWidget {
  const _HomeAppBarSlogan();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        appLocalizer.homeAppBarSlogan,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: TextStyles.semiBold24.copyWith(
          color: AppColors.black900,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _HomeAppBarActions extends StatelessWidget {
  const _HomeAppBarActions();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kHomeAppBarActionsPadding),
      decoration: BoxDecoration(
        color: _kHomeAppBarActionsFill,
        borderRadius: BorderRadius.circular(_kHomeAppBarActionsRadius),
      ),
      child: BlocBuilder<AppAuthenticationBloc, AppAuthenticationState>(
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            spacing: _kHomeAppBarActionsPadding,
            children: [
              const _HomeSearchAction(),
              if (state is! GuestState) const _HomeNotificationAction(),
            ],
          );
        },
      ),
    );
  }
}

class _HomeNotificationAction extends StatelessWidget {
  const _HomeNotificationAction();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<NotificationsCubit>()..getUnreadedNotificationsCount(),
      child: BlocSelector<NotificationsCubit, NotificationsState, int>(
        selector: (state) => state.notificationsCountState.data ?? 0,
        builder: (context, notificationsCount) {
          return _HomeAppBarActionButton(
            icon: AppIcons.notificationBing,
            badgeCount: notificationsCount,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.notificationsPage,
                arguments: NotificationsPage(
                  onNotificationRead: () {
                    context.read<NotificationsCubit>().getUnreadedNotificationsCount();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _HomeSearchAction extends StatelessWidget {
  const _HomeSearchAction();

  @override
  Widget build(BuildContext context) {
    return _HomeAppBarActionButton(
      icon: AppIcons.searchStatus,
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.searchProductsPage,
          arguments: const SearchProductsPage(),
        );
      },
    );
  }
}

class _HomeAppBarActionButton extends StatelessWidget {
  const _HomeAppBarActionButton({
    required this.icon,
    required this.onTap,
    this.badgeCount = 0,
  });

  final String icon;
  final VoidCallback onTap;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: _kHomeAppBarActionSize,
        height: _kHomeAppBarActionSize,
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(Dimensions.r16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.p10),
                  child: Center(
                    child: SizedBox(
                      width: Dimensions.ic24,
                      height: Dimensions.ic24,
                      child: AppSvgIcon(path: icon, width: Dimensions.ic24, height: Dimensions.ic24),
                    ),
                  ),
                ),
              ),
            ),
            if (badgeCount > 0)
              Positioned(
                top: 6,
                left: 4,
                child: Container(
                  width: _kHomeAppBarBadgeSize,
                  height: _kHomeAppBarBadgeSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.red500,
                    borderRadius: BorderRadius.circular(Dimensions.r8),
                  ),
                  child: FittedBox(
                    child: Text(
                      badgeCount.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyles.semiBold12.copyWith(
                        color: AppColors.white,
                        height: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
