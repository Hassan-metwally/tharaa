import 'package:intl/intl.dart' as intel;

import '../../../../core/core.dart';
import '../../domain/entities/coupon_entity.dart';

class ApiCouponModel {
  final int? id;
  final String? name;
  final String? code;
  final String? discountLabel;
  final String? status;
  final DateTime? validFrom;
  final DateTime? validTo;
  final num? minOrderAmount;
  final AttachmentEntity? image;

  ApiCouponModel({
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

  factory ApiCouponModel.fromJson(Map<String, dynamic> json) {
    final DateTime? validFrom = _parseDate(json['starts_at'] ?? json['valid_from'] ?? json['start_date'] ?? json['from_date']);
    final DateTime? validTo = _parseDate(json['ends_at'] ?? json['valid_to'] ?? json['end_date'] ?? json['expiry_date'] ?? json['to_date']);

    return ApiCouponModel(
      id: json['id'],
      name: json['name']?.toString(),
      code: (json['code'] ?? json['coupon_code'])?.toString(),
      discountLabel: _parseDiscountLabel(json),
      status: _resolveStatus(json, validTo),
      validFrom: validFrom,
      validTo: validTo,
      minOrderAmount: _parseNum(json['min_order_amount'] ?? json['min_order'] ?? json['minimum_order']),
      image: AttachmentEntity.fromNetwork(url: json['image']?.toString() ?? ''),
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    final String text = value.toString().trim();
    if (text.isEmpty) return null;

    final DateTime? iso = DateTime.tryParse(text);
    if (iso != null) return iso;

    for (final String pattern in ['yyyy-MM-dd HH:mm:ss', 'yyyy-MM-dd HH:mm']) {
      try {
        return intel.DateFormat(pattern).parse(text);
      } catch (_) {}
    }

    return null;
  }

  static num? _parseNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    return num.tryParse(value.toString());
  }

  static String? _parseDiscountLabel(Map<String, dynamic> json) {
    final dynamic label = json['discount_label'] ?? json['discount_text'];
    if (label != null) {
      final String text = label.toString();
      if (text.isNotEmpty && num.tryParse(text) == null) {
        return text;
      }
    }

    final num? percent = _parseNum(json['discount_percent'] ?? json['discount'] ?? json['discount_value'] ?? label);
    if (percent == null) return label?.toString();
    final String value = percent % 1 == 0 ? percent.toInt().toString() : percent.toString();
    return '$value% OFF';
  }

  static String _resolveStatus(Map<String, dynamic> json, DateTime? validTo) {
    final dynamic status = json['status'] ?? json['coupon_status'];
    if (status != null) {
      return status.toString();
    }

    final bool isUsed = json['is_used'] == true;
    if (isUsed) return 'used';

    final bool isActive = json['is_active'] != false;
    final bool isExpired = !isActive || (validTo != null && validTo.isBefore(DateTime.now()));
    if (isExpired) return 'expired';

    return 'unused';
  }
}

extension ApiCouponEXT on ApiCouponModel {
  CouponEntity get map => CouponEntity(
    id: id ?? 0,
    name: name ?? '',
    code: code ?? '',
    discountLabel: discountLabel ?? '',
    status: _statusFromJson(status),
    validFrom: validFrom,
    validTo: validTo,
    minOrderAmount: minOrderAmount ?? 0,
    image: image ?? const AttachmentEntity.empty(),
  );
}

CouponStatus _statusFromJson(String? value) {
  switch (value?.toLowerCase().trim()) {
    case 'used':
    case 'redeemed':
    case 'consumed':
      return CouponStatus.used;
    case 'expired':
    case 'ended':
    case 'finished':
      return CouponStatus.expired;
    default:
      return CouponStatus.unused;
  }
}
