import '../../../../core/core.dart';
import '../../../authentication/data/models/api_user_model.dart';
import '../../../authentication/domain/entities/user_entity.dart';
import '../../domain/entities/rate_entity.dart';

class ApiRateModel {
  final int? id;
  final num? rate;
  final String? comment;
  final ApiUserModel? user;

  ApiRateModel({required this.id, required this.rate, required this.comment, required this.user});

  factory ApiRateModel.fromJson(Map<String, dynamic> json) => ApiRateModel(
    id: json["id"],
    rate: json["rate"],
    comment: json["comment"],
    user: json["user"] != null ? ApiUserModel.fromJson(json["user"]) : null,
  );
}

extension ApiRateEXT on ApiRateModel {
  RateEntity get map => RateEntity(
    id: id ?? 0,
    rate: rate ?? 0,
    comment: comment ?? '',
    user: user?.map ?? const UserEntity(id: 0, name: '', mobile: '', avatar: AttachmentEntity.empty(), isVerified: null),
  );
}
