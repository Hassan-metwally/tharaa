import '../../domain/entities/balance_entity.dart';

class ApiBalanceModel {
  final double? currentBalance;

  ApiBalanceModel({this.currentBalance});

  factory ApiBalanceModel.fromJson(Map<String, dynamic> json) {
    return ApiBalanceModel(currentBalance: double.tryParse(json['balance'].toString()));
  }
}

extension ApiBalanceModelExt on ApiBalanceModel {
  BalanceEntity get map => BalanceEntity(currentBalance: currentBalance ?? 0);
}
