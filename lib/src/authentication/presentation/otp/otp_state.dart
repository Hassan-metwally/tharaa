part of "otp_cubit.dart";

class OtpState extends Equatable {
  final Async<void> verifyState;
  final Async<void> resendState;
  final Async<void> updatePhoneState;

  const OtpState({required this.verifyState, required this.resendState, required this.updatePhoneState});

  const OtpState.initial()
    : this(verifyState: const Async.initial(), updatePhoneState: const Async.initial(), resendState: const Async.initial());

  OtpState copyWith({Async<void>? verifyState, Async<void>? resendState, Async<void>? updatePhoneState}) {
    return OtpState(
      verifyState: verifyState ?? this.verifyState,
      updatePhoneState: updatePhoneState ?? this.updatePhoneState,
      resendState: resendState ?? this.resendState,
    );
  }

  @override
  List<Object?> get props => [verifyState, resendState, updatePhoneState];
}
