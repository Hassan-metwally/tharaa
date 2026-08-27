import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';

import '../../domain/entities/order_details_entity.dart';

import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/orders_repository.dart';

import '../../domain/usecases/add_order_usecase.dart';
import '../../domain/usecases/get_orders_usecase.dart';

import '../../domain/usecases/toggle_order_status_usecase.dart';

import '../datasources/orders_datasource.dart';

import '../models/api_order_details_model.dart';

import '../models/api_order_model.dart';

@Injectable(as: OrdersRepository)
class OrdersRepositoryImpl extends OrdersRepository {
  final OrdersDatasource _dataSource;

  OrdersRepositoryImpl(this._dataSource);


  @override
  DomainServiceType<OrderEntity> addOrder(UpsertOrderParams params) async {
    return await failureCollect(() async {
      final result = await _dataSource.addOrder(params);
      return Right(result.map);
    });
  }

  @override
  DomainServiceType<OrderDetailsEntity> showOrderDetails(int id) async {
    return await failureCollect(() async {
      final result = await _dataSource.showOrderDetails(id);
      return Right(result.map);
    });
  }

  @override
  DomainServiceType<PaginatedData<OrderEntity>> getOrders(GetOrdersParams params) async {
    return await failureCollect(() async {
      final result = await _dataSource.getOrders(params);

      return Right(result.map((data) => data.map));
    });
  }

  @override
  DomainServiceType<String> toggleOrderStatus(ToggleOrderStatusParams params) async {
    return await failureCollect(() async {
      final result = await _dataSource.toggleOrderStatus(params);
      return Right(result);
    });
  }
}
