import '../../../../core/core.dart';
import '../entities/cart_entity.dart';
import '../usecases/update_cart_delivery_fees_usecase.dart';
import '../usecases/upsert_cart_item_usecase.dart';

abstract class CartRepository {
  DomainServiceType<CartEntity> getCartItems(NoParams params);
  DomainServiceType<CartEntity> upsertCartItem(AddToCartParams params);
  DomainServiceType<CartEntity> deleteItemFromCart(int itemId);
  DomainServiceType<CartEntity> updateCartDeliveryFees(UpdateCartDeliveryFeesParams params);
  DomainServiceType<String> checkoutCart(NoParams params);
}
