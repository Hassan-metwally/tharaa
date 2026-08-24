import '../../../../core/core.dart';
import '../../domain/usecases/update_cart_delivery_fees_usecase.dart';
import '../../domain/usecases/upsert_cart_item_usecase.dart';
import '../models/api_cart_model.dart';

abstract class CartDatasource {
  Future<ApiCartModel> getCartItems(NoParams params);
  Future<ApiCartModel> upsertCartItem(AddToCartParams params);
  Future<ApiCartModel> deleteItemFromCart(int itemId);
  Future<ApiCartModel> updateCartDeliveryFees(UpdateCartDeliveryFeesParams params);
  Future<String> checkoutCart(NoParams params);
}

class CartDatasourceImpl extends CartDatasource {
  final DioHelper _dioHelper;
  CartDatasourceImpl(this._dioHelper);

  @override
  Future<ApiCartModel> getCartItems(NoParams params) async {
    try {
      final response = await _dioHelper.get(url: ApiConstants.addToApiUrlPath('carts/show-cart'));
      return ApiCartModel.fromJson(response['data']['cart'] ?? {});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiCartModel> upsertCartItem(AddToCartParams params) async {
    try {
      if (params.upsertType == UpsertTypeEnum.add) {
        final response = await _dioHelper.post(url: ApiConstants.addToApiUrlPath('carts/add-to-cart'), body: params.toMap);
        return ApiCartModel.fromJson(response['data']['cart'] ?? {});
      } else {
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
  Future<ApiCartModel> deleteItemFromCart(int itemId) async {
    try {
      final response = await _dioHelper.post(url: ApiConstants.addToApiUrlPath('carts/remove-from-cart'), body: {'product_id': itemId});
      return ApiCartModel.fromJson(response['data']?['cart'] ?? {});
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
