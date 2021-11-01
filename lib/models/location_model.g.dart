// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    geolocation:
        Geolocation.fromJson(json['geolocation'] as Map<String, dynamic>),
    name: json['name'] as String?,
    address: json['address'] as String?,
    street: json['street'] as String?,
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'geolocation': instance.geolocation,
      'name': instance.name,
      'address': instance.address,
      'street': instance.street,
    };
