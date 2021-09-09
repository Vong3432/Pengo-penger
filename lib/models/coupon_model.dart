import 'package:json_annotation/json_annotation.dart';
import 'package:penger/helpers/formatter/bool_to_int.dart';
import 'package:penger/models/booking_item_model.dart';
import 'package:penger/models/penger_model.dart';

part 'coupon_model.g.dart';

@JsonSerializable()
class Coupon {
  Coupon({
    this.id,
    required this.title,
    this.description,
    this.minCreditPoints,
    this.requiredCreditPoints,
    required this.validFrom,
    required this.validTo,
    required this.quantity,
    required this.isRedeemable,
    this.itemIds,
    this.bookingItems,
    // required this.createdBy,
  });

  // Coupon copyWith({
  //   int? id,
  //   String? title,
  //   String? description,
  //   String? minCreditPoints,
  //   String? requiredCreditPoints,
  //   DateTime? validFrom,
  //   DateTime? validTo,
  //   int? quantity,
  //   bool? isRedeemable,
  // }) {
  //   return Coupon(
  //     id: id,
  //     title: title ?? this.title,
  //     validFrom: validFrom ?? this.validFrom,
  //     validTo: validTo ?? this.validTo,
  //     quantity: quantity ?? this.quantity,
  //     isRedeemable: isRedeemable ?? this.isRedeemable,
  //   );
  // }

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
  Map<String, dynamic> toJson() => _$CouponToJson(this);

  final int? id;
  final String title;
  final String? description;

  // @JsonKey(name: 'created_by')
  // final Penger createdBy;

  @JsonKey(name: 'min_credit_points')
  final double? minCreditPoints;

  @JsonKey(name: 'required_credit_points')
  final double? requiredCreditPoints;

  @JsonKey(name: 'valid_from')
  final String validFrom;

  @JsonKey(name: 'valid_to')
  final String validTo;

  final int quantity;

  @JsonKey(name: 'is_redeemable')
  final bool isRedeemable;

  @JsonKey(name: 'only_to_items', fromJson: null)
  final List<int>? itemIds;

  @JsonKey(name: 'booking_items', toJson: null)
  final List<BookingItem>? bookingItems;
}
