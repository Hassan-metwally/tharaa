import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/transaction_entity.dart';
import '../repository/wallet_repository.dart';

@injectable
class GetWalletHistoryUseCase extends IUseCase<PaginatedData<TransactionEntity>, GetWalletHistoryParams> {
  final WalletRepository _repository;

  GetWalletHistoryUseCase(this._repository);
  @override
  Future<Either<Failure, PaginatedData<TransactionEntity>>> call(GetWalletHistoryParams params) async {
    return await _repository.getWalletHistory(params);
  }
}

class GetWalletHistoryParams extends Equatable {
  final int page;
  const GetWalletHistoryParams({required this.page});
  Map<String, dynamic> toMap() => {'page': page};
  @override
  List<Object?> get props => [page];
}
