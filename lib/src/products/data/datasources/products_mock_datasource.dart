import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../categories/data/models/api_category_model.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../models/api_product_details_model.dart';
import '../models/api_product_model.dart';
import 'products_datasource.dart';

AttachmentEntity _marketImage(String photoId) {
  return AttachmentEntity.fromNetwork(
    url: 'https://images.unsplash.com/photo-$photoId?auto=format&fit=crop&w=400&h=400&q=80',
  );
}

final _vegetables = ApiCategoryModel(id: 1, name: 'Vegetables', image: _marketImage('1540420773420-3366772f4999'));
final _fruits = ApiCategoryModel(id: 2, name: 'Fruits', image: _marketImage('1619566636858-adf3ef46400b'));
final _dairy = ApiCategoryModel(id: 3, name: 'Dairy', image: _marketImage('1628088062854-d1870b4553da'));
final _meat = ApiCategoryModel(id: 4, name: 'Meat', image: _marketImage('1607623814075-e51df1bdc82f'));
final _bakery = ApiCategoryModel(id: 5, name: 'Bakery', image: _marketImage('1509440159596-0249088772ff'));
final _beverages = ApiCategoryModel(id: 6, name: 'Beverages', image: _marketImage('1621506289937-a8e4df240d0b'));
final _pantry = ApiCategoryModel(id: 7, name: 'Pantry', image: _marketImage('1586201375761-83865001e31c'));
final _herbs = ApiCategoryModel(id: 8, name: 'Herbs', image: _marketImage('1466637574441-749b8f19452f'));

final _tomatoes = ApiCategoryModel(id: 11, name: 'Tomatoes', image: _marketImage('1546470427-227c7abf47d6'));
final _leafyGreens = ApiCategoryModel(id: 12, name: 'Leafy Greens', image: _marketImage('1576045057995-98f4c9701d2e'));
final _potatoes = ApiCategoryModel(id: 13, name: 'Potatoes', image: _marketImage('1518977676601-b53f82aba655'));
final _carrots = ApiCategoryModel(id: 14, name: 'Carrots', image: _marketImage('1598170845058-32b9d6a5da37'));
final _apples = ApiCategoryModel(id: 21, name: 'Apples', image: _marketImage('1560806887-1e4cd0b6cbd6'));
final _bananas = ApiCategoryModel(id: 22, name: 'Bananas', image: _marketImage('1571771894821-ce9b6c11b08e'));
final _citrus = ApiCategoryModel(id: 23, name: 'Citrus', image: _marketImage('1547514701-42782101795e'));
final _berries = ApiCategoryModel(id: 24, name: 'Berries', image: _marketImage('1464965911861-746a04b4bca6'));
final _milk = ApiCategoryModel(id: 31, name: 'Milk', image: _marketImage('1563636619-e9143da7973b'));
final _cheese = ApiCategoryModel(id: 32, name: 'Cheese', image: _marketImage('1486297678162-eb2a19b0a32d'));
final _yogurt = ApiCategoryModel(id: 33, name: 'Yogurt', image: _marketImage('1488477181946-6428a0291777'));
final _eggs = ApiCategoryModel(id: 34, name: 'Eggs', image: _marketImage('1582722872445-44dc5f7e3c8f'));
final _beef = ApiCategoryModel(id: 41, name: 'Beef', image: _marketImage('1603048297172-c92544798d5a'));
final _chicken = ApiCategoryModel(id: 42, name: 'Chicken', image: _marketImage('1604503468506-a8da13d82791'));
final _fish = ApiCategoryModel(id: 43, name: 'Fish', image: _marketImage('1519708227418-c8fd9a32b7a2'));
final _bread = ApiCategoryModel(id: 51, name: 'Bread', image: _marketImage('1509440159596-0249088772ff'));
final _pastries = ApiCategoryModel(id: 52, name: 'Pastries', image: _marketImage('1555507036-ab1f4038808a'));
final _juices = ApiCategoryModel(id: 61, name: 'Juices', image: _marketImage('1621506289937-a8e4df240d0b'));
final _water = ApiCategoryModel(id: 62, name: 'Water', image: _marketImage('1548839140-29a749e1cf4d'));
final _rice = ApiCategoryModel(id: 71, name: 'Rice', image: _marketImage('1586201375761-83865001e31c'));
final _oils = ApiCategoryModel(id: 73, name: 'Oils', image: _marketImage('1474979266404-7eaacbcd87c5'));
final _freshHerbs = ApiCategoryModel(id: 81, name: 'Fresh Herbs', image: _marketImage('1466637574441-749b8f19452f'));
final _spices = ApiCategoryModel(id: 82, name: 'Spices', image: _marketImage('1596040033229-a9821ebd058d'));
final _garlicOnion = ApiCategoryModel(id: 83, name: 'Garlic & Onion', image: _marketImage('1508747703725-719777637510'));

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
        volume: 1,
        id: 3,
        offerPrice: 6.5,
        offerEndDate: DateTime.now().add(const Duration(days: 5)),
        name: 'Potatoes',
        image: _marketImage('1518977676601-b53f82aba655'),
        category: _vegetables,
        subCategory: _potatoes,
        unit: 'kg',
        amount: 2,
        price: 7,
        description: 'Local potatoes suitable for frying, boiling, and baking.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 4, volume: 1,
        offerPrice: 4.75,
        offerEndDate: DateTime.now().add(const Duration(days: 3)),
        name: 'Carrots',
        image: _marketImage('1598170845058-32b9d6a5da37'),
        category: _vegetables,
        subCategory: _carrots,
        unit: 'kg',
        amount: 1,
        price: 6,
        
        description: 'Sweet orange carrots packed with flavor and crunch.',
      ),
    ),
    _MockProduct(
      isMostRequested: true,
      details: ApiProductDetailsModel(
        id: 5,
        volume: 1,
        offerPrice: 12,
        offerEndDate: DateTime.now().add(const Duration(days: 5)),
        name: 'Red Apples',
        image: _marketImage('1560806887-1e4cd0b6cbd6'),
        category: _fruits,
        subCategory: _apples,
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
        volume: 1,
        offerPrice: 7.9,
        offerEndDate: DateTime.now().add(const Duration(days: 2)),
        name: 'Bananas',
        image: _marketImage('1571771894821-ce9b6c11b08e'),
        category: _fruits,
        subCategory: _bananas,
        unit: 'kg',
        amount: 1,
        price: 9.5,
        description: 'Naturally ripened bananas, ready to eat.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 7,
        volume: 1,
        offerPrice: 4.75,
        offerEndDate: DateTime.now().add(const Duration(days: 3)),
        name: 'Oranges',
        image: _marketImage('1547514701-42782101795e'),
        category: _fruits,
        subCategory: _citrus,
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
        category: _fruits,
        subCategory: _berries,
        volume: 1,
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
        volume: 1,
        offerPrice: 7.9,
        offerEndDate: DateTime.now().add(const Duration(days: 2)),
        name: 'Fresh Milk',
        image: _marketImage('1563636619-e9143da7973b'),
        category: _dairy,
        subCategory: _milk,
        unit: 'L',
        amount: 1,
        price: 6.5,
        description: 'Full-fat fresh milk, chilled and ready to serve.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 10,
        volume: 1,
        offerPrice: 22,
        offerEndDate: DateTime.now().add(const Duration(days: 4)),
        name: 'Cheddar Cheese',
        image: _marketImage('1486297678162-eb2a19b0a32d'),
        category: _dairy,
        subCategory: _cheese,
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
        category: _dairy,
        subCategory: _yogurt,
        unit: 'cup',
        amount: 4,
        volume: 1,
        offerPrice: 11.5,
        offerEndDate: DateTime.now().add(const Duration(days: 4)),
        price: 14,
        description: 'Creamy Greek yogurt, unsweetened and high in protein.',
      ),
    ),
    _MockProduct(
      isMostRequested: true,
      details: ApiProductDetailsModel(
        id: 12,
        volume: 1,
        offerPrice: 19,
        offerEndDate: DateTime.now().add(const Duration(days: 4)),
        name: 'Farm Eggs',
        image: _marketImage('1582722872445-44dc5f7e3c8f'),
        category: _dairy,
        subCategory: _eggs,
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
        category: _meat,
        subCategory: _beef, volume: 1,  
        unit: 'kg',
        amount: 1,
        price: 48,
        offerPrice: 40,
        offerEndDate: DateTime.now().add(const Duration(days: 6)),
        description: 'Premium beef steak cuts, trimmed and ready to cook.',
      ),
    ),
    _MockProduct(
      isMostRequested: true,
      details: ApiProductDetailsModel(
        id: 14,
        name: 'Chicken Breast',
        image: _marketImage('1604503468506-a8da13d82791'),
        category: _meat,
        subCategory: _chicken,
        volume: 1,
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
        name: 'Fresh Salmon', volume: 1,
        image: _marketImage('1519708227418-c8fd9a32b7a2'),
        category: _meat,
        subCategory: _fish,
        unit: 'kg', amount: 1,
        price: 55, offerPrice: 45,
        offerEndDate: DateTime.now().add(const Duration(days: 6)),
        description: 'Atlantic salmon fillets, kept on ice until delivery.',
      ),
    ),
    _MockProduct(
      isMostRequested: true,
      details: ApiProductDetailsModel(
        id: 16,
        name: 'Arabic Bread',
        image: _marketImage('1509440159596-0249088772ff'),
        category: _bakery,
        subCategory: _bread,
        unit: 'pack',
        amount: 5,
        volume: 1,
        offerPrice: 3.5,
        offerEndDate: DateTime.now().add(const Duration(days: 2)),
        price: 4,
        description: 'Soft Arabic bread, baked fresh every morning.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 17,
        name: 'Butter Croissant',
        image: _marketImage('1555507036-ab1f4038808a'),
        category: _bakery,
        subCategory: _pastries,
        unit: 'pcs',
        amount: 4,
        price: 12,
        offerPrice: 9.5,
        offerEndDate: DateTime.now().add(const Duration(days: 2)),
        description: 'Flaky butter croissants, baked in-house.',
        volume: 1,
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 18,
        name: 'Orange Juice',
        image: _marketImage('1621506289937-a8e4df240d0b'),
        category: _beverages,
        subCategory: _juices,
        unit: 'L',
        amount: 1,
        price: 11,
        description: 'Freshly squeezed orange juice with no added sugar.',
        volume: 1,
        offerPrice: 9.5,
        offerEndDate: DateTime.now().add(const Duration(days: 2)),
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 19,
        name: 'Mineral Water',
        image: _marketImage('1548839140-29a749e1cf4d'),
        category: _beverages,
        subCategory: _water,
        unit: 'pack',
        amount: 12, volume: 1,
        offerPrice: 7,
        offerEndDate: DateTime.now().add(const Duration(days: 2)),
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
        category: _pantry,
        subCategory: _rice,
        unit: 'kg',
        amount: 5,
        price: 32,
        volume: 1,
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
        category: _pantry,
        subCategory: _oils,
        unit: 'L',
        amount: 1,
        volume: 1,
        price: 36, offerPrice: 30,
        offerEndDate: DateTime.now().add(const Duration(days: 3)),
        description: 'Extra virgin olive oil, cold pressed.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 22,
        name: 'Fresh Mint',
        image: _marketImage('1466637574441-749b8f19452f'),
        category: _herbs,
        subCategory: _freshHerbs,
        unit: 'bunch',
        amount: 0.5,
        offerPrice: 2.5,
        offerEndDate: DateTime.now().add(const Duration(days: 3)),
        volume: 1,
        price: 3.5,
        description: 'Fragrant mint bunches, harvested the same day.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 23,
        name: 'Garlic',
        image: _marketImage('1508747703725-719777637510'),
        category: _herbs,
        subCategory: _garlicOnion,
        unit: 'kg',
        amount: 0.5,
        volume: 1,
        price: 9, offerPrice: 7.5,
        offerEndDate: DateTime.now().add(const Duration(days: 3)),
        description: 'Fresh garlic bulbs with a strong aroma.',
      ),
    ),
    _MockProduct(
      details: ApiProductDetailsModel(
        id: 24,
        name: 'Mixed Spices',
        image: _marketImage('1596040033229-a9821ebd058d'),
        category: _herbs,
        subCategory: _spices,
        unit: 'pack',
        amount: 1,
        volume: 1,
        price: 15,
        offerPrice: 12.5,
        offerEndDate: DateTime.now().add(const Duration(days: 3)),
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

    return _paginate(items.map(_toListModel).toList(), params.page ?? 1);
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
      volume: details.volume,
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
