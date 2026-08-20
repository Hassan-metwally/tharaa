import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../authentication/domain/entities/user_entity.dart';

class RateEntity extends Equatable {
  final int id;
  final num rate;
  final String comment;
  final UserEntity user;

  const RateEntity({required this.id, required this.rate, required this.comment, required this.user});

  const RateEntity.initial()
    : id = 0,
      rate = 0,
      comment = '',
      user = const UserEntity(id: 0, name: '', mobile: '', avatar: AttachmentEntity.empty(), isVerified: null);

  RateEntity copyWith({int? id, num? rate, String? comment, UserEntity? user}) {
    return RateEntity(id: id ?? this.id, rate: rate ?? this.rate, comment: comment ?? this.comment, user: user ?? this.user);
  }

  @override
  List<Object?> get props => [id, rate, comment, user];
}
