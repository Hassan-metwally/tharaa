import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../common/data/models/api_invoice_model.dart';
import '../../../common/domain/entity/invoice_entity.dart';
import '../../domain/entities/balance_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repository/wallet_repository.dart';
import '../../domain/use_case/get_wallet_history_use_case.dart';
import '../../domain/use_case/withdraw_balance_use_case.dart';
import '../models/api_balance_model.dart';
import '../models/api_transaction_model.dart';

@Injectable(as: WalletRepository)
class WalletRepositoryImp implements WalletRepository {
  final DioHelper dioHelper;

  const WalletRepositoryImp(this.dioHelper);

  @override
  DomainServiceType<PaginatedData<TransactionEntity>> getWalletHistory(GetWalletHistoryParams params) async {
    return await failureCollect(() async {
      final result = await dioHelper.get(url: '/shared-api/v1/wallet/history', queryParameters: params.toMap());
      final data = ApiPaginatedData.fromJson(result, getData: (data) => data.map((e) => ApiTransactionModel.fromJson(e)).toList());
      return Right(data.map((e) => e.map));
    });
  }

  @override
  DomainServiceType<void> withdrawBalance(WithdrawBalanceParams params) async {
    return await failureCollect(() async {
      await dioHelper.post(url: '/shared-api/v1/settlement-requests', body: params.toMap);
      return const Right(null);
    });
  }

  @override
  DomainServiceType<InvoiceEntity> charageBalance(int amount) async {
    return await failureCollect(() async {
      final response = await dioHelper.post(url: '/shared-api/v1/wallet/charge', body: {"amount": amount});
      final invoice = ApiInvoiceModel.fromJson(response["data"]);
      return Right(invoice.map);
    });
  }

  @override
  DomainServiceType<BalanceEntity> getBalance() async {
    return await failureCollect(() async {
      final response = await dioHelper.get(url: '/shared-api/v1/wallet/balance');
      final balance = ApiBalanceModel.fromJson(response["data"]);
      return Right(balance.map);
    });
  }
}
