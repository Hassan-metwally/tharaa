import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/core.dart';
import '../../entities/place_suggestion_entity.dart';
import '../../repository/maps_repository.dart';

@Injectable()
class GetSearchSuggestionsUseCase extends IUseCase<List<MapPlaceSuggestionsEntity>, GetSearchSuggestionsParams> {
  final MapsRepository _repository;
  GetSearchSuggestionsUseCase(this._repository);
  @override
  Future<Either<Failure, List<MapPlaceSuggestionsEntity>>> call(GetSearchSuggestionsParams params) async {
    return await _repository.getSearchSuggestions(params.searchText);
  }
}

class GetSearchSuggestionsParams extends NoParams {
  final String searchText;

  GetSearchSuggestionsParams({required this.searchText});
}
