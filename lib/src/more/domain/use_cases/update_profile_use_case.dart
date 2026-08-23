// ignore_for_file: use_null_aware_elements

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../common/domain/entity/users/client_entity.dart';
import '../repository/client_more_repository.dart';

@Injectable()
class UpdateProfileUseCase extends IUseCase<ClientEntity, UpdateProfileParams> {
  final MoreRepository _repository;

  UpdateProfileUseCase(this._repository);
  @override
  Future<Either<Failure, ClientEntity>> call(UpdateProfileParams params) async {
    return await _repository.updateProfileData(params);
  }
}

class UpdateProfileParams {
  final AttachmentEntity? image;
  final String name;
  final String email;
  const UpdateProfileParams({required this.image, required this.name, required this.email});

  Map<String, dynamic> get toMap {
    final MultipartFile? file = image?.path.toMultipartFile;
    return {if (file != null) 'avatar': file, "email": email, 'name': name, "_method": "put"};
  }
}
