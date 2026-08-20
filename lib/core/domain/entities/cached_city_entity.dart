import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../src/common/domain/entity/city_entity.dart';

class CachedCityEntity extends Equatable {
  final int id;
  final String name;
  final Set<Polygon> polygons;

  const CachedCityEntity.empty() : this(id: 0, name: '', polygons: const {});
  const CachedCityEntity({required this.id, required this.name, required this.polygons});

  CachedCityEntity copyWith({int? id, String? name, Set<Polygon>? polygons}) {
    return CachedCityEntity(id: id ?? this.id, name: name ?? this.name, polygons: polygons ?? this.polygons);
  }

  /// This Parts [toMap]
  /// Used for cache handle
  Map<String, dynamic> get toMap => {_idKey: id, _nameKey: name, _polygonsKey: _serializePolygons(polygons)};

  /// This Parts [fromMap]
  /// Used for cache handle
  factory CachedCityEntity.fromMap(Map<String, dynamic> map) {
    final cityMap = map['city'] is Map<String, dynamic> ? map['city'] as Map<String, dynamic> : map;
    final id = (cityMap[_idKey] as num?)?.toInt() ?? 0;
    final name = cityMap[_nameKey]?.toString() ?? '';
    final polygons = _parsePolygons(id: id, rawBoundary: cityMap[_polygonsKey]);
    return CachedCityEntity(id: id, name: name, polygons: polygons);
  }

  static Set<Polygon> _parsePolygons({required int id, required dynamic rawBoundary}) {
    if (rawBoundary is! List || rawBoundary.isEmpty) return const {};

    final rings = _extractRings(rawBoundary);
    final polygons = <Polygon>{};
    for (var i = 0; i < rings.length; i++) {
      final points = _parseRingPoints(rings[i]);
      if (points.length < 3) continue;
      polygons.add(Polygon(polygonId: PolygonId('city_${id}_$i'), points: _normalizeRing(points)));
    }
    return polygons;
  }

  static List<List<dynamic>> _extractRings(List<dynamic> boundary) {
    final firstItem = boundary.first;
    if (firstItem is List && firstItem.isNotEmpty && firstItem.first is num) {
      return [boundary];
    }
    return boundary.whereType<List<dynamic>>().toList();
  }

  static List<LatLng> _parseRingPoints(List<dynamic> ring) {
    final points = <LatLng>[];
    for (final point in ring) {
      if (point is! List || point.length < 2) continue;
      final lng = point[0];
      final lat = point[1];
      if (lng is! num || lat is! num) continue;
      points.add(LatLng(lat.toDouble(), lng.toDouble()));
    }
    return points;
  }

  static List<LatLng> _normalizeRing(List<LatLng> points) {
    if (points.length < 2) return points;
    final first = points.first;
    final last = points.last;
    if (first.latitude == last.latitude && first.longitude == last.longitude) {
      return points.sublist(0, points.length - 1);
    }
    return points;
  }

  static List<List<List<double>>> _serializePolygons(Set<Polygon> polygons) {
    final serialized = <List<List<double>>>[];
    for (final polygon in polygons) {
      if (polygon.points.length < 3) continue;
      final ring = polygon.points.map((point) => [point.longitude, point.latitude]).toList();
      serialized.add(ring);
    }
    return serialized;
  }

  CityEntity get getAsCityEntity => CityEntity(id: id, name: name, polygons: polygons);

  @override
  List<Object?> get props => [id, name, polygons];

  @override
  String toString() {
    return "[CachedCityEntity] Id : $id ::: Name : $name ::: Polygons : $polygons";
  }
}

const String _idKey = "id";
const String _nameKey = "name";
const String _polygonsKey = "boundary";
