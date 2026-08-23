import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../entities/product_details_entity.dart';
import '../repositories/products_repository.dart';

@injectable
class ShowProductDetailsUsecase extends IUseCase<ProductDetailsEntity, int> {
  final ProductsRepository _repository;

  ShowProductDetailsUsecase(this._repository);

  @override
  Future<Either<Failure, ProductDetailsEntity>> call(int id) {
    return _repository.showProductDetails(id);
  }
}
