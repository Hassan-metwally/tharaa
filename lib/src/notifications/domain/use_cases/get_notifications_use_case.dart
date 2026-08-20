import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/norification_entity.dart';
import '../repository/notification_repository.dart';

@Injectable()
class GetNotificationsUseCase extends IUseCase<PaginatedData<NotificationEntity>, GetNotificationsParams> {
  final NotificationRepository _repository;

  GetNotificationsUseCase(this._repository);

  @override
  Future<Either<Failure, PaginatedData<NotificationEntity>>> call(GetNotificationsParams params) async {
    return await _repository.getNotifications(params);
  }
}

class GetNotificationsParams {
  final int? page;
  GetNotificationsParams({this.page});
  Map<String, dynamic> toJson() => {'page': page, 'limit': 10};
}
