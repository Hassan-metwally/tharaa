import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/core.dart';
import '../../repository/menu_common_repository.dart';

@Injectable()
class ToggleEnableNotificationUseCase extends IUseCase<void, NoParams> {
  final MenuCommonRepository _repository;

  ToggleEnableNotificationUseCase(this._repository);
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _repository.toggleNotificationEnable();
  }
}
