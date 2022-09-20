import 'package:json_annotation/json_annotation.dart';

part 'booking_close_date_model.g.dart';

// ignore: constant_identifier_names
enum CloseDateType { ITEM, ORGANIZATION, CATEGORY }

@JsonSerializable()
class BookingCloseDate {
  const BookingCloseDate({
    required this.name,
    this.id,
    this.pengerId,
    required this.from,
    required this.to,
    this.keyId,
    required this.type,
  });

  factory BookingCloseDate.fromJson(Map<String, dynamic> json) =>
      _$BookingCloseDateFromJson(json);
  Map<String, dynamic> toJson() => _$BookingCloseDateToJson(this);

  final int? id;

  @JsonKey(name: 'penger_id')
  final int? pengerId;

  @JsonKey(name: 'key_id')
  final int? keyId;

  final CloseDateType type;
  @JsonKey(name: 'from')
  final DateTime? from;

  @JsonKey(name: 'to')
  final DateTime? to;
  final String name;
}
