import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/entity/city_entity.dart';
import 'api_common_model.dart';

class ApiCityModel extends ApiCommonModel {
  final Set<Polygon>? polygons;

  ApiCityModel({super.id, super.name, this.polygons});

  factory ApiCityModel.fromJson(Map<String, dynamic> json) {
    final boundary = json['boundary'] as List<dynamic>?;
    final polygons = _parseBoundaryToPolygons(json['id'], boundary);
    return ApiCityModel(id: json['id'] as int?, name: json['name'] as String?, polygons: polygons);
  }

  /// Supports API boundary as either:
  /// - flat ring: [[lng, lat], [lng, lat], ...]
  /// - multi ring: [[[lng, lat], ...], [[lng, lat], ...], ...]
  static Set<Polygon>? _parseBoundaryToPolygons(dynamic id, List<dynamic>? boundary) {
    if (boundary == null || boundary.isEmpty) return null;
    final polygonSetId = id?.toString() ?? '0';
    final rings = _extractBoundaryRings(boundary);
    final polygons = <Polygon>{};

    for (var i = 0; i < rings.length; i++) {
      final points = _parseRingPoints(rings[i]);
      if (points.length < 3) continue;
      polygons.add(Polygon(polygonId: PolygonId('${polygonSetId}_$i'), points: points));
    }
    return polygons.isEmpty ? null : polygons;
  }

  static List<List<dynamic>> _extractBoundaryRings(List<dynamic> boundary) {
    if (boundary.isEmpty) return const [];
    final firstItem = boundary.first;
    if (firstItem is List && firstItem.isNotEmpty && firstItem.first is num) {
      return [boundary];
    }
    return boundary.whereType<List<dynamic>>().toList();
  }

  static List<LatLng> _parseRingPoints(List<dynamic> ring) {
    final points = <LatLng>[];
    for (final point in ring) {
      final latLng = _toLatLng(point);
      if (latLng != null) points.add(latLng);
    }
    return points;
  }

  static LatLng? _toLatLng(dynamic point) {
    if (point is! List || point.length < 2) return null;
    final lngValue = point[0];
    final latValue = point[1];
    if (lngValue is! num || latValue is! num) return null;
    // API returns [lng, lat] (GeoJSON order) -> LatLng(lat, lng)
    return LatLng(latValue.toDouble(), lngValue.toDouble());
  }
}

extension ApiCityModelEXT on ApiCityModel {
  CityEntity get map => CityEntity(id: id ?? 0, name: name ?? '', polygons: polygons ?? const {});
}
