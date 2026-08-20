import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../material/app_fail_widget.dart';
import '../domain/entities/chat_page_input.dart';
import 'chat_body.dart';
import 'chat_cubit.dart';
import 'widgets/chat_app_bar.dart';
import 'widgets/chat_input_widget.dart';
import 'widgets/messages_loading_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage._({this.openInBottomSheet = false});
  final bool openInBottomSheet;

  static const String routeName = 'ChatPage';

  static String getRouteName(IChatPageInput input) => input.getPageRouteName;

  static Future<void> open(IChatPageInput input, {bool openInBottomSheet = false}) async {
    final BuildContext? ctx = appNavigatorKey.currentState?.context;
    if (ctx == null && ctx?.mounted == false) return;
    final BuildContext context = ctx!;
    final String? currentRouteName = ModalRoute.of(context)?.settings.name;

    /// IF Same Room For Chat Is Pushed
    if (currentRouteName == getRouteName(input)) {
      return;
    } else {
      if (Navigator.of(context, rootNavigator: true).canPop() && currentRouteName?.contains(routeName) == true) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      if (openInBottomSheet) {
        final Widget page = BlocProvider(
          create: (context) => ChatCubit(input)
            ..getChatInfo()
            ..getMessages(),
          child: ChatPage._(openInBottomSheet: openInBottomSheet),
        );

        final routeSettings = RouteSettings(name: getRouteName(input));

        await showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          barrierLabel: getRouteName(input),
          useRootNavigator: true,
          routeSettings: routeSettings,
          useSafeArea: true,
          showDragHandle: true,
          builder: (BuildContext context) {
            return SafeArea(
              bottom: false,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.88),
                child: page,
              ),
            );
          },
        );
      } else {
        await Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            settings: RouteSettings(name: getRouteName(input)),
            builder: (context) {
              return BlocProvider(
                create: (context) => ChatCubit(input)
                  ..getChatInfo()
                  ..getMessages(),
                child: ChatPage._(openInBottomSheet: openInBottomSheet),
              );
            },
          ),
        );
      }
    }
  }

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.openInBottomSheet
          ? null
          : AppBar(
              title: const ChatAppBarWidget(),
              centerTitle: false,
              titleSpacing: 0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(color: AppColors.appbarBorderColor, height: 1.0),
              ),
            ),
      body: Stack(
        children: [
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state.chatInfoState.isLoading) {
                return const MessagesLoadingWidget();
              } else if (state.chatInfoState.isFailure) {
                return AppFailWidget(
                  onRetry: () {
                    ChatCubit.of(context).getChatInfo();
                    ChatCubit.of(context).getMessages();
                  },
                );
              } else {
                // final bool isChatOpen = (state.chatInfoState.data?.isClosed == false && state.getMessagesState.isSuccess);
                // return Column(
                //   children: [
                //     const Expanded(child: ChatBodyWidget()),
                //     if (isChatOpen) const ChatInputWidget() else const _ClosedChatWidget(),
                //   ],
                // );
                return Column(
                  children: [
                    const Expanded(child: ChatBodyWidget()),
                    const ChatInputWidget(),
                  ],
                );
              }
            },
          ),
          widget.openInBottomSheet ? const ChatAppBarWidget() : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

// ignore: unused_element
class _ClosedChatWidget extends StatelessWidget {
  const _ClosedChatWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      // decoration: BoxDecoration(color: AppColors.tileColor),
      child: SafeArea(
        top: false,
        child: Text(
          appLocalizer.closeChatPreviewMessage,
          textAlign: TextAlign.center,
          style: TextStyles.regular14.copyWith(color: AppColors.hintColor),
        ),
      ),
    );
  }
}
