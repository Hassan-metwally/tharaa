// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:injectable/injectable.dart';
// import '../../../../core/core.dart';
// import '../repository/authentication_repository.dart';

// @Injectable()
// class ResetPasswordUseCase extends IUseCase<void, ResetPasswordParams> {
//   final AuthenticationRepository _repository;

//   ResetPasswordUseCase(this._repository);

//   @override
//   Future<Either<Failure, void>> call(ResetPasswordParams params) async => await _repository.resetPassword(params);
// }

// class ResetPasswordParams extends Equatable {
//   final String password;
//   final String passwordConfirmation;

//   const ResetPasswordParams({required this.password, required this.passwordConfirmation});

//   @override
//   List<Object?> get props => [password, passwordConfirmation];

//   Map<String, dynamic> get toMap => {"password": password, "password_confirmation": passwordConfirmation};
// }
