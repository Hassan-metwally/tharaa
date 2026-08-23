import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/core.dart';
import '../entities/category_entity.dart';
import '../repositories/categories_repository.dart';

@injectable
class GetSubCategoriesUsecase extends IUseCase<PaginatedData<CategoryEntity>, GetSubCategoriesParams> {
  final CategoriesRepository _repository;

  GetSubCategoriesUsecase(this._repository);

  @override
  Future<Either<Failure, PaginatedData<CategoryEntity>>> call(GetSubCategoriesParams params) {
    return _repository.getSubCategories(params);
  }
}

class GetSubCategoriesParams extends Equatable {
  final int page;
  final int categoryId;

  const GetSubCategoriesParams({required this.page, required this.categoryId});

  const GetSubCategoriesParams.initial({required int categoryId}) : this(page: 1, categoryId: categoryId);

  GetSubCategoriesParams copyWith({int? page, int? categoryId}) {
    return GetSubCategoriesParams(page: page ?? this.page, categoryId: categoryId ?? this.categoryId);
  }

  Map<String, dynamic> get toMap => {'page': page, 'category_id': categoryId};
  @override
  List<Object?> get props => [page, categoryId];
}
