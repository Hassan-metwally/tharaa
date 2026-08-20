import 'package:equatable/equatable.dart';

import 'chat_user_type_enum.dart';

class MessageAuthor extends Equatable {
  final int id;
  final String name;
  final String avatar;
  final ChatUserTypeEnum type;

  const MessageAuthor({required this.id, required this.type, required this.name, required this.avatar});

  @override
  List<Object?> get props => [id, name, avatar, type];
}
