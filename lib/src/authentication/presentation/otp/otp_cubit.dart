import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../domain/use_case/resend_otp_use_case.dart';
import '../../domain/use_case/verify_otp_use_case.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit({required this.arguments}) : super(const OtpState.initial());
  final OtpScreenArguments arguments;

  static OtpCubit of(BuildContext context) => BlocProvider.of<OtpCubit>(context);

  late final VerifyOtpUseCase _verifyOtpUseCase = injector();
  late final ResendOtpUseCase _resendOtpUseCase = injector();

  void verify(String verificationCode) async {
    emit(state.copyWith(verifyState: const Async.loading()));
    final result = await _verifyOtpUseCase(
      VerifyOtpParams(
        verifyCase: arguments.verifyCase,
        verificationCode: verificationCode,
        countryCode: arguments.countryCode,
        phone: arguments.phone,
      ),
    );
    result.fold(
      (failure) {
        emit(state.copyWith(verifyState: Async.failure(failure)));
      },
      (_) async {
        emit(state.copyWith(verifyState: const Async.successWithoutData()));
      },
    );
  }

  void resendOtp() async {
    emit(state.copyWith(resendState: const Async.loading()));
    final result = await _resendOtpUseCase(
      ResendOtpParams(phone: arguments.phone, countryCode: arguments.countryCode, verifyCase: arguments.verifyCase),
    );
    result.fold(
      (failer) {
        emit(state.copyWith(resendState: Async.failure(failer)));
      },
      (_) {
        emit(state.copyWith(resendState: const Async.successWithoutData()));
      },
    );
    emit(state.copyWith(resendState: const Async.initial()));
  }

  /// Handle Update Phone Number
  /// After verify the phone number
  ///
  // late final UpdatePhoneUseCase _updatePhoneUseCase;
  void updatePhone() async {
    // emit(state.copyWith(updatePhoneState: const Async.loading()));
    // final result = await _updatePhoneUseCase(arguments.mobile);
    // result.fold((failure) {
    //   emit(state.copyWith(updatePhoneState: Async.failure(failure.message)));
    // }, (_) async {
    //   emit(state.copyWith(updatePhoneState: const Async.successWithoutData()));
    // });
    // emit(state.copyWith(updatePhoneState: const Async.initial()));
  }

  @override
  void emit(OtpState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
