import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../common/domain/entity/invoice_entity.dart';
import '../repository/wallet_repository.dart';

@injectable
class CharageWalletUseCase extends IUseCase<InvoiceEntity, int> {
  final WalletRepository _repository;

  CharageWalletUseCase(this._repository);
  @override
  Future<Either<Failure, InvoiceEntity>> call(int params) async {
    return await _repository.charageBalance(params);
  }
}
