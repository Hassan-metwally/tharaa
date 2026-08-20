import 'package:equatable/equatable.dart';

import '../../../src/common/domain/entity/common_entity.dart';

class CachedCommonEntity extends Equatable {
  final int id;
  final String name;

  const CachedCommonEntity.empty() : this(id: 0, name: '');
  const CachedCommonEntity({required this.id, required this.name});

  /// This Parts [toMap]
  /// Used for cache handle
  Map<String, dynamic> get toMap => {_idKey: id, _nameKey: name};

  factory CachedCommonEntity.fromMap(Map<String, dynamic> map) {
    return CachedCommonEntity(id: map[_idKey] ?? 0, name: map[_nameKey] ?? '');
  }

  CommonEntity get getAsCommonEntity => CommonEntity(id: id, name: name);

  @override
  List<Object?> get props => [id, name];

  @override
  String toString() {
    return "[CachedCommonEntity] Id : $id ::: Name : $name";
  }
}

const String _idKey = "id";
const String _nameKey = "name";
