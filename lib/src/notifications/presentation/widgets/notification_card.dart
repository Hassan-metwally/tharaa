part of '../notifications_page.dart';

class _NotificationCard extends StatefulWidget {
  final Function()? onNotificationRead;
  final NotificationEntity notification;
  const _NotificationCard({required this.onNotificationRead, required this.notification});

  @override
  State<_NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<_NotificationCard> {
  late bool isReadingNotification;
  @override
  void initState() {
    super.initState();
    isReadingNotification = widget.notification.isRead;
  }

  @override
  Widget build(BuildContext context) {
    final bool isRead = isReadingNotification;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        BlocProvider.of<NotificationsCubit>(context).readNotification(ReadNotificationParams(id: widget.notification.id));
        if (widget.onNotificationRead != null) {
          widget.onNotificationRead!();
        }
        setState(() {
          isReadingNotification = true;
        });
        if (widget.notification.type == NotificationType.serviceOrder) {
          // AppRouter.pushNamed(
          //   AppRoutes.showClientServiceOrderDetailsPage,
          //   arguments: ShowClientServiceOrderDetailsPage(id: widget.notification.redirectionId),
          // );
        } else if (widget.notification.type == NotificationType.productOrder) {
          // AppRouter.pushNamed(
          //   AppRoutes.showClientProductOrderDetailsPage,
          //   arguments: ShowClientProductOrderDetailsPage(id: widget.notification.redirectionId),
          // );
        } else if (widget.notification.type == NotificationType.wallet || widget.notification.type == NotificationType.settlementRequest) {
          AppRouter.pushNamed(AppRoutes.clientWalletPage);
        } else if (widget.notification.type == NotificationType.chat) {
          final authState = AppAuthenticationBloc.of(context).state;
          if (authState is AuthAuthenticatedState) {
            final currentUserId = authState.user.id;
            ChatPage.open(ChatPageHelpRequestInput(orderId: widget.notification.redirectionId, currentUserId: currentUserId));
          }
        }
      },
      child: Opacity(
        opacity: isRead ? _kReadNotificationOpacity : 1,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(Dimensions.p12),
          decoration: BoxDecoration(
            color: _kNotificationCardFill,
            borderRadius: BorderRadius.circular(_kNotificationCardRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _NotificationCardIcon(isRead: isRead),
                  const SizedBox(width: Dimensions.p8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.notification.title,
                          style: TextStyles.semiBold16.copyWith(
                            color: AppColors.black900,
                            height: 1.6,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.notification.body,
                          style: TextStyles.regular14.copyWith(
                            color: AppColors.mutedText,
                            height: 1.6,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.p4),
              Text(
                widget.notification.createdAt.toString(),
                textAlign: TextAlign.end,
                style: TextStyles.regular12.copyWith(
                  color: isRead ? AppColors.mutedText : AppColors.primary,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationCardIcon extends StatelessWidget {
  const _NotificationCardIcon({required this.isRead});

  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _kNotificationIconSize,
      height: _kNotificationIconSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isRead ? AppColors.white : AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: AppSvgIcon(
        path: AppIcons.notificationBing,
        width: _kNotificationIconGlyphSize,
        height: _kNotificationIconGlyphSize,
        color: isRead ? null : AppColors.white,
      ),
    );
  }
}
