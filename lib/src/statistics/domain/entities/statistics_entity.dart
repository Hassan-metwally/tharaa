import 'package:equatable/equatable.dart';

class StatisticsEntity extends Equatable {
  final int? newOrdersCount;
  final int? inProgressOrdersCount;
  final int? finishedOrdersCount;
  final int? completedOrdersCount;
  final int? remainingOrdersCount;

  const StatisticsEntity({
    required this.newOrdersCount,
    required this.inProgressOrdersCount,
    required this.finishedOrdersCount,
    required this.completedOrdersCount,
    required this.remainingOrdersCount,
  });

  const StatisticsEntity.initial()
    : newOrdersCount = 0,
      inProgressOrdersCount = 0,
      finishedOrdersCount = 0,
      completedOrdersCount = 0,
      remainingOrdersCount = 0;

  @override
  List<Object?> get props => [newOrdersCount, inProgressOrdersCount, finishedOrdersCount, completedOrdersCount, remainingOrdersCount];
}
