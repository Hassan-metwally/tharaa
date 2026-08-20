import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/chat_information_entity.dart';
import '../chat_cubit.dart';

class ChatAppBarWidget extends StatelessWidget {
  const ChatAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatCubit, ChatState, IChatDetailsEntity?>(
      selector: (state) {
        return state.chatInfoState.data;
      },
      builder: (context, data) {
        final titleWidget = data?.getTitleWidget;
        return titleWidget ?? const SizedBox.shrink();
      },
    );
  }
}
