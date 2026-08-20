import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../common/domain/entity/invoice_entity.dart';
import '../../domain/use_case/charage_wallet_use_case.dart';

// typedef CharageWalletState = Async<Unit>;
typedef CharageWalletState = Async<InvoiceEntity>;

@Injectable()
class CharageWalletCubit extends Cubit<CharageWalletState> {
  CharageWalletCubit(this._charageWalletUseCase) : super(const Async.initial());

  final CharageWalletUseCase _charageWalletUseCase;

  void chargeWallet(int amount) async {
    emit(const Async.loading());
    final result = await _charageWalletUseCase(amount);
    result.fold(
      (failer) {
        emit(Async.failure(failer));
      },
      (data) {
        emit(Async.success(data));
      },
    );
    emit(const Async.initial());
  }

  @override
  void emit(CharageWalletState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
