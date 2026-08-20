import 'package:equatable/equatable.dart';

class BalanceEntity extends Equatable {
  final double currentBalance;

  const BalanceEntity({required this.currentBalance});

  BalanceEntity copyWith({double? currentBalance}) => BalanceEntity(currentBalance: currentBalance ?? this.currentBalance);

  @override
  List<Object?> get props => [currentBalance];
}
