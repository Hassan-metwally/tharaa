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

enum ProductsSortEnum {
  mostRequested('most_requested'),
  priceDesc('price_desc'),
  priceAsc('price_asc');

  final String apiValue;
  const ProductsSortEnum(this.apiValue);
}

class GetProductsParams extends Equatable {
  final int? page;
  final String? search;
  final bool? offersProductsOnly;
  final CategoryEntity? mainCategory;
  final CategoryEntity? subCategory;
  final ProductsSortEnum? sort;

  const GetProductsParams({
    this.page,
    this.search,
    this.offersProductsOnly,
    this.mainCategory,
    this.subCategory,
    this.sort,
  });

  const GetProductsParams.initial() : this();

  bool get isDedicatedOffersList =>
      offersProductsOnly == true && sort == null && mainCategory == null && subCategory == null;

  GetProductsParams copyWith({
    int? page,
    String? search,
    bool? offersProductsOnly,
    CategoryEntity? mainCategory,
    CategoryEntity? subCategory,
    ProductsSortEnum? sort,
  }) {
    return GetProductsParams(
      page: page ?? this.page,
      search: search ?? this.search,
      offersProductsOnly: offersProductsOnly ?? this.offersProductsOnly,
      mainCategory: mainCategory ?? this.mainCategory,
      subCategory: subCategory ?? this.subCategory,
      sort: sort ?? this.sort,
    );
  }

  Map<String, dynamic> get toMap {
    if (isDedicatedOffersList) {
      return {
        'page': page,
        if (search != null && search!.isNotEmpty) 'name': search,
      };
    }

    return {
      'page': page,
      if (search != null && search!.isNotEmpty) 'name': search,
      if (mainCategory != null) 'category_id': mainCategory!.id,
      if (subCategory != null) 'sub_category_id': subCategory!.id,
      if (sort != null) 'sort': sort!.apiValue,
      if (offersProductsOnly == true) 'has_offer': 1,
    };
  }

  @override
  List<Object?> get props => [page, search, offersProductsOnly, mainCategory, subCategory, sort];
}


