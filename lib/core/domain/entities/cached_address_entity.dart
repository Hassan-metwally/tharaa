import 'package:equatable/equatable.dart';

import '../../../src/google_maps/domain/entities/address_entity.dart';

class CachedAddressEntity extends Equatable {
  late final String _address;
  final double lat;
  final double lng;

  CachedAddressEntity.empty() : this(address: '', lat: 0, lng: 0);
  CachedAddressEntity({required String address, required this.lat, required this.lng}) {
    try {
      // final decodedString = json.decode(address);
      _address = address;
    } catch (_) {
      _address = address;
    }
  }
  String get address => _address;

  String get addressFirstSection {
    const String temp = '';

    if (temp.isNotEmpty) {
      return temp.replaceFirst(RegExp(r'^\s*,\s*'), '');
    } else {
      return _address.replaceFirst(RegExp(r'^\s*,\s*'), '');
    }
  }

  String? get addressSecondSection {
    const String temp = '';

    if (temp.isNotEmpty) {
      return temp.replaceFirst(RegExp(r'^\s*,\s*'), '');
    } else {
      return null;
    }
  }

  /// This Parts [toMap]
  /// Used for cache handle
  Map<String, dynamic> get toMap => {_latKey: lat, _lngKey: lng, _addressKey: _address};

  factory CachedAddressEntity.fromMap(Map<String, dynamic> map) {
    return CachedAddressEntity(
      address: map[_addressKey] as String,
      lat: double.tryParse(map[_latKey].toString()) ?? 0.0,
      lng: double.tryParse(map[_lngKey].toString()) ?? 0.0,
    );
  }

  @override
  List<Object?> get props => [_address, lat, lng];

  @override
  String toString() {
    return "[UserAddressEntity]  Address : $_address ::: Lat : $lat ::: Lng : $lng";
  }

  MapAddressEntity get getAsMapAddressEntity => MapAddressEntity(address: address, lat: lat, lng: lng);
}

const String _addressKey = "address";
const String _latKey = "latitude";
const String _lngKey = "longitude";
