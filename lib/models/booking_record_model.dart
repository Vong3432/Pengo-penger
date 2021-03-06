import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:penger/models/booking_item_model.dart';
import 'package:penger/models/goocard_model.dart';

part 'booking_record_model.g.dart';

@JsonSerializable()
class BookingRecord {
  const BookingRecord({
    required this.id,
    required this.bookDate,
    this.bookTime,
    required this.item,
    required this.goocardID,
    required this.pengerID,
    required this.goocard,
    required this.groupDate,
    required this.isUsed,
    required this.rewardPoint,
    required this.formattedBookDateTime,
  });

  factory BookingRecord.fromJson(Map<String, dynamic> json) =>
      _$BookingRecordFromJson(json);
  Map<String, dynamic> toJson() => _$BookingRecordToJson(this);

  final int id;

  @JsonKey(name: 'group_date')
  final String groupDate;

  @JsonKey(name: 'goo_card_id')
  final int goocardID;

  final Goocard goocard;

  @JsonKey(name: 'penger_id')
  final int pengerID;

  @JsonKey(name: 'book_time')
  final String? bookTime;

  @JsonKey(name: 'book_date')
  final BookDate? bookDate;

  @JsonKey(name: 'item')
  final BookingItem? item;

  @JsonKey(name: 'reward_point')
  final double rewardPoint;

  @JsonKey(name: 'is_used')
  final bool isUsed;

  @JsonKey(name: 'formatted_book_datetime')
  final DateTime? formattedBookDateTime;
}

@JsonSerializable()
class BookDate {
  const BookDate({
    required this.startDate,
    required this.endDate,
  });

  factory BookDate.fromJson(Map<String, dynamic> json) =>
      _$BookDateFromJson(json);
  Map<String, dynamic> toJson() => _$BookDateToJson(this);

  @JsonKey(name: "start_date")
  final DateTime? startDate;
  @JsonKey(name: "end_date")
  final DateTime? endDate;
}
