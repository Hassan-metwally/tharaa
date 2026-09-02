import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/usecases/update_cart_delivery_fees_usecase.dart';
import '../../domain/usecases/upsert_cart_item_usecase.dart';
import '../models/api_cart_item_model.dart';
import '../models/api_cart_model.dart';
import 'cart_datasource.dart';

AttachmentEntity _marketImage(String photoId) {
  return AttachmentEntity.fromNetwork(url: 'https://images.unsplash.com/photo-$photoId?auto=format&fit=crop&w=400&h=400&q=80');
}

class _MockCatalogProduct {
  final int id;
  final String name;
  final AttachmentEntity image;
  final num unitPrice;
  final int availableQuantity;

  const _MockCatalogProduct({required this.id, required this.name, required this.image, required this.unitPrice}) : availableQuantity = 50;
}

// @Injectable(as: CartDatasource)
class CartMockDatasource extends CartDatasource {
  static const _delay = Duration(milliseconds: 400);
  static const _defaultDeliveryPrice = 15.0;
  static const _savingsRate = 0.1;

  static num _deliveryPrice = _defaultDeliveryPrice;
  static int _nextCartItemId = 1;

  static final Map<int, _MockCatalogProduct> _catalog = {
    for (final product in [
      _MockCatalogProduct(id: 3, name: 'Potatoes', image: _marketImage('1518977676601-b53f82aba655'), unitPrice: 7),
      _MockCatalogProduct(id: 4, name: 'Carrots', image: _marketImage('1598170845058-32b9d6a5da37'), unitPrice: 6),
      _MockCatalogProduct(id: 5, name: 'Red Apples', image: _marketImage('1560806887-1e4cd0b6cbd6'), unitPrice: 12),
      _MockCatalogProduct(id: 6, name: 'Bananas', image: _marketImage('1571771894821-ce9b6c11b08e'), unitPrice: 9.5),
      _MockCatalogProduct(id: 7, name: 'Oranges', image: _marketImage('1547514701-42782101795e'), unitPrice: 10),
      _MockCatalogProduct(id: 8, name: 'Strawberries', image: _marketImage('1464965911861-746a04b4bca6'), unitPrice: 18),
      _MockCatalogProduct(id: 9, name: 'Fresh Milk', image: _marketImage('1563636619-e9143da7973b'), unitPrice: 6.5),
      _MockCatalogProduct(id: 10, name: 'Cheddar Cheese', image: _marketImage('1486297678162-eb2a19b0a32d'), unitPrice: 22),
      _MockCatalogProduct(id: 11, name: 'Greek Yogurt', image: _marketImage('1488477181946-6428a0291777'), unitPrice: 14),
      _MockCatalogProduct(id: 12, name: 'Farm Eggs', image: _marketImage('1582722872445-44dc5f7e3c8f'), unitPrice: 19),
      _MockCatalogProduct(id: 13, name: 'Beef Steak', image: _marketImage('1603048297172-c92544798d5a'), unitPrice: 48),
      _MockCatalogProduct(id: 14, name: 'Chicken Breast', image: _marketImage('1604503468506-a8da13d82791'), unitPrice: 28),
      _MockCatalogProduct(id: 15, name: 'Fresh Salmon', image: _marketImage('1519708227418-c8fd9a32b7a2'), unitPrice: 55),
      _MockCatalogProduct(id: 16, name: 'Arabic Bread', image: _marketImage('1509440159596-0249088772ff'), unitPrice: 4),
      _MockCatalogProduct(id: 17, name: 'Butter Croissant', image: _marketImage('1555507036-ab1f4038808a'), unitPrice: 12),
      _MockCatalogProduct(id: 18, name: 'Orange Juice', image: _marketImage('1621506289937-a8e4df240d0b'), unitPrice: 11),
      _MockCatalogProduct(id: 19, name: 'Mineral Water', image: _marketImage('1548839140-29a749e1cf4d'), unitPrice: 8),
      _MockCatalogProduct(id: 20, name: 'Basmati Rice', image: _marketImage('1586201375761-83865001e31c'), unitPrice: 32),
      _MockCatalogProduct(id: 21, name: 'Olive Oil', image: _marketImage('1474979266404-7eaacbcd87c5'), unitPrice: 36),
      _MockCatalogProduct(id: 22, name: 'Fresh Mint', image: _marketImage('1466637574441-749b8f19452f'), unitPrice: 3.5),
      _MockCatalogProduct(id: 23, name: 'Garlic', image: _marketImage('1508747703725-719777637510'), unitPrice: 9),
      _MockCatalogProduct(id: 24, name: 'Mixed Spices', image: _marketImage('1596040033229-a9821ebd058d'), unitPrice: 15),
    ])
      product.id: product,
  };

  static final List<ApiCartItemModel> _items = [
    _itemFromCatalog(_catalog[3]!, quantity: 2),
    _itemFromCatalog(_catalog[5]!, quantity: 1),
    _itemFromCatalog(_catalog[9]!, quantity: 3),
    _itemFromCatalog(_catalog[16]!, quantity: 2),
  ];

  @override
  Future<ApiCartModel> getCartItems(NoParams params) async {
    await Future<void>.delayed(_delay);
    return _buildCart();
  }

  @override
  Future<ApiCartModel> upsertCartItem(AddToCartParams params) async {
    await Future<void>.delayed(_delay);

    final quantity = params.quantity ?? 1;
    if (quantity < 1) {
      throw ServerException(message: 'Quantity must be at least 1');
    }

    switch (params.upsertType) {
      case UpsertTypeEnum.add:
        return _addCartItem(params, quantity);
      case UpsertTypeEnum.increase:
        return _changeCartItemQuantity(params.cartItemId, quantity, isIncrease: true);
      case UpsertTypeEnum.decrease:
        return _changeCartItemQuantity(params.cartItemId, quantity, isIncrease: false);
      case UpsertTypeEnum.update:
        return _setCartItemQuantity(params.productId, quantity);
    }
  }

  Future<ApiCartModel> _addCartItem(AddToCartParams params, int quantity) async {
    final existingIndex = _items.indexWhere((item) => item.productId == params.productId);

    if (existingIndex >= 0) {
      final existing = _items[existingIndex];
      final nextQuantity = (existing.cartQuantity ?? 0) + quantity;
      _assertAvailableQuantity(existing, nextQuantity);
      _items[existingIndex] = _withQuantity(existing, nextQuantity);
    } else {
      final catalogProduct = _catalog[params.productId];
      if (catalogProduct == null) {
        throw ServerException(message: 'Product not found');
      }
      _assertAvailableQuantity(_itemFromCatalog(catalogProduct, quantity: quantity), quantity);
      _items.add(_itemFromCatalog(catalogProduct, quantity: quantity));
    }

    return _buildCart();
  }

  Future<ApiCartModel> _changeCartItemQuantity(int? cartItemId, int delta, {required bool isIncrease}) async {
    if (cartItemId == null) {
      throw ServerException(message: 'Cart item not found');
    }

    final existingIndex = _items.indexWhere((item) => item.id == cartItemId);
    if (existingIndex < 0) {
      throw ServerException(message: 'Cart item not found');
    }

    final existing = _items[existingIndex];
    final currentQuantity = existing.cartQuantity ?? 0;
    final nextQuantity = isIncrease ? currentQuantity + delta : (currentQuantity - delta).clamp(1, currentQuantity);

    _assertAvailableQuantity(existing, nextQuantity);
    _items[existingIndex] = _withQuantity(existing, nextQuantity);

    return _buildCart();
  }

  Future<ApiCartModel> _setCartItemQuantity(int productId, int quantity) async {
    final existingIndex = _items.indexWhere((item) => item.productId == productId);
    if (existingIndex < 0) {
      throw ServerException(message: 'Cart item not found');
    }
    final existing = _items[existingIndex];
    _assertAvailableQuantity(existing, quantity);
    _items[existingIndex] = _withQuantity(existing, quantity);
    return _buildCart();
  }

  @override
  Future<ApiCartModel> deleteItemFromCart(int cartItemId) async {
    await Future<void>.delayed(_delay);
    final existingIndex = _items.indexWhere((item) => item.id == cartItemId);
    if (existingIndex < 0) {
      throw ServerException(message: 'Cart item not found');
    }
    _items.removeAt(existingIndex);
    return _buildCart();
  }

  @override
  Future<ApiCartModel> updateCartDeliveryFees(UpdateCartDeliveryFeesParams params) async {
    await Future<void>.delayed(_delay);
    _deliveryPrice = switch (params.addressId) {
      1 => 10,
      2 => 20,
      _ => _defaultDeliveryPrice,
    };
    return _buildCart();
  }

  @override
  Future<String> checkoutCart(NoParams params) async {
    await Future<void>.delayed(_delay);
    _items.clear();
    _deliveryPrice = _defaultDeliveryPrice;
    return 'Order placed successfully';
  }

  static ApiCartItemModel _itemFromCatalog(_MockCatalogProduct product, {required int quantity, int? id}) {
    return ApiCartItemModel(
      id: id ?? _nextCartItemId++,
      productId: product.id,
      productName: product.name,
      productImage: product.image,
      cartQuantity: quantity,
      availableQuantity: product.availableQuantity,
      unavailable: product.availableQuantity <= 0,
      price: _format(product.unitPrice * quantity),
    );
  }

  static ApiCartItemModel _withQuantity(ApiCartItemModel item, int quantity) {
    final unitPrice = _catalog[item.productId]?.unitPrice ?? 0;
    final availableQuantity = item.availableQuantity;
    return ApiCartItemModel(
      id: item.id,
      productId: item.productId,
      productName: item.productName,
      productImage: item.productImage,
      cartQuantity: quantity,
      availableQuantity: availableQuantity,
      unavailable: availableQuantity != null && availableQuantity <= 0,
      price: _format(unitPrice * quantity),
    );
  }

  static void _assertAvailableQuantity(ApiCartItemModel item, int quantity) {
    final available = item.availableQuantity;
    if (available != null && quantity > available) {
      throw ServerException(message: 'Requested quantity exceeds available stock');
    }
  }

  static ApiCartModel _buildCart() {
    final lineTotal = _items.fold<num>(0, (sum, item) => sum + (num.tryParse(item.price ?? '0') ?? 0));
    final savingsAmount = lineTotal * _savingsRate;
    final cartTotal = lineTotal + savingsAmount;
    final hasUnavailableItems = _items.any((item) => item.unavailable == true);

    return ApiCartModel(
      items: List<ApiCartItemModel>.from(_items),
      productsPrice: _format(cartTotal),
      deliveryPrice: _format(_deliveryPrice),
      totalPrice: _format(lineTotal),
      taxAmount: '',
      savingsAmount: _format(savingsAmount),
      hasUnavailableItems: hasUnavailableItems,
    );
  }

  static String _format(num value) {
    if (value == value.roundToDouble()) {
      return value.round().toString();
    }
    return value.toStringAsFixed(2);
  }
}
