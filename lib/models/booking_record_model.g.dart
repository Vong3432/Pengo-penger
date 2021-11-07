// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingRecord _$BookingRecordFromJson(Map<String, dynamic> json) {
  return BookingRecord(
    id: json['id'] as int,
    bookDate: json['book_date'] == null
        ? null
        : BookDate.fromJson(json['book_date'] as Map<String, dynamic>),
    bookTime: json['book_time'] as String?,
    item: json['item'] == null
        ? null
        : BookingItem.fromJson(json['item'] as Map<String, dynamic>),
    goocardID: json['goo_card_id'] as int,
    pengerID: json['penger_id'] as int,
    goocard: Goocard.fromJson(json['goocard'] as Map<String, dynamic>),
    groupDate: json['group_date'] as String,
    isUsed: json['is_used'] as bool,
    rewardPoint: (json['reward_point'] as num).toDouble(),
  );
}

Map<String, dynamic> _$BookingRecordToJson(BookingRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_date': instance.groupDate,
      'goo_card_id': instance.goocardID,
      'goocard': instance.goocard,
      'penger_id': instance.pengerID,
      'book_time': instance.bookTime,
      'book_date': instance.bookDate,
      'item': instance.item,
      'reward_point': instance.rewardPoint,
      'is_used': instance.isUsed,
    };

BookDate _$BookDateFromJson(Map<String, dynamic> json) {
  return BookDate(
    startDate: json['start_date'] == null
        ? null
        : DateTime.parse(json['start_date'] as String),
    endDate: json['end_date'] == null
        ? null
        : DateTime.parse(json['end_date'] as String),
  );
}

Map<String, dynamic> _$BookDateToJson(BookDate instance) => <String, dynamic>{
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
    };
