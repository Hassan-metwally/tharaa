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
    // ignore: unused_element
    Color iconBGColor() {
      if (widget.notification.type == NotificationType.adminNotification) {
        return AppColors.primary;
      } else if (widget.notification.type == NotificationType.wallet || widget.notification.type == NotificationType.subscription) {
        return AppColors.success600;
      } else {
        return const Color(0xCCF9F9F9);
      }
    }

    return GestureDetector(
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isReadingNotification ? AppColors.black50 : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: AppColors.black500.withOpacityPercent(4), blurRadius: 8)],
        ),
        child: Column(
          children: [
            Row(
              children: [
                AppImage.circle(path: isReadingNotification ? AppImages.notification : AppImages.notification2, dimension: 40),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.notification.title, style: TextStyles.medium12, maxLines: 2),
                      const SizedBox(height: 4),
                      Text(
                        widget.notification.body,
                        style: TextStyles.regular10.copyWith(color: AppColors.black600),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text(widget.notification.createdAt.toString(), style: TextStyles.regular10.copyWith(color: AppColors.black800))],
            ),
          ],
        ),
      ),
    );
  }
}
