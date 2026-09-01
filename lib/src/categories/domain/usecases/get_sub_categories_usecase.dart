import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/core.dart';
import '../entities/category_entity.dart';
import '../repositories/categories_repository.dart';

@injectable
class GetSubCategoriesUsecase extends IUseCase<List<CategoryEntity>, GetSubCategoriesParams> {
  final CategoriesRepository _repository;

  GetSubCategoriesUsecase(this._repository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(GetSubCategoriesParams params) {
    return _repository.getSubCategories(params);
  }
}

class GetSubCategoriesParams extends Equatable {
  final int categoryId;

  const GetSubCategoriesParams({required this.categoryId});

  const GetSubCategoriesParams.initial({required int categoryId}) : this(categoryId: categoryId);

  GetSubCategoriesParams copyWith({int? categoryId}) {
    return GetSubCategoriesParams(categoryId: categoryId ?? this.categoryId);
  }

  @override
  List<Object?> get props => [categoryId];
}
