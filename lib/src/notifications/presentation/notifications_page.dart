import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../core/config/router/app_routes.dart';
import '../../../core/core.dart';
import '../../../core/di/di.dart';
import '../../../material/app_empty_widget.dart';
import '../../../material/app_fail_widget.dart';
import '../../../material/media/app_image.dart';
import '../../../material/spin_kit_loading_widget.dart';
import '../../chat/domain/entities/chat_page_input.dart';
import '../../chat/presentation/chat_page.dart';
import '../domain/entities/norification_entity.dart';
import '../domain/use_cases/read_notification_usecase.dart';
import 'notifications_cubit.dart';

part 'widgets/notification_card.dart';

class NotificationsPage extends StatefulWidget {
  final Function()? onNotificationRead;
  const NotificationsPage({this.onNotificationRead, super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<NotificationsCubit>()..getNotifications(),
      child: NotificationsPageBody(
        onNotificationRead: widget.onNotificationRead, // You can pass a function here if needed
      ),
    );
  }
}

class NotificationsPageBody extends StatefulWidget {
  final Function()? onNotificationRead;
  const NotificationsPageBody({this.onNotificationRead, super.key});

  @override
  State<NotificationsPageBody> createState() => _NotificationsPageBodyState();
}

class _NotificationsPageBodyState extends State<NotificationsPageBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        context.read<NotificationsCubit>().getMoreNotifications();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizer.notifications, style: TextStyles.bold16.copyWith(color: AppColors.black)),
        centerTitle: true,
        shadowColor: AppColors.white,
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state.getNotificationsState.isLoading) {
            return const SpinKitLoadingWidget();
          } else if (state.getNotificationsState.isFailure) {
            return AppFailWidget(
              onRetry: () {
                BlocProvider.of<NotificationsCubit>(context).getNotifications();
              },
            );
          } else if (state.getNotificationsState.isSuccess) {
            final notifications = state.getNotificationsState.data!;

            return LiquidPullToRefresh(
              color: AppColors.backgroundColor,
              backgroundColor: AppColors.primary,
              onRefresh: () async {
                BlocProvider.of<NotificationsCubit>(context).getNotifications();
              },
              child: notifications.isEmpty
                  ? AppEmptyWidget(text: appLocalizer.noNotifications, imagePath: AppImages.emptyNotifications)
                  : Stack(
                      children: [
                        ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20).copyWith(bottom: 30),
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final notification = state.getNotificationsState.data![index];
                            return _NotificationCard(onNotificationRead: widget.onNotificationRead, notification: notification);
                          },
                        ),
                        if (state.getNotificationsState.isPaginationLoading)
                          Positioned(
                            bottom: -10,
                            right: 0,
                            left: 0,
                            child: const Center(
                              child: Padding(padding: EdgeInsets.symmetric(vertical: 20), child: SpinKitLoadingWidget()),
                            ),
                          ),
                      ],
                    ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
