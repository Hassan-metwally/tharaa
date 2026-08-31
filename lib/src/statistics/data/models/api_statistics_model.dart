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

  factory ApiStatisticsModel.fromJson(Map<String, dynamic> json) {
    final newOrdersCount = json["new_orders_count"];
    final processingOrdersCount = json["processing_orders_count"] ?? json["in_progress_orders_count"];
    final completedOrdersCount = json["completed_orders_count"] ?? json["finished_orders_count"];
    return ApiStatisticsModel(
      newOrdersCount: newOrdersCount,
      inProgressOrdersCount: processingOrdersCount,
      finishedOrdersCount: completedOrdersCount,
      completedOrdersCount: completedOrdersCount,
      remainingOrdersCount: json["remaining_orders_count"] ?? processingOrdersCount,
    );
  }
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
