// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:injectable/injectable.dart';
// import '../../../../core/core.dart';
// import '../repository/authentication_repository.dart';

// @Injectable()
// class UpdatePasswordUseCase extends IUseCase<void, UpdatePasswordParams> {
//   final AuthenticationRepository _repository;

//   UpdatePasswordUseCase(this._repository);

//   @override
//   Future<Either<Failure, void>> call(UpdatePasswordParams params) async => await _repository.updatePassword(params);
// }

// class UpdatePasswordParams extends Equatable {
//   final String password;
//   final String oldPassword;
//   final String passwordConfirmation;

//   const UpdatePasswordParams({required this.password, required this.oldPassword, required this.passwordConfirmation});

//   @override
//   List<Object?> get props => [password, oldPassword, passwordConfirmation];

//   Map<String, dynamic> get toMap => {"old_password": oldPassword, "password": password, "password_confirmation": passwordConfirmation};
// }
