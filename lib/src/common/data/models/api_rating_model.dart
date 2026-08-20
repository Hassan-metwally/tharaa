import '../../domain/entity/rating_entity.dart';

class ApiRatingModel {
  final double? rate;
  final String? comment;
  final String? avatar;

  const ApiRatingModel({required this.rate, required this.comment, required this.avatar});

  factory ApiRatingModel.fromJson(Map<String, dynamic> json) {
    return ApiRatingModel(
      rate: json['rating'] != null ? double.parse(json['rating'].toString()) : 0.0,
      comment: json['comment'] ?? '',
      avatar: json['user']?['avatar'] ?? '',
    );
  }
}

extension ApiRatingModelExt on ApiRatingModel {
  RatingEntity get map => RatingEntity(rate: rate, comment: comment, avatar: avatar);
}
