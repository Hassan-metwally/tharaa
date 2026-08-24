import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';

enum CouponStatus { unused, used, expired }

class CouponEntity extends Equatable {
  final int id;
  final String name;
  final String code;
  final String discountLabel;
  final CouponStatus status;
  final DateTime? validFrom;
  final DateTime? validTo;
  final num minOrderAmount;
  final AttachmentEntity image;

  const CouponEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.discountLabel,
    required this.status,
    required this.validFrom,
    required this.validTo,
    required this.minOrderAmount,
    required this.image,
  });

  const CouponEntity.initial()
    : id = 0,
      name = '',
      code = '',
      discountLabel = '',
      status = CouponStatus.unused,
      validFrom = null,
      validTo = null,
      minOrderAmount = 0,
      image = const AttachmentEntity.empty();

  CouponEntity copyWith({
    int? id,
    String? name,
    String? code,
    String? discountLabel,
    CouponStatus? status,
    DateTime? validFrom,
    DateTime? validTo,
    num? minOrderAmount,
    AttachmentEntity? image,
  }) {
    return CouponEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      discountLabel: discountLabel ?? this.discountLabel,
      status: status ?? this.status,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
      minOrderAmount: minOrderAmount ?? this.minOrderAmount,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [id, name, code, discountLabel, status, validFrom, validTo, minOrderAmount, image];
}
