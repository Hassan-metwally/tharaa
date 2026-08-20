part of core;

typedef CachedUser = CacheUserEntity;

class CacheUserEntity extends Equatable {
  final int id;
  final String name;
  final String avatar;
  final String mobile;

  const CacheUserEntity({required this.id, required this.name, required this.avatar, required this.mobile});

  CacheUserEntity copyWith({int? id, String? name, String? avatar, String? mobile}) {
    return CacheUserEntity(id: id ?? this.id, name: name ?? this.name, avatar: avatar ?? this.avatar, mobile: mobile ?? this.mobile);
  }

  @override
  List<Object?> get props => [id, name, avatar, mobile];

  @override
  String toString() {
    return "[CachedUser] ----------------------------\n"
        "[ID] $id\n"
        "[Name] $name\n"
        "[Avatar] $avatar\n"
        "[Mobile] $mobile\n"
        "-----------------------------------------";
  }
}
