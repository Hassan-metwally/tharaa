import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../core/di/di.dart';
import '../../../material/app_empty_widget.dart';
import '../../../material/app_fail_widget.dart';
import '../../../material/auth_states/logged_user_checker_widget.dart';
import '../../../material/spin_kit_loading_widget.dart';
import '../../chat/domain/entities/chat_page_input.dart';
import '../../chat/presentation/chat_page.dart';
import '../domain/entities/chats_inbox_entity.dart';
import 'chats_inbox_cubit.dart';

part 'widgets/chats_inbox_card.dart';

class ChatsInboxPage extends StatefulWidget {
  const ChatsInboxPage({super.key});
  @override
  State<ChatsInboxPage> createState() => _ChatsInboxPageState();
}

class _ChatsInboxPageState extends State<ChatsInboxPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ChatsLogCubit>()..getChatLogs(),
      child: Scaffold(
        appBar: AppBar(title: Text("appLocalizer.chats"), backgroundColor: AppColors.white),
        body: LoggedUserCheckerWidget(
          loggedBuilder: (user) => BlocConsumer<ChatsLogCubit, ChatsLogState>(
            listener: (context, state) {
              if (state.getChatsLogState.isSuccess) {
                context.read<ChatsLogCubit>().subscribeToChatChannel(userId: user.id.toString());
              }
            },
            builder: (context, state) {
              return BlocBuilder<ChatsLogCubit, ChatsLogState>(
                builder: (context, state) {
                  if (state.getChatsLogState.isLoading) {
                    return const Center(child: SpinKitLoadingWidget());
                  } else if (state.getChatsLogState.isFailure) {
                    return AppFailWidget(onRetry: () => context.read<ChatsLogCubit>().getChatLogs());
                  } else if (state.getChatsLogState.isSuccess) {
                    final chats = state.getChatsLogState.data!;
                    if (chats.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20),
                        child: AppEmptyWidget(heightPercentage: 0.6),
                      );
                    } else {
                      return ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          return ChatesInboxCard(chat: chats[index], index: index);
                        },
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
