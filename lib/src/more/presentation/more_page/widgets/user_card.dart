part of '../more_page.dart';

String _formatSaudiMobile(String mobile) {
  final local = mobile.startsWith('0') ? mobile.substring(1) : mobile;
  return '+966$local';
}

class _UseCard extends StatelessWidget {
  const _UseCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: LoggedUserCheckerWidget(
        loggedBuilder: (user) {
          return _LoggedClientCard(user: user);
        },
        guestWidget: const _GuestCard(),
      ),
    );
  }
}

class _LoggedClientCard extends StatelessWidget {
  const _LoggedClientCard({required this.user});

  final CachedUser user;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlideWithOpacityWidget(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: AppColors.cardColor, borderRadius: BorderRadius.circular(12)),
        child: Row(
          spacing: 10,
          children: [
            () {
              if (user.avatar.isNotEmpty) {
                return AppImage.circle(
                  path: user.avatar,
                  dimension: 54,
                  border: Border.all(color: AppColors.primary50),
                  placholderWidget: AppSvgIcon(path: AppIcons.userOutline, size: 24),
                );
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
            Expanded(
              child: Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyles.medium16.copyWith(color: AppColors.black900),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 4,
                    children: [
                      AppSvgIcon(path: ""),
                      Flexible(
                        child: Text(
                          _formatSaudiMobile(user.mobile),
                          textDirection: TextDirection.ltr,
                          style: TextStyles.medium14.copyWith(color: AppColors.grey, height: 1.6),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.clientPersonalProfile);
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(80, 40),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              child: Row(
                spacing: 4,
                children: [
                  AppSvgIcon(path: ""),
                  Text(appLocalizer.edit, style: TextStyles.regular12.copyWith(color: AppColors.primary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GuestCard extends StatelessWidget {
  const _GuestCard();

  @override
  Widget build(BuildContext context) {
    return AnimatedSlideWithOpacityWidget(
      child: Bounce(
        onTap: () {
          AppAuthenticationBloc.of(context).add(const LoggedOutEvent());
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColors.cardColor, borderRadius: BorderRadius.circular(12), boxShadow: [AppColors.boxShadow]),
          child: Row(
            children: [
              AppSvgIcon(path: AppIcons.userOutline, size: 50),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appLocalizer.userName, style: TextStyles.light14),
                    Text(appLocalizer.phoneNumber, style: TextStyles.light12.copyWith(color: AppColors.primary800)),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},

                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(80, 40),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                  side: BorderSide(color: AppColors.black200),
                  overlayColor: AppColors.black200.withOpacityPercent(10),
                ),

                child: Row(
                  spacing: 4,
                  children: [
                    AppSvgIcon(path: "", color: AppColors.black200),
                    Text(appLocalizer.edit, style: TextStyles.regular12.copyWith(color: AppColors.black200)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
