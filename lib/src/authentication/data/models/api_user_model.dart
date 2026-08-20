import 'dart:convert';

import '../../../../core/core.dart';
import '../../domain/entities/user_entity.dart';

class ApiUserModel {
  final int? id;
  final String? name;
  final String? mobile;
  final AttachmentEntity? avatar;
  final bool? isVerified;

  const ApiUserModel({required this.id, required this.name, required this.mobile, required this.avatar, required this.isVerified});

  factory ApiUserModel.fromJson(Map<String, dynamic> json) => ApiUserModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    mobile: json["phone"] ?? '',
    avatar: json["avatar"] != null ? AttachmentEntity.fromNetwork(url: json["avatar"]) : const AttachmentEntity.empty(),
    isVerified: json["is_verified"],
  );
}

extension ApiUserModelEXT on ApiUserModel {
  UserEntity get map => UserEntity(
    id: id ?? 0,
    name: name ?? '',
    mobile: mobile ?? '',
    avatar: avatar ?? const AttachmentEntity.empty(),
    isVerified: isVerified,
  );
}

class PhoneModel extends PhoneEntity {
  const PhoneModel({required super.phone, required super.code, required super.isoCode});

  factory PhoneModel.fromJson(String tokenJson) {
    final Map<String, dynamic> encodedMap = json.decode(tokenJson);
    return PhoneModel.fromMap(encodedMap);
  }

  factory PhoneModel.fromMap(Map<String, dynamic> map) {
    return PhoneModel(
      phone: map[kPhoneAttributeCacheKey],
      code: map[kCountryCodeAttributeCacheKey],
      isoCode: map[kCountryIsoCodeAttributeCacheKey],
    );
  }

  String get toJson => json.encode(toMap);
}

const String kPhoneAttributeCacheKey = 'mobile';
const String kCountryCodeAttributeCacheKey = 'country_code';
const String kCountryIsoCodeAttributeCacheKey = 'iso_code';
