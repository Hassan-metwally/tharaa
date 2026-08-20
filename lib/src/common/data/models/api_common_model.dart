import '../../domain/entity/common_entity.dart';

class ApiCommonModel {
  final int? id;
  final String? name;

  ApiCommonModel({this.id, this.name});

  factory ApiCommonModel.fromJson(Map<String, dynamic> json) => ApiCommonModel(id: json['id'] as int?, name: json['name'] as String?);
}

extension ApiCommonModelEXT on ApiCommonModel {
  CommonEntity get map => CommonEntity(id: id ?? 0, name: name ?? '');
}
