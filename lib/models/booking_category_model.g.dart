// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingCategory _$BookingCategoryFromJson(Map<String, dynamic> json) {
  return BookingCategory(
    isEnabled: json['is_enable'] as bool,
    name: json['name'] as String,
    id: json['id'] as int?,
    pengerId: json['penger_id'] as int?,
    bookingOptions: (json['booking_options'] as List<dynamic>?)
        ?.map((e) => SystemFunction.fromJson(e as Map<String, dynamic>))
        .toList(),
    bookingItems: (json['booking_items'] as List<dynamic>?)
        ?.map((e) => BookingItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BookingCategoryToJson(BookingCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_enable': instance.isEnabled,
      'penger_id': instance.pengerId,
      'name': instance.name,
      'booking_items': instance.bookingItems,
      'booking_options': instance.bookingOptions,
    };
