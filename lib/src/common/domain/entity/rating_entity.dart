import 'package:equatable/equatable.dart';

class RatingEntity extends Equatable {
  final double? rate;
  final String? comment;
  final String? avatar;

  const RatingEntity({required this.rate, required this.comment, required this.avatar});

  const RatingEntity.initial() : this(rate: 0, comment: '', avatar: '');

  @override
  List<Object?> get props => [rate, comment, avatar];
}
