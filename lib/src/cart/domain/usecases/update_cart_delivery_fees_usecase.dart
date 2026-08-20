import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

@Injectable()
class UpdateCartDeliveryFeesUsecase extends IUseCase<CartEntity, UpdateCartDeliveryFeesParams> {
  final CartRepository _cartRepository;
  UpdateCartDeliveryFeesUsecase(this._cartRepository);

  @override
  Future<Either<Failure, CartEntity>> call(UpdateCartDeliveryFeesParams params) async {
    return await _cartRepository.updateCartDeliveryFees(params);
  }
}

class UpdateCartDeliveryFeesParams extends Equatable {
  final int addressId;

  const UpdateCartDeliveryFeesParams({required this.addressId});

  factory UpdateCartDeliveryFeesParams.initial() => const UpdateCartDeliveryFeesParams(addressId: 0);

  UpdateCartDeliveryFeesParams copyWith({int? addressId}) {
    return UpdateCartDeliveryFeesParams(addressId: addressId ?? this.addressId);
  }

  Map<String, dynamic> get toMap => {'address_id': addressId};

  @override
  List<Object?> get props => [addressId];
}
