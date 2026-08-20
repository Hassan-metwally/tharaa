import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/core.dart';
import '../entities/rate_entity.dart';
import '../repositories/rating_repository.dart';

@injectable
class GetRatingsUsecase extends IUseCase<PaginatedData<RateEntity>, GetRatingsParams> {
  final RatingRepository _repository;

  GetRatingsUsecase(this._repository);

  @override
  Future<Either<Failure, PaginatedData<RateEntity>>> call(GetRatingsParams params) {
    return _repository.getRating(params);
  }
}

class GetRatingsParams extends Equatable {
  final int page;

  const GetRatingsParams({required this.page});

  const GetRatingsParams.initial() : this(page: 1);

  GetRatingsParams copyWith({int? page}) {
    return GetRatingsParams(page: page ?? this.page);
  }

  Map<String, dynamic> get toMap => {'page': page};
  @override
  List<Object?> get props => [page];
}
