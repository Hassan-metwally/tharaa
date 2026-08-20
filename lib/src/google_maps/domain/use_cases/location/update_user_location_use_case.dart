import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/core.dart';
import '../../../../../core/domain/entities/cached_address_entity.dart';
import '../../entities/address_entity.dart';
import '../../repository/maps_repository.dart';

@injectable
class UpdateUserLocationUseCase extends IUseCase<void, UpdateUserAddressParams> {
  final MapsRepository _repository;

  UpdateUserLocationUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(UpdateUserAddressParams params) async => await _repository.updateUserLocation(params);
}

class UpdateUserAddressParams extends Equatable {
  final String address;
  final double lat;
  final double lng;

  const UpdateUserAddressParams({required this.address, required this.lat, required this.lng});

  factory UpdateUserAddressParams.initial() => const UpdateUserAddressParams(address: '', lat: 0.0, lng: 0.0);

  UpdateUserAddressParams copyWith({String? address, double? lat, double? lng}) {
    return UpdateUserAddressParams(address: address ?? this.address, lat: lat ?? this.lat, lng: lng ?? this.lng);
  }

  factory UpdateUserAddressParams.fromEntity(MapAddressEntity entity) =>
      UpdateUserAddressParams(address: entity.address, lat: entity.lat, lng: entity.lng);

  CachedAddressEntity get toUserAddressEntity => CachedAddressEntity(address: address, lat: lat, lng: lng);

  Map<String, dynamic> get toMap => {'latitude': lat, 'longitude': lng};

  @override
  List<Object?> get props => [address, lat, lng];
}
