import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/core.dart';
import '../../entity/menu/static_page_type_enum.dart';
import '../../repository/menu_common_repository.dart';

@Injectable()
class GetStaticDataUseCase extends IUseCase<String, StaticPageTypeEnum> {
  final MenuCommonRepository _repository;

  GetStaticDataUseCase(this._repository);
  @override
  Future<Either<Failure, String>> call(StaticPageTypeEnum params) async {
    return await _repository.getStaticPageData(params);
  }
}
