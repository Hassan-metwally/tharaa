import 'package:equatable/equatable.dart';

import '../../../core/core.dart';
import '../domain/entities/address_entity.dart';

class MapsMainState extends Equatable {
  final Async<MapAddressEntity> locationState;

  const MapsMainState({required this.locationState});
  const MapsMainState.initial() : this(locationState: const Async.initial());

  MapsMainState copyWith({Async<MapAddressEntity>? locationState}) {
    return MapsMainState(locationState: locationState ?? this.locationState);
  }

  @override
  List<Object?> get props => [locationState];
}
