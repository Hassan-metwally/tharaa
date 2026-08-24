import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/core.dart';
import '../../../common/domain/enums/orders/order_status_enum.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

@injectable
class GetOrdersUsecase extends IUseCase<PaginatedData<OrderEntity>, GetOrdersParams> {
  final OrdersRepository _repository;

  GetOrdersUsecase(this._repository);

  @override
  Future<Either<Failure, PaginatedData<OrderEntity>>> call(GetOrdersParams params) {
    return _repository.getOrders(params);
  }
}

class GetOrdersParams extends Equatable {
  final int page;
  final String? search;
  final OrderStatusEnum? status;
  final DateTime? date;

  const GetOrdersParams({required this.page, this.search, this.status, this.date});

  const GetOrdersParams.initial() : this(page: 1);

  GetOrdersParams copyWith({
    int? page,
    String? search,
    OrderStatusEnum? status,
    DateTime? date,
    bool clearStatus = false,
    bool clearSearch = false,
    bool clearDate = false,
  }) {
    return GetOrdersParams(
      page: page ?? this.page,
      search: clearSearch ? null : (search ?? this.search),
      status: clearStatus ? null : (status ?? this.status),
      date: clearDate ? null : (date ?? this.date),
    );
  }

  Map<String, dynamic> get toMap => {
    'page': page,
    if (search != null && search!.isNotEmpty) 'search': search,
    if (status != null) 'status': status!.value,
    if (date != null) 'date': date!.YYYY_MM_DD_EN,
  };

  @override
  List<Object?> get props => [page, search, status, date];
}
