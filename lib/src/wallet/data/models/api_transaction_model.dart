import '../../domain/entities/transaction_entity.dart';

class ApiTransactionModel {
  final int? id;
  final String? name;
  final String? amount;
  final TransactionTypeEnum? type;
  final String? notes;
  final DateTime? dateTime;
  ApiTransactionModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.type,
    required this.notes,
    required this.dateTime,
  });

  factory ApiTransactionModel.fromJson(Map<String, dynamic> json) {
    return ApiTransactionModel(
      id: json['id'],
      name: json['_transaction_reason'],
      amount: json['amount'].toString(),
      type: json['transaction_type'] != null ? TransactionTypeEnum.values.byName(json['transaction_type']) : null,
      notes: json['notes'],
      dateTime: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
    );
  }
}

extension ApiTransactionModelExt on ApiTransactionModel {
  TransactionEntity get map => TransactionEntity(
    id: id ?? 0,
    name: name ?? '',
    amount: amount ?? '0',
    type: type ?? TransactionTypeEnum.withdrawal,
    notes: notes,
    dateTime: dateTime ?? DateTime.now(),
  );
}
