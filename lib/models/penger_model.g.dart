// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'penger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Penger _$PengerFromJson(Map<String, dynamic> json) {
  return Penger(
    id: json['id'] as int,
    name: json['name'] as String,
    logo: json['logo'] as String,
    description: json['description'] as String?,
    location: Location.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PengerToJson(Penger instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'description': instance.description,
      'location': instance.location,
    };
