import '../../../domain/usecases/get_products_usecase.dart';

enum ProductsPageMode { category, offers, mostRequested }

ProductsPageMode productsPageModeOf(GetProductsParams params) {
  if (params.mostRequestedProductsOnly == true) {
    return ProductsPageMode.mostRequested;
  }
  if (params.offersProductsOnly == true) {
    return ProductsPageMode.offers;
  }
  return ProductsPageMode.category;
}

enum ProductsSortOption { mostRequested, priceHighToLow, priceLowToHigh }
