import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/balance_entity.dart';
import '../repository/wallet_repository.dart';

@injectable
class GetBalanceUseCase extends IUseCase<BalanceEntity, NoParams> {
  final WalletRepository _repository;

  GetBalanceUseCase(this._repository);
  @override
  Future<Either<Failure, BalanceEntity>> call(NoParams params) async {
    return await _repository.getBalance();
  }
}
