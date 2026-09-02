import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/usecases/update_cart_delivery_fees_usecase.dart';
import '../../domain/usecases/upsert_cart_item_usecase.dart';
import '../models/api_cart_item_model.dart';
import '../models/api_cart_model.dart';

abstract class CartDatasource {
  Future<ApiCartModel> getCartItems(NoParams params);
  Future<ApiCartModel> upsertCartItem(AddToCartParams params);
  Future<ApiCartModel> deleteItemFromCart(int cartItemId);
  Future<ApiCartModel> updateCartDeliveryFees(UpdateCartDeliveryFeesParams params);
  Future<String> checkoutCart(NoParams params);
}

@Injectable(as: CartDatasource)
class CartDatasourceImpl extends CartDatasource {
  final DioHelper _dioHelper;
  CartDatasourceImpl(this._dioHelper);

  @override
  Future<ApiCartModel> getCartItems(NoParams params) async {
    try {
      final response = await _dioHelper.get(url: ApiConstants.addToApiUrlPath('cart'));
      return ApiCartModel.fromJson(response['data'] ?? {});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiCartModel> upsertCartItem(AddToCartParams params) async {
    try {
      switch (params.upsertType) {
        case UpsertTypeEnum.add:
          final response = await _dioHelper.post(url: ApiConstants.addToApiUrlPath('cart'), json: params.toMap);
          final data = response['data'];
          if (data is! Map<String, dynamic>) {
            throw ServerException(message: response['message']?.toString() ?? '');
          }
          final addedItem = ApiCartItemModel.fromJson(data);
          final cart = await getCartItems(NoParams());
          if (cart.items == null || cart.items!.isEmpty) {
            return ApiCartModel(
              id: cart.id,
              items: [addedItem],
              productsPrice: addedItem.price,
              deliveryPrice: cart.deliveryPrice,
              totalPrice: addedItem.price,
              taxAmount: cart.taxAmount,
              savingsAmount: cart.savingsAmount,
              hasUnavailableItems: addedItem.unavailable == true,
            );
          }
          return cart;
        case UpsertTypeEnum.increase:
        case UpsertTypeEnum.decrease:
          final action = params.upsertType == UpsertTypeEnum.increase ? 'increase' : 'decrease';
          await _dioHelper.post(
            url: ApiConstants.addToApiUrlPath('cart/${params.cartItemId}/$action'),
            json: params.toMap,
          );
          return getCartItems(NoParams());
        case UpsertTypeEnum.update:
          final response = await _dioHelper.post(
            url: ApiConstants.addToApiUrlPath('carts/${params.productId}/update-cart-product-quantity'),
            body: params.toMap,
          );
          return ApiCartModel.fromJson(response['data']['cart'] ?? {});
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiCartModel> deleteItemFromCart(int cartItemId) async {
    try {
      await _dioHelper.delete(url: ApiConstants.addToApiUrlPath('cart/$cartItemId'));
      return getCartItems(NoParams());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiCartModel> updateCartDeliveryFees(UpdateCartDeliveryFeesParams params) async {
    try {
      final response = await _dioHelper.post(url: ApiConstants.addToApiUrlPath('carts/update-delivery-fees'), body: params.toMap);
      return ApiCartModel.fromJson(response['data']['cart']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> checkoutCart(NoParams params) async {
    try {
      final response = await _dioHelper.post(url: ApiConstants.addToApiUrlPath('carts/checkout'));
      final message = response['message'] ?? response['data']?['message'];
      return message?.toString() ?? '';
    } catch (e) {
      rethrow;
    }
  }
}
