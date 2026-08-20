// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:injectable/injectable.dart';
// import '../../../../core/core.dart';
// import '../entities/user_entity.dart';
// import '../repository/authentication_repository.dart';

// @Injectable()
// class ForgotPasswordUseCase extends IUseCase<void, ForgotPasswordParams> {
//   final AuthenticationRepository _repository;

//   ForgotPasswordUseCase(this._repository);

//   @override
//   Future<Either<Failure, void>> call(ForgotPasswordParams params) async => await _repository.forgotPassword(params);
// }

// class ForgotPasswordParams extends Equatable {
//   final PhoneEntity phone;

//   const ForgotPasswordParams({required this.phone});

//   @override
//   List<Object?> get props => [phone];

//   Map<String, dynamic> get toMap {
//     return phone.toMap;
//   }
// }
