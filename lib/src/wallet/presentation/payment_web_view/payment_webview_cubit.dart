import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';

typedef PaymanentWebViewState = Async<bool>;

class PaymanentWebViewCubit extends Cubit<PaymanentWebViewState> {
  PaymanentWebViewCubit() : super(const Async.initial());

  final Dio _dioObj = Dio();

  String? _checkPaymentUrl;

  void getPaymentStatus({String? url}) async {
    try {
      _checkPaymentUrl = _checkPaymentUrl ?? url;
      if (_checkPaymentUrl == null || _checkPaymentUrl?.isEmpty == true) {
        emit(const Async.failure(Failure()));
        return;
      }
      emit(const Async.loading());
      final response = await _dioObj.get(_checkPaymentUrl ?? ' ');
      final bool isResponseCodeOk = response.statusCode == 200;
      if (isResponseCodeOk) {
        final bool isPaid = response.data['status'] == 'success';
        if (isPaid) {
          emit(Async.success(isPaid));
        } else {
          emit(const Async.failure(Failure()));
        }
      } else {
        emit(const Async.failure(Failure()));
      }
    } catch (_) {
      emit(const Async.failure(Failure()));
    }
  }

  @override
  void emit(PaymanentWebViewState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
