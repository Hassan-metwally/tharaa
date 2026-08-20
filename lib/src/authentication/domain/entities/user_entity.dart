import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../../material/inputs/intel_phone/phone_field.dart';
import '../../data/models/api_user_model.dart';

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String mobile;
  final AttachmentEntity avatar;
  final bool? isVerified;

  const UserEntity({required this.id, required this.name, required this.mobile, required this.avatar, required this.isVerified});

  UserEntity copyWith({int? id, String? name, String? mobile, AttachmentEntity? avatar, bool? isVerified, bool? isActive}) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      avatar: avatar ?? this.avatar,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  CacheUserEntity get mapToCacheEntity {
    return CacheUserEntity(id: id, name: name, avatar: avatar.path, mobile: mobile);
  }

  @override
  List<Object?> get props => [id, name, mobile, avatar, isVerified];
}

class PhoneEntity extends Equatable {
  final String phone;
  final String code;
  final String isoCode;

  const PhoneEntity({required this.phone, required this.code, required this.isoCode});

  IntelPhoneNumberEntity get getFieldPhoneMumber => IntelPhoneNumberEntity(number: phone, countryISOCode: isoCode, countryCode: code);

  String get mobileWithCode => "$code$phone";

  Map<String, dynamic> get toMap => {
    kCountryCodeAttributeCacheKey: code,
    kPhoneAttributeCacheKey: phone,
    kCountryIsoCodeAttributeCacheKey: isoCode,
  };

  @override
  List<Object?> get props => [phone, code, isoCode];
}
