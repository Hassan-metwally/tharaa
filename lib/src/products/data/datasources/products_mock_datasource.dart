import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../models/api_product_details_model.dart';
import '../models/api_product_model.dart';
import 'products_datasource.dart';

AttachmentEntity _marketImage(String photoId) {
  return AttachmentEntity.fromNetwork(
    url: 'https://images.unsplash.com/photo-$photoId?auto=format&fit=crop&w=400&h=400&q=80',
  );
}

class _MockProduct {
  final ApiProductDetailsModel details;
  final bool isMostRequested;

  _MockProduct({required this.details, this.isMostRequested = false});
}

@Injectable(as: ProductsDatasource)
class ProductsMockDatasource extends ProductsDatasource {
  static const _delay = Duration(milliseconds: 400);

  static final List<_MockProduct> _products = [
    _MockProduct(
      isMostRequested: true,
      details: ApiProductDetailsModel(
        id: 1,
        name: 'Fresh Tomatoes',
        image: _marketImage('1546470427-227c7abf47d6'),
        category: 'Vegetables',
        subCategory: 'Tomatoes',
        unit: 'kg',
        amount: 1,
        price: 8.5,
        offerPrice: 6.9,
        offerEndDate: DateTime.now().add(const Duration(days: 5)),
        description: 'Ripe greenhouse tomatoes, ideal for salads and cooking.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 2,
        name: 'Cucumbers',
        image: _marketImage('1449300077003-4d1192801cd8'),
        category: 'Vegetables',
        subCategory: 'Leafy Greens',
        unit: 'kg',
        amount: 1,
        price: 5.5,
        description: 'Crisp cucumbers harvested daily from local farms.',
      ),
    ),
    _MockProduct(
      isMostRequested: true,
      details: ApiProductDetailsModel(
        id: 3,
        name: 'Potatoes',
        image: _marketImage('1518977676601-b53f82aba655'),
        category: 'Vegetables',
        subCategory: 'Potatoes',
        unit: 'kg',
        amount: 2,
        price: 7,
        description: 'Local potatoes suitable for frying, boiling, and baking.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 4,
        name: 'Carrots',
        image: _marketImage('1598170845058-32b9d6a5da37'),
        category: 'Vegetables',
        subCategory: 'Carrots',
        unit: 'kg',
        amount: 1,
        price: 6,
        offerPrice: 4.75,
        offerEndDate: DateTime.now().add(const Duration(days: 3)),
        description: 'Sweet orange carrots packed with flavor and crunch.',
      ),
    ),
    _MockProduct(
      isMostRequested: true,
      details: ApiProductDetailsModel(
        id: 5,
        name: 'Red Apples',
        image: _marketImage('1560806887-1e4cd0b6cbd6'),
        category: 'Fruits',
        subCategory: 'Apples',
        unit: 'kg',
        amount: 1,
        price: 12,
        description: 'Crisp red apples, great for snacking and juices.',
      ),
    ),
    _MockProduct(
      isMostRequested: true,
      details: ApiProductDetailsModel(
        id: 6,
        name: 'Bananas',
        image: _marketImage('1571771894821-ce9b6c11b08e'),
        category: 'Fruits',
        subCategory: 'Bananas',
        unit: 'kg',
        amount: 1,
        price: 9.5,
        offerPrice: 7.9,
        offerEndDate: DateTime.now().add(const Duration(days: 2)),
        description: 'Naturally ripened bananas, ready to eat.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 7,
        name: 'Oranges',
        image: _marketImage('1547514701-42782101795e'),
        category: 'Fruits',
        subCategory: 'Citrus',
        unit: 'kg',
        amount: 1,
        price: 10,
        description: 'Juicy oranges rich in vitamin C.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 8,
        name: 'Strawberries',
        image: _marketImage('1464965911861-746a04b4bca6'),
        category: 'Fruits',
        subCategory: 'Berries',
        unit: 'box',
        amount: 1,
        price: 18,
        offerPrice: 14.5,
        offerEndDate: DateTime.now().add(const Duration(days: 1)),
        description: 'Sweet seasonal strawberries, packed fresh.',
      ),
    ),
    _MockProduct(
      isMostRequested: true,
      details: ApiProductDetailsModel(
        id: 9,
        name: 'Fresh Milk',
        image: _marketImage('1563636619-e9143da7973b'),
        category: 'Dairy',
        subCategory: 'Milk',
        unit: 'L',
        amount: 1,
        price: 6.5,
        description: 'Full-fat fresh milk, chilled and ready to serve.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 10,
        name: 'Cheddar Cheese',
        image: _marketImage('1486297678162-eb2a19b0a32d'),
        category: 'Dairy',
        subCategory: 'Cheese',
        unit: 'pack',
        amount: 1,
        price: 22,
        description: 'Aged cheddar cheese, sliced and vacuum sealed.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 11,
        name: 'Greek Yogurt',
        image: _marketImage('1488477181946-6428a0291777'),
        category: 'Dairy',
        subCategory: 'Yogurt',
        unit: 'cup',
        amount: 4,
        price: 14,
        offerPrice: 11.5,
        offerEndDate: DateTime.now().add(const Duration(days: 4)),
        description: 'Creamy Greek yogurt, unsweetened and high in protein.',
      ),
    ),
    _MockProduct(
      isMostRequested: true,
      details: ApiProductDetailsModel(
        id: 12,
        name: 'Farm Eggs',
        image: _marketImage('1582722872445-44dc5f7e3c8f'),
        category: 'Dairy',
        subCategory: 'Eggs',
        unit: 'pack',
        amount: 30,
        price: 19,
        description: 'Fresh farm eggs, packed in a tray of 30.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 13,
        name: 'Beef Steak',
        image: _marketImage('1603048297172-c92544798d5a'),
        category: 'Meat',
        subCategory: 'Beef',
        unit: 'kg',
        amount: 1,
        price: 48,
        description: 'Premium beef steak cuts, trimmed and ready to cook.',
      ),
    ),
    _MockProduct(
      isMostRequested: true,
      details: ApiProductDetailsModel(
        id: 14,
        name: 'Chicken Breast',
        image: _marketImage('1604503468506-a8da13d82791'),
        category: 'Meat',
        subCategory: 'Chicken',
        unit: 'kg',
        amount: 1,
        price: 28,
        offerPrice: 24,
        offerEndDate: DateTime.now().add(const Duration(days: 6)),
        description: 'Boneless chicken breast, fresh and skinless.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 15,
        name: 'Fresh Salmon',
        image: _marketImage('1519708227418-c8fd9a32b7a2'),
        category: 'Meat',
        subCategory: 'Fish',
        unit: 'kg',
        amount: 1,
        price: 55,
        description: 'Atlantic salmon fillets, kept on ice until delivery.',
      ),
    ),
    _MockProduct(
      isMostRequested: true,
      details: ApiProductDetailsModel(
        id: 16,
        name: 'Arabic Bread',
        image: _marketImage('1509440159596-0249088772ff'),
        category: 'Bakery',
        subCategory: 'Bread',
        unit: 'pack',
        amount: 5,
        price: 4,
        description: 'Soft Arabic bread, baked fresh every morning.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 17,
        name: 'Butter Croissant',
        image: _marketImage('1555507036-ab1f4038808a'),
        category: 'Bakery',
        subCategory: 'Pastries',
        unit: 'pcs',
        amount: 4,
        price: 12,
        offerPrice: 9.5,
        offerEndDate: DateTime.now().add(const Duration(days: 2)),
        description: 'Flaky butter croissants, baked in-house.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 18,
        name: 'Orange Juice',
        image: _marketImage('1621506289937-a8e4df240d0b'),
        category: 'Beverages',
        subCategory: 'Juices',
        unit: 'L',
        amount: 1,
        price: 11,
        description: 'Freshly squeezed orange juice with no added sugar.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 19,
        name: 'Mineral Water',
        image: _marketImage('1548839140-29a749e1cf4d'),
        category: 'Beverages',
        subCategory: 'Water',
        unit: 'pack',
        amount: 12,
        price: 8,
        description: 'Still mineral water, pack of 12 bottles.',
      ),
    ),
    _MockProduct(
      isMostRequested: true,
      details: ApiProductDetailsModel(
        id: 20,
        name: 'Basmati Rice',
        image: _marketImage('1586201375761-83865001e31c'),
        category: 'Pantry',
        subCategory: 'Rice',
        unit: 'kg',
        amount: 5,
        price: 32,
        offerPrice: 27.5,
        offerEndDate: DateTime.now().add(const Duration(days: 7)),
        description: 'Long-grain basmati rice, 5 kg family pack.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 21,
        name: 'Olive Oil',
        image: _marketImage('1474979266404-7eaacbcd87c5'),
        category: 'Pantry',
        subCategory: 'Oils',
        unit: 'L',
        amount: 1,
        price: 36,
        description: 'Extra virgin olive oil, cold pressed.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 22,
        name: 'Fresh Mint',
        image: _marketImage('1466637574441-749b8f19452f'),
        category: 'Herbs',
        subCategory: 'Fresh Herbs',
        unit: 'bunch',
        amount: 1,
        price: 3.5,
        description: 'Fragrant mint bunches, harvested the same day.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 23,
        name: 'Garlic',
        image: _marketImage('1508747703725-719777637510'),
        category: 'Herbs',
        subCategory: 'Garlic & Onion',
        unit: 'kg',
        amount: 0.5,
        price: 9,
        description: 'Fresh garlic bulbs with a strong aroma.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 24,
        name: 'Mixed Spices',
        image: _marketImage('1596040033229-a9821ebd058d'),
        category: 'Herbs',
        subCategory: 'Spices',
        unit: 'pack',
        amount: 1,
        price: 15,
        description: 'Aromatic mixed spices for everyday cooking.',
      ),
    ),
  ];

  @override
  Future<ApiPaginatedData<ApiProductModel>> getProducts(GetProductsParams params) async {
    await Future<void>.delayed(_delay);

    Iterable<_MockProduct> items = _products;
    if (params.offersProductsOnly == true) {
      items = items.where((product) => product.details.offerPrice != null);
    }
    if (params.mostRequestedProductsOnly == true) {
      items = items.where((product) => product.isMostRequested);
    }

    return _paginate(items.map(_toListModel).toList(), params.page);
  }

  @override
  Future<ApiProductDetailsModel> showProductDetails(int id) async {
    await Future<void>.delayed(_delay);
    final product = _products.where((item) => item.details.id == id).firstOrNull;
    if (product == null) {
      throw ServerException(message: 'Product not found');
    }
    return product.details;
  }

  ApiProductModel _toListModel(_MockProduct product) {
    final details = product.details;
    return ApiProductModel(
      id: details.id,
      name: details.name,
      image: details.image,
      category: details.category,
      unit: details.unit,
      price: details.price,
      offerPrice: details.offerPrice,
      amount: details.amount,
    );
  }

  ApiPaginatedData<ApiProductModel> _paginate(List<ApiProductModel> items, int page) {
    const perPage = 10;
    final lastPage = items.isEmpty ? 1 : (items.length / perPage).ceil();
    final start = (page - 1) * perPage;
    final pagedItems = start >= items.length ? const <ApiProductModel>[] : items.skip(start).take(perPage).toList();

    return ApiPaginatedData(
      items: pagedItems,
      pageInfo: PageInfo(currentPage: page, lastPage: lastPage, totalPages: lastPage, countPerPage: perPage, totalItemsCount: items.length),
    );
  }
}
