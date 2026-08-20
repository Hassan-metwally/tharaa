import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../common/domain/entity/common_entity.dart';
import '../repository/wallet_repository.dart';

@injectable
class WithdrawBalanceUseCase extends IUseCase<void, WithdrawBalanceParams> {
  final WalletRepository _repository;

  WithdrawBalanceUseCase(this._repository);
  @override
  Future<Either<Failure, void>> call(WithdrawBalanceParams params) async {
    return await _repository.withdrawBalance(params);
  }
}

class WithdrawBalanceParams extends Equatable {
  final num amount;
  final CommonEntity bank;
  final String accountName;
  final String accountNumber;
  final String iban;

  const WithdrawBalanceParams({
    required this.amount,
    required this.bank,
    required this.accountName,
    required this.accountNumber,
    required this.iban,
  });

  factory WithdrawBalanceParams.initial() =>
      WithdrawBalanceParams(amount: 0, bank: CommonEntity.initial(), accountName: '', accountNumber: '', iban: '');

  WithdrawBalanceParams copyWith({num? amount, CommonEntity? bank, String? accountName, String? accountNumber, String? iban}) =>
      WithdrawBalanceParams(
        amount: amount ?? this.amount,
        bank: bank ?? this.bank,
        accountName: accountName ?? this.accountName,
        accountNumber: accountNumber ?? this.accountNumber,
        iban: iban ?? this.iban,
      );

  Map<String, dynamic> get toMap {
    return {'amount': amount, 'bank_id': bank.id, 'account_name': accountName, 'account_number': accountNumber, 'iban': iban};
  }

  @override
  List<Object?> get props => [amount, bank, accountName, accountNumber, iban];
}
