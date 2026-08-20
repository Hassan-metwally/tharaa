import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'common_entity.dart';

class CityEntity extends CommonEntity {
  final Set<Polygon> polygons;
  const CityEntity({required super.id, required super.name, required this.polygons});

  factory CityEntity.initial() => const CityEntity(id: 0, name: "", polygons: {});

  @override
  List<Object?> get props => super.props..add(polygons);
}
