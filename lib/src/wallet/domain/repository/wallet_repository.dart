import '../../../../core/core.dart';
import '../../../common/domain/entity/invoice_entity.dart';
import '../entities/balance_entity.dart';
import '../entities/transaction_entity.dart';
import '../use_case/get_wallet_history_use_case.dart';
import '../use_case/withdraw_balance_use_case.dart';

abstract class WalletRepository {
  DomainServiceType<PaginatedData<TransactionEntity>> getWalletHistory(GetWalletHistoryParams params);
  DomainServiceType<BalanceEntity> getBalance();
  DomainServiceType<void> withdrawBalance(WithdrawBalanceParams params);
  DomainServiceType<InvoiceEntity> charageBalance(int amount);
}
