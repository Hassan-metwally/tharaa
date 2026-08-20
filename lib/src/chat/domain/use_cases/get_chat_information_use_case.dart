import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/chat_information_entity.dart';
import '../entities/chat_page_input.dart';
import '../repository/chat_repository.dart';

@Injectable()
class GetChatInformationUseCase extends IUseCase<IChatDetailsEntity, IChatPageInput> {
  final ChatRepository _repository;
  GetChatInformationUseCase(this._repository);
  @override
  Future<Either<Failure, IChatDetailsEntity>> call(IChatPageInput params) async {
    return await _repository.getChatInfo(params);
  }
}
