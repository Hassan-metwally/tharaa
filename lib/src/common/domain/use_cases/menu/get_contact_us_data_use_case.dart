import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/core.dart';
import '../../entity/menu/contact_us_entity.dart';
import '../../repository/menu_common_repository.dart';

@Injectable()
class GetContactUsDataUseCase extends IUseCase<ContactUsEntity, NoParams> {
  final MenuCommonRepository _repository;

  GetContactUsDataUseCase(this._repository);
  @override
  Future<Either<Failure, ContactUsEntity>> call(NoParams params) async {
    return await _repository.getContactUsData();
  }
}
