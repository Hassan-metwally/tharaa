import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../repository/chat_repository.dart';

@Injectable()
class SetChatMessagesAsReadUseCase extends IUseCase<void, int> {
  final ChatRepository _repository;
  SetChatMessagesAsReadUseCase(this._repository);
  @override
  Future<Either<Failure, void>> call(int params) async {
    return await _repository.setMessagesRead(params);
  }
}
