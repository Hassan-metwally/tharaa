import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CalculateDistanceUsecase {
  double calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    try {
      final double distance = Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
      return (distance / 1000); // Distance in meters
    } catch (e) {
      throw Exception('Error calculating distance: $e');
    }
  }
}
