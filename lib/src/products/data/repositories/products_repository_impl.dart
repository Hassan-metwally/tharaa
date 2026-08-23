import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';

import '../../domain/entities/product_details_entity.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/products_repository.dart';

import '../../domain/usecases/get_products_usecase.dart';

import '../datasources/products_datasource.dart';

import '../models/api_product_details_model.dart';

import '../models/api_product_model.dart';

@Injectable(as: ProductsRepository)
class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsDatasource _dataSource;

  ProductsRepositoryImpl(this._dataSource);

  @override
  DomainServiceType<ProductDetailsEntity> showProductDetails(int id) async {
    return await failureCollect(() async {
      final result = await _dataSource.showProductDetails(id);
      return Right(result.map);
    });
  }

  @override
  DomainServiceType<PaginatedData<ProductEntity>> getProducts(GetProductsParams params) async {
    return await failureCollect(() async {
      final result = await _dataSource.getProducts(params);

      return Right(result.map((data) => data.map));
    });
  }
}
