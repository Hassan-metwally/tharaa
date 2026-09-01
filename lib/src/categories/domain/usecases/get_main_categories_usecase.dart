import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../entities/category_entity.dart';
import '../repositories/categories_repository.dart';

@injectable
class GetMainCategoriesUsecase extends IUseCase<List<CategoryEntity>, NoParams> {
  final CategoriesRepository _repository;

  GetMainCategoriesUsecase(this._repository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) {
    return _repository.getMainCategories(params);
  }
}
