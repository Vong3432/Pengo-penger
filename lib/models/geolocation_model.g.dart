// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geolocation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Geolocation _$GeolocationFromJson(Map<String, dynamic> json) {
  return Geolocation(
    (json['latitude'] as num).toDouble(),
    (json['longitude'] as num).toDouble(),
    json['name'] as String?,
  );
}

Map<String, dynamic> _$GeolocationToJson(Geolocation instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'name': instance.name,
    };
