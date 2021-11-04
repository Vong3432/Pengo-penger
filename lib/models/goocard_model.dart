import 'package:json_annotation/json_annotation.dart';
import 'package:penger/models/booking_record_model.dart';
import 'package:penger/models/user_model.dart';

part 'goocard_model.g.dart';

@JsonSerializable()
class Goocard {
  const Goocard({
    required this.userId,
    required this.id,
    required this.user,
    this.records,
  });

  factory Goocard.fromJson(Map<String, dynamic> json) =>
      _$GoocardFromJson(json);
  Map<String, dynamic> toJson() => _$GoocardToJson(this);

  final int id;

  @JsonKey(name: 'user_id')
  final int userId;

  final List<BookingRecord>? records;

  final User user;
}
