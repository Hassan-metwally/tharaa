import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../repository/notification_repository.dart';

@Injectable()
class ReadNotificationUseCase extends IUseCase<Unit, ReadNotificationParams> {
  final NotificationRepository _repository;
  ReadNotificationUseCase(this._repository);
  @override
  Future<Either<Failure, Unit>> call(ReadNotificationParams params) async {
    return await _repository.readNotification(params);
  }
}

class ReadNotificationParams {
  String id;
  ReadNotificationParams({required this.id});

  Map<String, dynamic> get toMap => {"notification_id": id};
}
