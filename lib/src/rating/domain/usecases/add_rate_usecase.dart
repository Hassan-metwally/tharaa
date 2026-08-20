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
  final int rateItemId;
  final int rating;
  final String comment;

  const UpsertRateParams({required this.rateItemId, required this.rating, required this.comment});

  const UpsertRateParams.initial() : rateItemId = 0, rating = 0, comment = '';

  UpsertRateParams copyWith({int? rateItemId, int? rating, String? comment}) {
    return UpsertRateParams(rateItemId: rateItemId ?? this.rateItemId, rating: rating ?? this.rating, comment: comment ?? this.comment);
  }

  Map<String, dynamic> get toMap => {'rate_item_id': rateItemId, 'rating': rating, 'comment': comment};

  @override
  List<Object?> get props => [rateItemId, rating, comment];
}
