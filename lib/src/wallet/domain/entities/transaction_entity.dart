import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class TransactionEntity extends Equatable {
  final int id;
  final String name;
  final String amount;
  final TransactionTypeEnum type;
  final String? notes;
  final DateTime dateTime;

  const TransactionEntity({
    required this.id,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.notes,
    required this.type,
  });

  String get formattedDate => dateTime.DDMMMYYYY_HHMMA;

  @override
  List<Object?> get props => [id, name, amount, notes, type, dateTime];
}

enum TransactionTypeEnum {
  deposit("deposit"),
  withdrawal("withdrawal");

  final String apiValue;
  const TransactionTypeEnum(this.apiValue);

  String get icon {
    switch (this) {
      case TransactionTypeEnum.deposit:
        return "";
      case TransactionTypeEnum.withdrawal:
        return "";
    }
  }

  Color get color {
    switch (this) {
      case TransactionTypeEnum.deposit:
        return AppColors.success500;
      case TransactionTypeEnum.withdrawal:
        return AppColors.error;
    }
  }

    String get effect {
    switch (this) {
      case TransactionTypeEnum.deposit:
        return '+';
      case TransactionTypeEnum.withdrawal:
        return '-';
    }
  }
}
