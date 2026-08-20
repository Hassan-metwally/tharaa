import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

@Injectable()
class DeleteCartItemUsecase extends IUseCase<CartEntity, int> {
  final CartRepository _cartRepository;
  DeleteCartItemUsecase(this._cartRepository);
  @override
  Future<Either<Failure, CartEntity>> call(int id) async {
    return await _cartRepository.deleteItemFromCart(id);
  }
}
