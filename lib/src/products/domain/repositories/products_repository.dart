import '../../../../../../core/core.dart';

import '../entities/product_details_entity.dart';

import '../entities/product_entity.dart';

import '../usecases/get_products_usecase.dart';

abstract class ProductsRepository {
  DomainServiceType<ProductDetailsEntity> showProductDetails(int id);

  DomainServiceType<PaginatedData<ProductEntity>> getProducts(GetProductsParams params);
}
