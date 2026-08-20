import '../../domain/entities/statistics_entity.dart';

class ApiStatisticsModel {
  final int? newOrdersCount;
  final int? inProgressOrdersCount;
  final int? finishedOrdersCount;
  final int? completedOrdersCount;
  final int? remainingOrdersCount;

  ApiStatisticsModel({
    required this.newOrdersCount,
    required this.inProgressOrdersCount,
    required this.finishedOrdersCount,
    required this.completedOrdersCount,
    required this.remainingOrdersCount,
  });

  factory ApiStatisticsModel.fromJson(Map<String, dynamic> json) => ApiStatisticsModel(
    newOrdersCount: json["new_orders_count"],
    inProgressOrdersCount: json["in_progress_orders_count"],
    finishedOrdersCount: json["finished_orders_count"],
    completedOrdersCount: json["completed_orders_count"],
    remainingOrdersCount: json["remaining_orders_count"],
  );
}

extension ApiStatisticsEXT on ApiStatisticsModel {
  StatisticsEntity get map => StatisticsEntity(
    newOrdersCount: newOrdersCount,
    inProgressOrdersCount: inProgressOrdersCount,
    finishedOrdersCount: finishedOrdersCount,
    completedOrdersCount: completedOrdersCount,
    remainingOrdersCount: remainingOrdersCount,
  );
}
