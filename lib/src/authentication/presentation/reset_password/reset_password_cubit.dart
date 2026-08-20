// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/core.dart';
// import '../../../../core/di/di.dart';
// import '../../domain/use_case/reset_password_use_case.dart';

// class ResetPasswordCubit extends Cubit<Async<void>> {
//   ResetPasswordCubit() : super(const Async.initial());

//   final ResetPasswordUseCase _resetPasswordUseCase = injector();

//   void resetPassword(ResetPasswordParams params) async {
//     emit(const Async.loading());
//     final result = await _resetPasswordUseCase(params);
//     result.fold(
//       (failer) {
//         emit(Async.failure(failer));
//       },
//       (_) {
//         emit(const Async.successWithoutData());
//       },
//     );
//     emit(const Async.initial());
//   }

//   @override
//   void emit(Async<void> state) {
//     if (!isClosed) {
//       super.emit(state);
//     }
//   }
// }
