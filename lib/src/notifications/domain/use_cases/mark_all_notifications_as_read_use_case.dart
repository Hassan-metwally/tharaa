import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../repository/notification_repository.dart';

@Injectable()
class MarkAllNotificationsAsReadUseCase extends IUseCase<void, NoParams> {
  final NotificationRepository _repository;
  MarkAllNotificationsAsReadUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await _repository.markAllNotificationAsRead();
  }
}
