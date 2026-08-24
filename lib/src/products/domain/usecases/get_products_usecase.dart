import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/core.dart';
import '../../../categories/domain/entities/category_entity.dart';
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
  final int? page;
  final String? search;
  final bool? offersProductsOnly;
  final bool? mostRequestedProductsOnly;
  final CategoryEntity? mainCategory;
  final CategoryEntity? subCategory;
  const GetProductsParams({this.page, this.search, this.offersProductsOnly, this.mostRequestedProductsOnly, this.mainCategory, this.subCategory});

  const GetProductsParams.initial() : this();

  GetProductsParams copyWith({
    int? page,
    String? search,
    bool? offersProductsOnly,
    bool? mostRequestedProductsOnly,
    CategoryEntity? mainCategory,
    CategoryEntity? subCategory,
  }) {
    return GetProductsParams(
      page: page ?? this.page,
      search: search ?? this.search,
      offersProductsOnly: offersProductsOnly ?? this.offersProductsOnly,
      mostRequestedProductsOnly: mostRequestedProductsOnly ?? this.mostRequestedProductsOnly,
      mainCategory: mainCategory ?? this.mainCategory,
      subCategory: subCategory ?? this.subCategory,
    );
  }

  Map<String, dynamic> get toMap => {
    'page': page,
    if (offersProductsOnly != null && offersProductsOnly!) 'offersProductsOnly': offersProductsOnly,
    if (mostRequestedProductsOnly != null && mostRequestedProductsOnly!) 'mostRequestedProductsOnly': mostRequestedProductsOnly,
    if (mainCategory != null) 'categoyId': mainCategory?.id,
    if (subCategory != null) 'subCategoryId': subCategory?.id,
    if (search != null) 'name': search,
  };

  @override
  List<Object?> get props => [page, search, offersProductsOnly, mostRequestedProductsOnly, mainCategory, subCategory];
}
