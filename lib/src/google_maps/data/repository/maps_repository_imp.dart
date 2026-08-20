import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/place_suggestion_entity.dart';
import '../../domain/repository/maps_repository.dart';
import '../../domain/use_cases/google_maps_api/get_location_address_use_case.dart';
import '../../domain/use_cases/location/update_user_location_use_case.dart';
import '../data_sources/maps_data_source.dart';
import '../mapper/address_mapper.dart';
import '../mapper/place_suggessions_mapper.dart';

@Injectable(as: MapsRepository)
class MapsRepositoryImp implements MapsRepository {
  final MapsDataSource _mapsDataSource;
  final SecureStorageRepository _secureStorageRepository;

  MapsRepositoryImp(this._mapsDataSource, this._secureStorageRepository);

  @override
  Future<Either<Failure, List<MapPlaceSuggestionsEntity>>> getSearchSuggestions(String text) async {
    return await failureCollect(() async {
      final result = await _mapsDataSource.getSearchSuggestions(text);
      final listData = result.map((e) => e.map).toList();
      return Right(listData);
    });
  }

  @override
  Future<Either<Failure, MapAddressEntity>> getLocationAddress(GetMapLocationAddressParams params) async {
    return await failureCollect(() async {
      final result = await _mapsDataSource.getMapLocationAddress(params);
      return Right(result.map);
    });
  }

  @override
  Future<Either<Failure, MapAddressEntity>> getPlaceDetails(String placeID) async {
    return await failureCollect(() async {
      final result = await _mapsDataSource.getPlaceDetails(placeID);
      return Right(result.map);
    });
  }

  @override
  DomainServiceType<void> updateUserLocation(UpdateUserAddressParams params) async {
    return failureCollect(() async {
      await _mapsDataSource.updateUserLocation(params);
      final cachedUser = await _secureStorageRepository.getCachedUser();
      if (cachedUser != null) {
        // final newCacheUser = cachedUser.copyWith(address: params.toUserAddressEntity);
        // await _secureStorageRepository.setCachedUser(newCacheUser);
      }
      return const Right(null);
    });
  }
}
