import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../repositories/rating_repository.dart';

@injectable
class AddRateUsecase extends IUseCase<String, UpsertRateParams> {
  final RatingRepository _repository;

  AddRateUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call(UpsertRateParams params) {
    return _repository.addRate(params);
  }
}

class UpsertRateParams extends Equatable {
  final int orderId;
  final int stars;
  final String comment;

  const UpsertRateParams({required this.orderId, required this.stars, required this.comment});

  const UpsertRateParams.initial() : orderId = 0, stars = 0, comment = '';

  UpsertRateParams copyWith({int? orderId, int? stars, String? comment}) {
    return UpsertRateParams(orderId: orderId ?? this.orderId, stars: stars ?? this.stars, comment: comment ?? this.comment);
  }

  Map<String, dynamic> get toMap => {'stars': stars, 'comment': comment};

  @override
  List<Object?> get props => [orderId, stars, comment];
}
