import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/usecases/update_cart_delivery_fees_usecase.dart';
import '../../domain/usecases/upsert_cart_item_usecase.dart';
import '../datasource/cart_datasource.dart';
import '../models/api_cart_model.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl extends CartRepository {
  final CartDatasource _dataSource;
  CartRepositoryImpl(this._dataSource);

  @override
  DomainServiceType<CartEntity> deleteItemFromCart(int itemId) async {
    return await failureCollect(() async {
      final result = await _dataSource.deleteItemFromCart(itemId);
      return Right(result.map);
    });
  }

  @override
  DomainServiceType<CartEntity> getCartItems(NoParams params) async {
    return await failureCollect(() async {
      final result = await _dataSource.getCartItems(params);
      return Right(result.map);
    });
  }

  @override
  DomainServiceType<CartEntity> upsertCartItem(AddToCartParams params) async {
    return await failureCollect(() async {
      final result = await _dataSource.upsertCartItem(params);
      return Right(result.map);
    });
  }

  @override
  DomainServiceType<CartEntity> updateCartDeliveryFees(UpdateCartDeliveryFeesParams params) async {
    return await failureCollect(() async {
      final result = await _dataSource.updateCartDeliveryFees(params);
      return Right(result.map);
    });
  }

  @override
  DomainServiceType<String> checkoutCart(NoParams params) async {
    return await failureCollect(() async {
      final result = await _dataSource.checkoutCart(params);
      return Right(result);
    });
  }
}
