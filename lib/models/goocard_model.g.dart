// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goocard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goocard _$GoocardFromJson(Map<String, dynamic> json) {
  return Goocard(
    userId: json['user_id'] as int,
    id: json['id'] as int,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    records: (json['records'] as List<dynamic>?)
        ?.map((e) => BookingRecord.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GoocardToJson(Goocard instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'records': instance.records,
      'user': instance.user,
    };
