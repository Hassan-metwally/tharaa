import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

@Injectable()
class GetCartItemsUsecase extends IUseCase<CartEntity, NoParams> {
  final CartRepository _cartRepository;
  GetCartItemsUsecase(this._cartRepository);
  @override
  Future<Either<Failure, CartEntity>> call(NoParams params) async {
    return await _cartRepository.getCartItems(params);
  }
}
