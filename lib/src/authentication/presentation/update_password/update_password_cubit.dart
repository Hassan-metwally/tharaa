// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/core.dart';
// import '../../../../core/di/di.dart';
// import '../../domain/use_case/update_password_use_case.dart';

// class UpdatePasswordCubit extends Cubit<Async<void>> {
//   UpdatePasswordCubit() : super(const Async.initial());

//   final UpdatePasswordUseCase _updatePasswordUseCase = injector();

//   void updatePassword(UpdatePasswordParams params) async {
//     emit(const Async.loading());
//     final result = await _updatePasswordUseCase(params);
//     result.fold(
//       (failure) {
//         emit(Async.failure(failure));
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
