import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../repository/notification_repository.dart';

@Injectable()
class GetUnreadedNotificationsCountUsecase extends IUseCase<int, NoParams> {
  final NotificationRepository _repository;
  GetUnreadedNotificationsCountUsecase(this._repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return await _repository.getUnreadedNotificationsCount();
  }
}
