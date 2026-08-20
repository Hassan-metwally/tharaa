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
  final int? quantity;
  final UpsertTypeEnum upsertType;
  const AddToCartParams({required this.productId, this.quantity, required this.upsertType});

  factory AddToCartParams.initial() => const AddToCartParams(productId: 1, quantity: 1, upsertType: UpsertTypeEnum.add);

  AddToCartParams copyWith({int? productId, int? quantity, UpsertTypeEnum? upsertType}) {
    return AddToCartParams(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      upsertType: upsertType ?? this.upsertType,
    );
  }

  Map<String, dynamic> get toMap => {
    if (upsertType == UpsertTypeEnum.update) '_method': 'PATCH',
    if (upsertType == UpsertTypeEnum.add) 'product_id': productId,
    'quantity': quantity,
  };

  @override
  List<Object?> get props => [productId, quantity, upsertType];
}

enum UpsertTypeEnum { add, update }
