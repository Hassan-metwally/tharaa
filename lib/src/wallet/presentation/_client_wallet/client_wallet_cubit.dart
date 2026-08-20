import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../common/domain/entity/common_entity.dart';
import '../../domain/entities/balance_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/use_case/get_balance_use_case.dart';
import '../../domain/use_case/get_wallet_history_use_case.dart';
import '../../domain/use_case/withdraw_balance_use_case.dart';

part "client_wallet_state.dart";

@Injectable()
class ClientWalletCubit extends Cubit<ClientWalletState> {
  ClientWalletCubit(this._getWalletInfoUseCase, this._withdrawBalanceUseCase, this._getBalanceUseCase)
    : super(const ClientWalletState.initial());

  final GetWalletHistoryUseCase _getWalletInfoUseCase;
  final GetBalanceUseCase _getBalanceUseCase;
  final WithdrawBalanceUseCase _withdrawBalanceUseCase;

  void getBalance() async {
    emit(state.copyWith(getBalanceState: const Async.loading()));
    final result = await _getBalanceUseCase(NoParams());
    result.fold((failure) => emit(state.copyWith(getBalanceState: Async.failure(failure))), (data) async {
      emit(state.copyWith(getBalanceState: Async.success(data)));
    });
  }

  void getWalletHistory() async {
    emit(state.copyWith(getWalletHistoryState: const Async.loading(), currentPage: 1));
    final result = await _getWalletInfoUseCase(GetWalletHistoryParams(page: state.currentPage));
    result.fold((failure) => emit(state.copyWith(getWalletHistoryState: Async.failure(failure))), (data) async {
      emit(state.copyWith(getWalletHistoryState: Async.success(data.items), lastPage: data.pageInfo.lastPage));
    });
  }

  void getMoreWalletHistory() async {
    if (state.currentPage == state.lastPage) return;
    emit(state.copyWith(currentPage: state.currentPage + 1));
    final result = await _getWalletInfoUseCase(GetWalletHistoryParams(page: state.currentPage));
    result.fold(
      (failure) => emit(state.copyWith(getWalletHistoryState: Async.failure(failure), currentPage: state.currentPage - 1)),
      (data) => emit(state.copyWith(getWalletHistoryState: Async.success([...state.getWalletHistoryState.data ?? [], ...data.items]))),
    );
  }

  void withdrawBalance({
    required num amount,
    required CommonEntity bank,
    required String accountName,
    required String accountNumber,
    required String iban,
  }) async {
    emit(state.copyWith(withDrawState: const Async.loading()));
    final result = await _withdrawBalanceUseCase(
      WithdrawBalanceParams(amount: amount, bank: bank, accountName: accountName, accountNumber: accountNumber, iban: iban),
    );
    result.fold(
      (failure) => emit(state.copyWith(withDrawState: Async.failure(failure))),
      (_) => emit(
        state.copyWith(getBalanceState: Async.success(state.getBalanceState.data!), withDrawState: const Async.successWithoutData()),
      ),
    );
    emit(state.copyWith(withDrawState: const Async.initial()));
  }

  @override
  void emit(ClientWalletState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
