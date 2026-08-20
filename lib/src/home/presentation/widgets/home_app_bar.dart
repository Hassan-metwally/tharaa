part of '../home_page.dart';

class _HomeAppBar extends StatefulWidget {
  const _HomeAppBar();

  @override
  State<_HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<_HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return LoggedUserCheckerWidget(
      loggedBuilder: (user) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0).copyWith(top: 20),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(bottom: BorderSide(color: AppColors.appbarBorderColor)),
            image: DecorationImage(image: AssetImage("")),
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      AppRouter.pushNamed(AppRoutes.clientPersonalProfile);
                    },
                    child: Row(
                      children: [
                        () {
                          if (user.avatar.isNotEmpty) {
                            return AppImage.circle(path: user.avatar, dimension: 48);
                          } else {
                            return Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.primary50),
                              ),
                              child: AppSvgIcon(path: AppIcons.userOutline, size: 35),
                            );
                          }
                        }(),

                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(appLocalizer.welcome, style: TextStyles.regular14.copyWith(color: AppColors.primary)),
                              Text(user.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(width: 8),
                // ProviderHomeAppBarIconButton(icon: AppIcons.searchNormal, onTap: () {}),
                const SizedBox(width: 10),

                NotificationButton(),
              ],
            ),
          ),
        );
      },
      guestWidget: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0).copyWith(top: 15),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(bottom: BorderSide(color: AppColors.appbarBorderColor)),
          image: DecorationImage(image: AssetImage("")),
        ),
        child: SafeArea(
          child: Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appLocalizer.welcomeMessage, style: TextStyles.regular14),
                    const SizedBox(height: 8),
                    Text(appLocalizer.welcomeSubMessage, style: TextStyles.regular10.copyWith(color: AppColors.black700)),
                  ],
                ),
              ),
              const SizedBox(width: 2),
              OutlinedButton(
                onPressed: () {
                  AppAuthenticationBloc.of(context).add(const LoggedOutEvent());
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(80, 40),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                  side: BorderSide(color: AppColors.primary),
                ),
                child: Text(appLocalizer.login, style: TextStyles.regular12.copyWith(color: AppColors.primary)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
