part of '../chats_inbox_page.dart';

class ChatesInboxCard extends StatelessWidget {
  String formatTimeAgo(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays == 0) {
      // If created today, show time
      return createdAt.toHHMMa;
    } else {
      // If created more than a week ago, show the date
      return createdAt.DMYHMA;
    }
  }

  const ChatesInboxCard({super.key, required this.chat, required this.index});

  final ChatsInboxEntity chat;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return LoggedUserCheckerWidget(
          loggedBuilder: (user) {
            return GestureDetector(
              onTap: () async {
                await context.read<ChatsLogCubit>().resetUnreadCount(index);
                ChatPage.open(ChatPageHelpRequestInput(orderId: int.parse(chat.orderId), chatId: chat.id, currentUserId: user.id));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.black50),
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.white,
                ),
                child: Row(
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(chat.user.avatar), radius: 25),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(chat.user.name, style: TextStyles.medium14.copyWith(color: AppColors.black)),
                              ),
                              if (chat.lastMessageEntity != null)
                                Text(
                                  formatTimeAgo(chat.lastMessageEntity!.createdAt),
                                  style: TextStyles.regular12.copyWith(color: AppColors.black600),
                                ),
                              const SizedBox(height: 15),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  chat.lastMessageEntity?.messageText ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.regular12.copyWith(color: AppColors.black600),
                                ),
                              ),
                              chat.unreadCount != 0
                                  ? Container(
                                      height: 18,
                                      width: 18,
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
                                      child: FittedBox(
                                        child: Text(
                                          chat.unreadCount.toString(),
                                          style: TextStyles.medium12.copyWith(color: AppColors.white),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
