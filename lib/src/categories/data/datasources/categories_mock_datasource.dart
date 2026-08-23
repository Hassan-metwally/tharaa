import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/usecases/get_main_categories_usecase.dart';
import '../../domain/usecases/get_sub_categories_usecase.dart';
import '../models/api_category_model.dart';
import 'categories_datasource.dart';

AttachmentEntity _marketImage(String photoId) {
  return AttachmentEntity.fromNetwork(
    url: 'https://images.unsplash.com/photo-$photoId?auto=format&fit=crop&w=400&h=400&q=80',
  );
}

@Injectable(as: CategoriesDatasource)
class CategoriesMockDatasource extends CategoriesDatasource {
  static const _delay = Duration(milliseconds: 400);

  static final List<ApiCategoryModel> _mainCategories = [
    ApiCategoryModel(id: 1, name: 'Vegetables', image: _marketImage('1540420773420-3366772f4999')),
    ApiCategoryModel(id: 2, name: 'Fruits', image: _marketImage('1619566636858-adf3ef46400b')),
    ApiCategoryModel(id: 3, name: 'Dairy', image: _marketImage('1628088062854-d1870b4553da')),
    ApiCategoryModel(id: 4, name: 'Meat', image: _marketImage('1607623814075-e51df1bdc82f')),
    ApiCategoryModel(id: 5, name: 'Bakery', image: _marketImage('1509440159596-0249088772ff')),
    ApiCategoryModel(id: 6, name: 'Beverages', image: _marketImage('1621506289937-a8e4df240d0b')),
    ApiCategoryModel(id: 7, name: 'Pantry', image: _marketImage('1586201375761-83865001e31c')),
    ApiCategoryModel(id: 8, name: 'Herbs', image: _marketImage('1466637574441-749b8f19452f')),
  ];

  static final Map<int, List<ApiCategoryModel>> _subCategoriesByParent = {
    1: [
      ApiCategoryModel(id: 11, name: 'Tomatoes', image: _marketImage('1546470427-227c7abf47d6')),
      ApiCategoryModel(id: 12, name: 'Leafy Greens', image: _marketImage('1576045057995-98f4c9701d2e')),
      ApiCategoryModel(id: 13, name: 'Potatoes', image: _marketImage('1518977676601-b53f82aba655')),
      ApiCategoryModel(id: 14, name: 'Carrots', image: _marketImage('1598170845058-32b9d6a5da37')),
    ],
    2: [
      ApiCategoryModel(id: 21, name: 'Apples', image: _marketImage('1560806887-1e4cd0b6cbd6')),
      ApiCategoryModel(id: 22, name: 'Bananas', image: _marketImage('1571771894821-ce9b6c11b08e')),
      ApiCategoryModel(id: 23, name: 'Citrus', image: _marketImage('1547514701-42782101795e')),
      ApiCategoryModel(id: 24, name: 'Berries', image: _marketImage('1464965911861-746a04b4bca6')),
    ],
    3: [
      ApiCategoryModel(id: 31, name: 'Milk', image: _marketImage('1563636619-e9143da7973b')),
      ApiCategoryModel(id: 32, name: 'Cheese', image: _marketImage('1486297678162-eb2a19b0a32d')),
      ApiCategoryModel(id: 33, name: 'Yogurt', image: _marketImage('1488477181946-6428a0291777')),
      ApiCategoryModel(id: 34, name: 'Eggs', image: _marketImage('1582722872445-44dc5f7e3c8f')),
    ],
    4: [
      ApiCategoryModel(id: 41, name: 'Beef', image: _marketImage('1603048297172-c92544798d5a')),
      ApiCategoryModel(id: 42, name: 'Chicken', image: _marketImage('1604503468506-a8da13d82791')),
      ApiCategoryModel(id: 43, name: 'Fish', image: _marketImage('1519708227418-c8fd9a32b7a2')),
    ],
    5: [
      ApiCategoryModel(id: 51, name: 'Bread', image: _marketImage('1509440159596-0249088772ff')),
      ApiCategoryModel(id: 52, name: 'Pastries', image: _marketImage('1555507036-ab1f4038808a')),
      ApiCategoryModel(id: 53, name: 'Cakes', image: _marketImage('1578985545062-69928b1d9587')),
    ],
    6: [
      ApiCategoryModel(id: 61, name: 'Juices', image: _marketImage('1621506289937-a8e4df240d0b')),
      ApiCategoryModel(id: 62, name: 'Water', image: _marketImage('1548839140-29a749e1cf4d')),
      ApiCategoryModel(id: 63, name: 'Coffee & Tea', image: _marketImage('1495474472287-4d71bcdd2085')),
    ],
    7: [
      ApiCategoryModel(id: 71, name: 'Rice', image: _marketImage('1586201375761-83865001e31c')),
      ApiCategoryModel(id: 72, name: 'Pasta', image: _marketImage('1621996346565-e3dbc646d9a9')),
      ApiCategoryModel(id: 73, name: 'Oils', image: _marketImage('1474979266404-7eaacbcd87c5')),
    ],
    8: [
      ApiCategoryModel(id: 81, name: 'Fresh Herbs', image: _marketImage('1466637574441-749b8f19452f')),
      ApiCategoryModel(id: 82, name: 'Spices', image: _marketImage('1596040033229-a9821ebd058d')),
      ApiCategoryModel(id: 83, name: 'Garlic & Onion', image: _marketImage('1508747703725-719777637510')),
    ],
  };

  @override
  Future<ApiPaginatedData<ApiCategoryModel>> getMainCategories(GetMainCategoriesParams params) async {
    await Future<void>.delayed(_delay);
    return _paginate(_mainCategories, params.page);
  }

  @override
  Future<ApiPaginatedData<ApiCategoryModel>> getSubCategories(GetSubCategoriesParams params) async {
    await Future<void>.delayed(_delay);
    final items = _subCategoriesByParent[params.categoryId] ?? const <ApiCategoryModel>[];
    return _paginate(items, params.page);
  }

  ApiPaginatedData<ApiCategoryModel> _paginate(List<ApiCategoryModel> items, int page) {
    const perPage = 10;
    final lastPage = items.isEmpty ? 1 : (items.length / perPage).ceil();
    final start = (page - 1) * perPage;
    final pagedItems = start >= items.length ? const <ApiCategoryModel>[] : items.skip(start).take(perPage).toList();

    return ApiPaginatedData(
      items: pagedItems,
      pageInfo: PageInfo(currentPage: page, lastPage: lastPage, totalPages: lastPage, countPerPage: perPage, totalItemsCount: items.length),
    );
  }
}
