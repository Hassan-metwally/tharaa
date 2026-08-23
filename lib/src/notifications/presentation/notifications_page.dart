import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../core/config/router/app_routes.dart';
import '../../../core/core.dart';
import '../../../core/di/di.dart';
import '../../../material/app_empty_widget.dart';
import '../../../material/app_fail_widget.dart';
import '../../../material/media/svg_icon.dart';
import '../../../material/spin_kit_loading_widget.dart';
import '../../chat/domain/entities/chat_page_input.dart';
import '../../chat/presentation/chat_page.dart';
import '../domain/entities/norification_entity.dart';
import '../domain/use_cases/read_notification_usecase.dart';
import 'notifications_cubit.dart';

part 'widgets/notification_card.dart';
part 'widgets/notifications_header.dart';

const Color _kNotificationCardFill = Color(0xFFF7F8FA);
const double _kNotificationCardRadius = Dimensions.r12;
const double _kNotificationIconSize = Dimensions.ic40;
const double _kNotificationIconGlyphSize = Dimensions.ic24;
const double _kReadNotificationOpacity = 0.6;

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
        onNotificationRead: widget.onNotificationRead,
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
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        context.read<NotificationsCubit>().getMoreNotifications();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const _NotificationsHeader(),
            Expanded(
              child: BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  return _NotificationsView(
                    state: state,
                    scrollController: _scrollController,
                    onNotificationRead: widget.onNotificationRead,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  const _NotificationsView({
    required this.state,
    required this.scrollController,
    required this.onNotificationRead,
  });

  final NotificationsState state;
  final ScrollController scrollController;
  final Function()? onNotificationRead;

  @override
  Widget build(BuildContext context) {
    if (state.getNotificationsState.isLoading) {
      return const SpinKitLoadingWidget();
    }

    if (state.getNotificationsState.isFailure) {
      return AppFailWidget(
        onRetry: () {
          BlocProvider.of<NotificationsCubit>(context).getNotifications();
        },
      );
    }

    if (state.getNotificationsState.isSuccess) {
      final notifications = state.getNotificationsState.data!;

      return LiquidPullToRefresh(
        color: AppColors.backgroundColor,
        backgroundColor: AppColors.primary,
        onRefresh: () async {
          BlocProvider.of<NotificationsCubit>(context).getNotifications();
        },
        child: notifications.isEmpty
            ? AppEmptyWidget(text: appLocalizer.noNotifications, imagePath: AppImages.emptyNotifications)
            : _NotificationsList(
                notifications: notifications,
                scrollController: scrollController,
                isPaginationLoading: state.getNotificationsState.isPaginationLoading,
                onNotificationRead: onNotificationRead,
              ),
      );
    }

    return const SizedBox.shrink();
  }
}

class _NotificationsList extends StatelessWidget {
  const _NotificationsList({
    required this.notifications,
    required this.scrollController,
    required this.isPaginationLoading,
    required this.onNotificationRead,
  });

  final List<NotificationEntity> notifications;
  final ScrollController scrollController;
  final bool isPaginationLoading;
  final Function()? onNotificationRead;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.separated(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(Dimensions.p16, Dimensions.p12, Dimensions.p16, Dimensions.p16),
          itemCount: notifications.length,
          separatorBuilder: (context, index) => const SizedBox(height: Dimensions.p12),
          itemBuilder: (context, index) {
            return _NotificationCard(
              onNotificationRead: onNotificationRead,
              notification: notifications[index],
            );
          },
        ),
        if (isPaginationLoading)
          const Positioned(
            bottom: -10,
            right: 0,
            left: 0,
            child: Center(
              child: Padding(padding: EdgeInsets.symmetric(vertical: 20), child: SpinKitLoadingWidget()),
            ),
          ),
      ],
    );
  }
}
