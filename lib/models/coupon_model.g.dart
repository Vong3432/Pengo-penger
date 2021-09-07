// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) {
  return Coupon(
    id: json['id'] as int,
    tile: json['tile'] as String,
    description: json['description'] as String?,
    minCreditPoints: (json['min_credit_points'] as num?)?.toDouble(),
    requiredCreditPoints: (json['required_credit_points'] as num?)?.toDouble(),
    validFrom: DateTime.parse(json['valid_from'] as String),
    validTo: DateTime.parse(json['valid_to'] as String),
    quantity: json['quantity'] as int,
    isRedeemable: json['is_redeemable'] as bool,
    createdBy: Penger.fromJson(json['created_by'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'id': instance.id,
      'tile': instance.tile,
      'description': instance.description,
      'created_by': instance.createdBy,
      'min_credit_points': instance.minCreditPoints,
      'required_credit_points': instance.requiredCreditPoints,
      'valid_from': instance.validFrom.toIso8601String(),
      'valid_to': instance.validTo.toIso8601String(),
      'quantity': instance.quantity,
      'is_redeemable': instance.isRedeemable,
    };
