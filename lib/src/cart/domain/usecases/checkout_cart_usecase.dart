import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../repositories/cart_repository.dart';

class CheckoutCartUsecase extends IUseCase<String, NoParams> {
  final CartRepository _cartRepository;

  CheckoutCartUsecase(this._cartRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await _cartRepository.checkoutCart(params);
  }
}
