import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/core.dart';
import '../entities/category_entity.dart';
import '../repositories/categories_repository.dart';

@injectable
class GetMainCategoriesUsecase extends IUseCase<PaginatedData<CategoryEntity>, GetMainCategoriesParams> {
  final CategoriesRepository _repository;

  GetMainCategoriesUsecase(this._repository);

  @override
  Future<Either<Failure, PaginatedData<CategoryEntity>>> call(GetMainCategoriesParams params) {
    return _repository.getMainCategories(params);
  }
}

class GetMainCategoriesParams extends Equatable {
  final int page;

  const GetMainCategoriesParams({required this.page});

  const GetMainCategoriesParams.initial() : this(page: 1);

  GetMainCategoriesParams copyWith({int? page}) {
    return GetMainCategoriesParams(page: page ?? this.page);
  }

  Map<String, dynamic> get toMap => {'page': page};
  @override
  List<Object?> get props => [page];
}
