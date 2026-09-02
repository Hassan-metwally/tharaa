import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

@Injectable()
class UpsertCartItemUsecase extends IUseCase<CartEntity, AddToCartParams> {
  final CartRepository _cartRepository;
  UpsertCartItemUsecase(this._cartRepository);
  @override
  Future<Either<Failure, CartEntity>> call(AddToCartParams params) async {
    return await _cartRepository.upsertCartItem(params);
  }
}

class AddToCartParams extends Equatable {
  final int productId;
  final int? cartItemId;
  final int? quantity;
  final UpsertTypeEnum upsertType;
  const AddToCartParams({required this.productId, this.cartItemId, this.quantity, required this.upsertType});

  factory AddToCartParams.initial() => const AddToCartParams(productId: 1, quantity: 1, upsertType: UpsertTypeEnum.add);

  AddToCartParams copyWith({int? productId, int? cartItemId, int? quantity, UpsertTypeEnum? upsertType}) {
    return AddToCartParams(
      productId: productId ?? this.productId,
      cartItemId: cartItemId ?? this.cartItemId,
      quantity: quantity ?? this.quantity,
      upsertType: upsertType ?? this.upsertType,
    );
  }

  Map<String, dynamic> get toMap {
    switch (upsertType) {
      case UpsertTypeEnum.add:
        return {'product_id': productId, 'quantity': quantity ?? 1};
      case UpsertTypeEnum.increase:
      case UpsertTypeEnum.decrease:
        return {'quantity': quantity ?? 1};
      case UpsertTypeEnum.update:
        return {'_method': 'PATCH', 'quantity': quantity};
    }
  }

  @override
  List<Object?> get props => [productId, cartItemId, quantity, upsertType];
}

enum UpsertTypeEnum { add, update, increase, decrease }
