import 'package:json_annotation/json_annotation.dart';
import 'package:penger/models/penger_model.dart';

part 'coupon_model.g.dart';

@JsonSerializable()
class Coupon {
  Coupon({
    required this.id,
    required this.tile,
    this.description,
    this.minCreditPoints,
    this.requiredCreditPoints,
    required this.validFrom,
    required this.validTo,
    required this.quantity,
    required this.isRedeemable,
    required this.createdBy,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
  Map<String, dynamic> toJson() => _$CouponToJson(this);

  final int id;
  final String tile;
  final String? description;

  @JsonKey(name: 'created_by')
  final Penger createdBy;

  @JsonKey(name: 'min_credit_points')
  final double? minCreditPoints;

  @JsonKey(name: 'required_credit_points')
  final double? requiredCreditPoints;

  @JsonKey(name: 'valid_from')
  final DateTime validFrom;

  @JsonKey(name: 'valid_to')
  final DateTime validTo;
  final int quantity;

  @JsonKey(name: 'is_redeemable')
  final bool isRedeemable;
}
