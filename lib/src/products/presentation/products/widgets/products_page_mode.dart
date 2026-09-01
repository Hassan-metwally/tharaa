import '../../../domain/usecases/get_products_usecase.dart';

enum ProductsPageMode { category, offers, mostRequested }

ProductsPageMode productsPageModeOf(GetProductsParams params) {
  if (params.sort == ProductsSortEnum.mostRequested) {
    return ProductsPageMode.mostRequested;
  }
  if (params.offersProductsOnly == true) {
    return ProductsPageMode.offers;
  }
  return ProductsPageMode.category;
}

ProductsSortEnum initialSortForMode(ProductsPageMode mode) {
  return ProductsSortEnum.mostRequested;
}
