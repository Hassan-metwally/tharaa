import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../entities/order_details_entity.dart';
import '../repositories/orders_repository.dart';

@injectable
class ShowOrderDetailsUsecase extends IUseCase<OrderDetailsEntity, int> {
  final OrdersRepository _repository;

  ShowOrderDetailsUsecase(this._repository);

  @override
  Future<Either<Failure, OrderDetailsEntity>> call(int id) {
    return _repository.showOrderDetails(id);
  }
}
