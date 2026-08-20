import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/router/app_routes.dart';
import '../../../../core/di/di.dart';
import '../../../home/presentation/widgets/home_app_bar_icon_button.dart';
import '../notifications_cubit.dart';
import '../notifications_page.dart';

class NotificationButton extends StatelessWidget {
  final Color? iconColor;
  const NotificationButton({
    super.key,
    this.iconColor, // Default icon color
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<NotificationsCubit>()..getUnreadedNotificationsCount(),
      child: BlocSelector<NotificationsCubit, NotificationsState, int>(
        selector: (notificationsCount) {
          return notificationsCount.notificationsCountState.data ?? 0;
        },
        builder: (context, notificationsCount) {
          return HomeAppBarIconButton(
            iconColor: iconColor,
            icon: "",
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
            iconBadgeCount: notificationsCount,
          );
        },
      ),
    );
  }
}
