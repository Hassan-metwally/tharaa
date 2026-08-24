import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../repositories/orders_repository.dart';

@injectable
class ToggleOrderStatusUseCase extends IUseCase<String, ToggleOrderStatusParams> {
  final OrdersRepository _repository;

  ToggleOrderStatusUseCase(this._repository);
  @override
  Future<Either<Failure, String>> call(ToggleOrderStatusParams params) {
    return _repository.toggleOrderStatus(params);
  }
}

class ToggleOrderStatusParams {
  final int id;
  final OrderStatusToggleActionEnum toggleAction;

  ToggleOrderStatusParams({required this.id, required this.toggleAction});
}

enum OrderStatusToggleActionEnum { pay, cancel, makeAsSold, favorite }
