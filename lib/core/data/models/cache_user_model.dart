part of core;

class CacheUserModel extends CacheUserEntity {
  const CacheUserModel({required super.id, required super.name, required super.avatar, required super.mobile});

  CacheUserModel.fromEntity(CacheUserEntity entity) : this(id: entity.id, name: entity.name, avatar: entity.avatar, mobile: entity.mobile);

  factory CacheUserModel.fromJson(String tokenJson) {
    final Map<String, dynamic> encodedMap = json.decode(tokenJson);
    return CacheUserModel(
      id: encodedMap[_idKey],
      name: encodedMap[_nameKey],
      avatar: encodedMap[_avatarKey],
      mobile: encodedMap[_kCacheMobileObjectKey],
    );
  }

  Map<String, dynamic> get toMap => {_idKey: this.id, _nameKey: name, _avatarKey: avatar, _kCacheMobileObjectKey: mobile};

  String get toJson => json.encode(toMap);
}

const String _idKey = "idKey";
const String _nameKey = "nameKey";
const String _avatarKey = "avatarKey";
const String _kCacheMobileObjectKey = "kCacheMobileObjectKey";
