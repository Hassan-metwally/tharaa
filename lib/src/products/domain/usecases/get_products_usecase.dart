import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/core.dart';
import '../entities/product_entity.dart';
import '../repositories/products_repository.dart';

@injectable
class GetProductsUsecase extends IUseCase<PaginatedData<ProductEntity>, GetProductsParams> {
  final ProductsRepository _repository;

  GetProductsUsecase(this._repository);

  @override
  Future<Either<Failure, PaginatedData<ProductEntity>>> call(GetProductsParams params) {
    return _repository.getProducts(params);
  }
}

class GetProductsParams extends Equatable {
  final int page;
  final bool? offersProductsOnly;
  final bool? mostRequestedProductsOnly;

  const GetProductsParams({required this.page, this.offersProductsOnly, this.mostRequestedProductsOnly});

  const GetProductsParams.initial() : this(page: 1);

  GetProductsParams copyWith({int? page, bool? offersProductsOnly, bool? mostRequestedProductsOnly}) {
    return GetProductsParams(
      page: page ?? this.page,
      offersProductsOnly: offersProductsOnly ?? this.offersProductsOnly,
      mostRequestedProductsOnly: mostRequestedProductsOnly ?? this.mostRequestedProductsOnly,
    );
  }

  Map<String, dynamic> get toMap => {
    'page': page,
    if (offersProductsOnly != null && offersProductsOnly!) 'offersProductsOnly': offersProductsOnly,
    if (mostRequestedProductsOnly != null && mostRequestedProductsOnly!) 'mostRequestedProductsOnly': mostRequestedProductsOnly,
  };

  @override
  List<Object?> get props => [page, offersProductsOnly, mostRequestedProductsOnly];
}
